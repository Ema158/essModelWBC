function [tStart,tStartStep,tStop,tStopStep,tSS,tDS,XtStart,XtStartStep,XtStop,XtStopStep,XtSS,XtDS,SupportFoot] = EssModelWbcLipOnlineAccDS(X0,gait_parametersSS,gait_parametersDS,gait_parametersStart,gait_parametersStartStep,gait_parametersStop,gait_parametersStopStep,N,horizon)
global gait_parameters robot nStepDisturbance
global ZMPRef Xref px py
global OutOfWorkSpace

gait_parameters = gait_parametersStart;
time_step = gait_parametersStart.Tmuestreo;
S = gait_parameters.S;
D = gait_parameters.D;
Tstart = gait_parameters.T;
samples = Tstart/time_step;
current_time = 0;
XtStart = zeros(samples+1,length(X0));
XtStart(1,:) = X0';
for i=1:samples
    if OutOfWorkSpace == true
      break;
    end
    timespan = [current_time, current_time + time_step];
    [Xref,ZMPRef] = MpcLIPOnlineV3(gait_parameters,[X0(1);X0(2);X0(13);X0(14)],robot.Zref,robot.ZMax,robot.ZMin,i,robot.Px,robot.Pu);
    px(i) = ZMPRef(1);
    py(i) = ZMPRef(2);
    XtStartAux = ode4(@dynam_HZDMpcOutside,timespan,X0);
    XtStart(i+1,:) = XtStartAux(end,:);
    X0 = XtStartAux(end,:)';
    current_time = current_time + time_step;
end
tStart = 0:time_step:Tstart;

% [robot.Zref,robot.tRef] = ZMPReferenceV3OneStep(horizon,0,S,0,D);
[robot.Zref,robot.tRef] = ZMPReferenceV3OneStepVariableZMPx(horizon,0,S,0,D);
[robot.ZMax,robot.ZMin] = ZMPConstraintsOneStep(horizon,0,S,0,D);
gait_parameters = gait_parametersStartStep;
TstartStep = gait_parameters.T;
X0 = XtStart(end,:)'; 
samples = Tstart/time_step;
current_time = 0;
XtStartStep = zeros(samples+1,length(X0));
XtStartStep(1,:) = X0';
for i=1:samples
    if OutOfWorkSpace == true
      break;
    end
    timespan = [current_time, current_time + time_step];
    [Xref,ZMPRef] = MpcLIPOnlineV3(gait_parameters,[X0(1);X0(2);X0(13);X0(14)],robot.Zref,robot.ZMax,robot.ZMin,i,robot.Px,robot.Pu);
    px(i+samples) = ZMPRef(1);
    py(i+samples) = ZMPRef(2);
    XtStartStepAux = ode4(@dynam_HZDMpcOutside,timespan,X0);
    XtStartStep(i+1,:) = XtStartStepAux(end,:);
    X0 = XtStartStepAux(end,:)';
    current_time = current_time + time_step;
end
tStartStep = 0:time_step:TstartStep;

tSS = cell(1,N);
XtSS = cell(1,N); 
tDS = cell(1,N);
XtDS = cell(1,N); 
SupportFoot = cell(1,N+2);
SupportFootX = 0;
SupportFootY = 0;
gait_parameters = gait_parametersSS;
X0 = XtStartStep(end,:)';  
SupportFoot{1} = [SupportFootX,SupportFootY];
SupportFoot{2} = [SupportFootX,SupportFootY];
SupportFootX = SupportFootX + S;
SupportFootY = SupportFootY + D;
for j=1:N    
    if OutOfWorkSpace == true
      break;
    end
    SupportFoot{j+2} = [SupportFootX,SupportFootY];
    % ====================================================================
    % Computation of one step of the robot: 
    % Previous states before impact -> the Impact and Rellabelling -> Evolution of one step -> states before impact
    % ====================================================================
    if j~=nStepDisturbance
        gait_parametersSS.boolDisturbance=0;
    end
    if j==N
%         [robot.Zref,robot.tRef] = ZMPReferenceV3OneStepStopGait(horizon,0,S,0,D);
        [robot.Zref,robot.tRef] = ZMPReferenceV3OneStepStopGaitZMPVariableX(horizon,0,S,0,D);
        [robot.ZMax,robot.ZMin] = ZMPConstraintsSSStop(horizon,0,S,0,D);
    end
    [tSS{j},tDS{j},XtSS{j},XtDS{j}] = robot_step_EssModel_tAccDS(X0,gait_parametersSS,gait_parametersDS,j); % "robot" and "gait_parameters" structures are needed inside
    % -----------------------------------------------------------------------------------------------------------------
    % Final states:
    X0 = XtDS{j}(end,:)';
    disp('-------------------------------------------');
    % Initial conditions for the Next step
    %-------------------------                    
    SupportFootX = SupportFootX + S;
    if mod(j,2) % If j is impair (for pair steps we add distance D)
        SupportFootY = SupportFootY - D;
    else
        SupportFootY = SupportFootY + D; % We come back to the original position
    end
end
SupportFoot{N+3} = [SupportFootX,SupportFootY];
SupportFoot{N+4} = [SupportFootX,SupportFootY];
gait_parameters = gait_parametersStopStep;
TstopStep = gait_parameters.T;
% X0(1) = X0(1)-S; %x
% X0(2) = -X0(2)+D; %y
% X0(14) = -X0(14); %yp
% X0(25) = -X0(25); %angMomX
% X0(11) = -X0(11); %hipRoll
% X0(23) = -X0(23); %hipRollp

[qfp0,robot] = impact_Pos_Vel(robot,gait_parametersSS.v_foot_f); %
xp0 = qfp0(1);    % Initial velocity in X of the CoM for the new step j+1
yp0 = qfp0(2);    % Initial velocity in Y of the CoM for the new step j+1
q13p0 = qfp0(3); q14p0 = qfp0(4); q15p0 = qfp0(5); q16p0 = qfp0(6); 
q17p0 = qfp0(7); q18p0 = qfp0(8); q19p0 = qfp0(9); q20p0 = qfp0(10);
Rollp0 = qfp0(11); Pitchp0 = qfp0(12); CAMx0 = -X0(25); CAMy0 = X0(26);
Hips = hipsAttitude(robot);
X0 = [robot.CoM(1:2); robot.q(13:16); robot.q(18:21); Hips(1:2)';
    xp0; yp0; q13p0; q14p0; q15p0; q16p0; q17p0; q18p0; q19p0; q20p0; Rollp0; Pitchp0; CAMx0; CAMy0];


[robot.Zref,robot.tRef] = ZMPReferenceV3OneStepStop(horizon,0,0,0,D);
% [robot.ZMax,robot.ZMin] = ZMPConstraintsOneStep(horizon,0,0,0,D);
[robot.ZMax,robot.ZMin] = ZMPConstraintsSSStopStage(horizon,0,0,0,D/2);
samples = TstopStep/time_step;
current_time = 0;
XtStopStep = zeros(samples+1,length(X0));
XtStopStep(1,:) = X0';
for i=1:samples
    if OutOfWorkSpace == true
      break;
    end
    timespan = [current_time, current_time + time_step];
    [Xref,ZMPRef] = MpcLIPOnlineV3(gait_parameters,[X0(1);X0(2);X0(13);X0(14)],robot.Zref,robot.ZMax,robot.ZMin,i,robot.Px,robot.Pu);
    px(i+samples*(j+2)) = ZMPRef(1) + S*(N+1);
    if mod(N,2)==0
        py(i+samples*(j+2)) = -ZMPRef(2) + D;
    else
        py(i+samples*(j+2)) = ZMPRef(2);
    end
    XtStopStepAux = ode4(@dynam_HZDMpcOutside,timespan,X0);
    XtStopStep(i+1,:) = XtStopStepAux(end,:);
    X0 = XtStopStepAux(end,:)';
    current_time = current_time + time_step;
end
tStopStep = 0:time_step:TstopStep;

X0 = XtStopStep(end,:)';  
gait_parameters = gait_parametersStop;
Tstop = gait_parameters.T;
samples = Tstop/time_step;
current_time = 0;
XtStop = zeros(samples+1,length(X0));
XtStop(1,:) = X0';
horizon = samples;
[robot.Zref,robot.tRef] = ZMPReferenceV3DSStop(horizon,0,0,0,D/2);
[robot.ZMax,robot.ZMin] = ZMPConstraintsDSStop(horizon,0,0,0,D/2);
for i=1:samples
    if OutOfWorkSpace == true
      break;
    end
    timespan = [current_time, current_time + time_step];
    [Xref,ZMPRef] = MpcLIPOnlineV3(gait_parameters,[X0(1);X0(2);X0(13);X0(14)],robot.Zref,robot.ZMax,robot.ZMin,i,robot.Px,robot.Pu);
    px(i+samples*(j+3)) = ZMPRef(1) + S*(N+1);
    if mod(N,2)==0
        py(i+samples*(j+3)) = -ZMPRef(2) + D;
    else
        py(i+samples*(j+3)) = ZMPRef(2);
    end
    XtStopAux = ode4(@dynam_HZDMpcOutside,timespan,X0);
    XtStop(i+1,:) = XtStopAux(end,:);
    X0 = XtStopAux(end,:)';
    current_time = current_time + time_step;
end
tStop = 0:time_step:Tstop;