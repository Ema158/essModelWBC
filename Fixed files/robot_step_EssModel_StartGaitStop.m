function [tStart,tStartStep,tStop,tStopStep,t,XtStart,XtStartStep,XtStop,XtStopStep,Xt,SupportFoot] = robot_step_EssModel_StartGaitStop(X0,gait_parameters_gait,gait_parametersStart,gait_parametersStartStep,gait_parametersStop,gait_parametersStopStep,N)
global gait_parameters
global tref XrefLip ZMPrefLip
figure(5)
plot(tref,XrefLip(1,:),'k')
hold on
figure(6)
plot(tref,XrefLip(3,:),'k')
hold on
figure(7)
plot(tref,XrefLip(6,:),'k')
hold on
gait_parameters = gait_parametersStart;
Tstart = gait_parameters.T;
% XtStart = ode4(@dynam_HZDtimeLipReference,0:1e-3:Tstart,X0);
% tStart = 0:1e-3:Tstart;
[tStart,XtStart] = ode45(@dynam_HZDtimeLipReference,0:1e-3:Tstart,X0);
XppStart = zeros(length(tStart),24);
% for i=1:length(tStart)
%     XppStart(i,:) = dynam_HZDtimeLipReference(tStart(i),XtStart(i,:)');
% end
[~,~,k] = evaluateXrefPoly(XrefLip,ZMPrefLip,tref,tStart(end));
XrefLip = XrefLip(:,k:end);
ZMPrefLip = ZMPrefLip(:,k:end);
tref = tref(k:end) - tStart(end);
gait_parameters = gait_parametersStartStep;
TstartStep = gait_parameters.T;
S = gait_parameters.S;
D = gait_parameters.D;
% X_final = [xf;yf;q13f;q14f;q15f;q16f;q17f;q18f;q19f;q20f;Rollf;Pitchf;...
%                xpf;ypf;q13pf;q14pf;q15pf;q16pf;q17pf;q18pf;q19pf;q20pf;Rollpf;Pitchpf]; % previous step
X_final = XtStart(end,:)';           
[tStartStep,XtStartStep] = ode45(@dynam_HZDtimeLipReference,0:1e-3:TstartStep,X_final);
XppStartStep = zeros(length(tStartStep),24);
% for i=1:length(tStartStep)
%     XppStartStep(i,:) = dynam_HZDtimeLipReference(tStartStep(i),XtStartStep(i,:)');
% end
t = cell(1,N);
Xt = cell(1,N); 
Ex = cell(1,N); 
Ey = cell(1,N); 
L = cell(1,N);
zt = cell(1,N);
zpt = cell(1,N);
SupportFoot = cell(1,N+2);
% g = gait_parameters.g;
% z0 = gait_parameters.z_i;
% omega = sqrt(g/z0); % the units are:  sqrt((m/s^2)/m) = 1/s
SupportFootX = 0;
SupportFootY = 0;
gait_parameters = gait_parameters_gait;
X_final = XtStartStep(end,:)';  
[~,~,k] = evaluateXrefPoly(XrefLip,ZMPrefLip,tref,tStartStep(end));
XrefLip = XrefLip(:,k:end);
ZMPrefLip = ZMPrefLip(:,k:end);
tref = tref(k:end) - tStartStep(end);
%Cambio de marco
XrefLip(1,:) = XrefLip(1,:) - S;
XrefLip(4,:) = -XrefLip(4,:) + D;
XrefLip(5,:) = -XrefLip(5,:);
XrefLip(6,:) = -XrefLip(6,:);
ZMPrefLip(1,:) = ZMPrefLip(1,:) - S;
ZMPrefLip(2,:) = -ZMPrefLip(2,:) + D;
SupportFoot{1} = [SupportFootX,SupportFootY];
SupportFoot{2} = [SupportFootX,SupportFootY];
SupportFootX = SupportFootX + S;
SupportFootY = SupportFootY + D;
XppGait = cell(1,N);
for j=1:N    
    SupportFoot{j+2} = [SupportFootX,SupportFootY];
    
    % ====================================================================
    % Computation of one step of the robot: 
    % Previous states before impact -> the Impact and Rellabelling -> Evolution of one step -> states before impact
    % ====================================================================
    [t{j},X0,Xt{j}] = robot_step_EssModel_t(X_final); % "robot" and "gait_parameters" structures are needed inside
%     for i=1:length(t{j})
%         XppGait{j}(i,:) = dynam_HZDtimeLipReference(t{j}(i),Xt{j}(i,:)');
%     end
    % Initial (current step) after impact
    x0 = X0(1); 
    y0 = X0(2);
    xp0 = X0(13);
    yp0 = X0(14);
    % Final states:
    xt = Xt{j}(:,1);   % Solution of position in X of the CoM for step j
    yt = Xt{j}(:,2);   % Solution of position in Y of the CoM for step j
    xpt = Xt{j}(:,13);  % Solution of velocity in X of the CoM for step j
    ypt = Xt{j}(:,14);  % Solution of velocity in Y of the CoM for step j
    % -----------------------------------------------------------------------------------------------------------------
    
    % IMPORTANT: IN THIS PART of the CODE IS JUST FOR VISUALIZATION for the trajectory of the Desired ZMP.
    %            The REAL evolution of the ZMP will be obtained by runing code "M20_..." =)
    % Evolution of the ZMP 
    
    % Final states:
    X_final = Xt{j}(end,:)';
    disp('-------------------------------------------');
    % Initial conditions for the Next step
    %-------------------------                    
    SupportFootX = SupportFootX + S;
    if mod(j,2) % If j is impair (for pair steps we add distance D)
        SupportFootY = SupportFootY - D;
    else
        SupportFootY = SupportFootY + D; % We come back to the original position
    end
        [~,~,k] = evaluateXrefPoly(XrefLip,ZMPrefLip,tref,t{j}(end));
        XrefLip = XrefLip(:,k:end);
        ZMPrefLip = ZMPrefLip(:,k:end);
        tref = tref(k:end) - t{j}(end);
        %Cambio de marco
        XrefLip(1,:) = XrefLip(1,:) - S;
        XrefLip(4,:) = -XrefLip(4,:) + D;
        XrefLip(5,:) = -XrefLip(5,:);
        XrefLip(6,:) = -XrefLip(6,:);
        ZMPrefLip(1,:) = ZMPrefLip(1,:) - S;
        ZMPrefLip(2,:) = -ZMPrefLip(2,:) + D;
end
SupportFoot{N+3} = [SupportFootX,SupportFootY];
SupportFoot{N+4} = [SupportFootX,SupportFootY];
gait_parameters = gait_parametersStopStep;
TstopStep = gait_parameters.T;
X_final(1) = X_final(1)-S;
X_final(2) = -X_final(2)+D;
X_final(14) = -X_final(14);
[tStopStep,XtStopStep] = ode45(@dynam_HZDtimeLipReference,0:1e-3:TstopStep,X_final);
XppStopStep = zeros(length(tStopStep),24);
% for i=1:length(tStartStep)
%     XppStopStep(i,:) = dynam_HZDtimeLipReference(tStopStep(i),XtStopStep(i,:)');
% end
[~,~,k] = evaluateXrefPoly(XrefLip,ZMPrefLip,tref,tStopStep(end));
XrefLip = XrefLip(:,k:end);
ZMPrefLip = ZMPrefLip(:,k:end);
tref = tref(k:end) - tStart(end);
X_final = XtStopStep(end,:)';  
gait_parameters = gait_parametersStop;
Tstop = gait_parameters.T;
[tStop,XtStop] = ode45(@dynam_HZDtimeLipReference,0:1e-3:Tstop,X_final);
XppStop = zeros(length(tStop),24);
% for i=1:length(tStop)
%     XppStop(i,:) = dynam_HZDtimeLipReference(tStop(i),XtStop(i,:)');
% end
figure(5)
plot(tStart,XtStart(:,1),'r')
plot(tStart(end)+tStartStep,XtStartStep(:,1),'r')
for j=1:N
    plot(tStart(end)+tStartStep(end)+gait_parameters_gait.T*(j-1)+t{j},Xt{j}(:,1)+S*(j),'r')
end
plot(tStart(end)+tStartStep(end)+gait_parameters_gait.T*(N)+tStopStep,XtStopStep(:,1)+S*(N+1),'r')
plot(tStart(end)+tStartStep(end)+gait_parameters_gait.T*(N)+tStopStep(end)+tStop,XtStop(:,1)+S*(N+1),'r')
%
% figure(6)
% plot(tStart,XppStart(:,13),'r')
% plot(tStart(end)+tStartStep,XppStartStep(:,13),'r')
% for j=1:N
%     plot(tStart(end)+tStartStep(end)+gait_parameters_gait.T*(j-1)+t{j},XppGait{j}(:,13),'r')
% end
% plot(tStart(end)+tStartStep(end)+gait_parameters_gait.T*(N)+tStopStep,XppStopStep(:,13),'r')
% plot(tStart(end)+tStartStep(end)+gait_parameters_gait.T*(N)+tStopStep(end)+tStop,XppStop(:,13),'r')
% figure(7)
% plot(tStart,XppStart(:,14),'r')
% plot(tStart(end)+tStartStep,XppStartStep(:,14),'r')
% for j=1:N
%     if mod(j,2)==true
%         plot(tStart(end)+tStartStep(end)+gait_parameters_gait.T*(j-1)+t{j},-XppGait{j}(:,14),'r')
%     else
%         plot(tStart(end)+tStartStep(end)+gait_parameters_gait.T*(j-1)+t{j},XppGait{j}(:,14),'r')
%     end
% end
% plot(tStart(end)+tStartStep(end)+gait_parameters_gait.T*(N)+tStopStep,XppStopStep(:,14),'r')
% plot(tStart(end)+tStartStep(end)+gait_parameters_gait.T*(N)+tStopStep(end)+tStop,XppStop(:,14),'r')


