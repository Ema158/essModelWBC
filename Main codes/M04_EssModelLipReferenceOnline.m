close all;
clear all
clc
% ---------------------------------------------------------------------------------------------
currentfolder = pwd; % save current path
cd ..                % go one folder down (go out of the current folder and stay in the previous one)
add_paths;           % add all folders where all files are founded in order to acces to them
cd(currentfolder);   % return to the original path
% ---------------------------------------------------------------------------------------------

echo on
% Testing Essential dynamics
% ==============================
% Creation: 13/Jul/2024
% Last modification: -/--/--
% --------------------------------------------------------------------------------------------------
% Walking of a Essential with free hips and arms motion following a
% reference obtained by the LIP model.
% -----------------------------------------------------------------------------------------------------
% --------------------------------------------------------------------------------------------------
% 
%
echo off

global gait_parameters
global robot coms
coms=1;

% Parameters
% ---------------------------------------------------------
% Nao_param = ParamEssPeriodic();
Nao_param = ParamQPLIP();
Nao_paramStart = ParamQPLIPStart();
Nao_paramStartStep = ParamQPLIPStartSS();
Nao_paramStop = ParamQPLIPStop();
Nao_paramStopStep = ParamQPLIPStopSS();
% ---------------------------------------------------------
gait_parameters = Nao_param.gait_parameters;
gait_parametersStart = Nao_paramStart.gait_parameters;
gait_parametersStartStep = Nao_paramStartStep.gait_parameters;
gait_parametersStop = Nao_paramStop.gait_parameters;
gait_parametersStopStep = Nao_paramStopStep.gait_parameters;

T = gait_parameters.T;
g = gait_parameters.g;
z0 = gait_parameters.z_i;
S = gait_parameters.S;
D = gait_parameters.y_ffoot_i;

% CHOSING CONTROLLED VARIABLE FILES
% -------------------------------------------------------------------------------------------------
global OptionContVar  % Option to chose the controlled variables "hd", "hpd" and "hppd"
% 1 -> Controlled variables defined by polynomials w.r.t. time, IMPACT is considered. Files: "hd_Polyn", "hpd_Polyn_t" and "hppd_Polyn_t". 
% 2 -> Controlled variables defined by cycloidal motion w.r.t. time, IMPACT is NOT considered. Files: "hd_CycMotion_t", "hpd_CycMotion_t" and "hppd_CycMotion_t". 
% 3 -> Controlled variables defined by polynomials w.r.t. "x" of the CoM, IMPACT is considered. Files: "hd_Polyn", "hpd_Polyn_x" and "hppd_Polyn_x". 
OptionContVar = Nao_param.ControlledVariableOption;
% -------------------------------------------------------------------------------------------------

% GENERAL OPTIONS
% ----------------------------------------------------
DataName = 'InfoNAO_Param_t_10prueba3';
Animation = false;  % Do you want to show the animation?
n = 8; % number of SAMPLES for each step of the animation
LineWidth = 2;  % For plots and animation
FontSize = 14;  % For plots and animation 
produceVideo = true;   % Do you want to produce a video? (if animation if false no video will be produced)
framerate = (n/T)/3; % with n/T the real time duration of the video will be T, the last divition will produce
                    %  a duration of video "factor*T". For example if T=0.5, " (n/T)/3" will produce a video of 1.5 sec 
% ----------------------------------------------------
N = 3; % number of steps
% Initial support for the first step
SupportFootX = 0;
SupportFootY = 0;
ZMPd = cell(1,N+1);

% Final conditions for the step 0
% Cyclic motions:
% -------------------------------------------------------------------------------------------------------------------
Rcyc = Nao_param.Rcyc;

% If NO error in the velocity is desired, chose "Error = 0"
Error = 0.0; % Percentage of error   <-------
if Error ~= 0
    fprintf('Motion started OUTSIDE the periodic motion, with an error in velocity of %.2f %%\n',Error*100)
    disp('-----------------------------------------------------------------------------------')
end
% ----------------------------------
Dx = Rcyc(1);
Dy = Rcyc(2);
xpf = Rcyc(13)*(1+Error);
ypf = Rcyc(14)*(1+Error);
% Initial and final position is computed as 
x0 = Dx;
y0 = D/2 - Dy;
xf = S/2 + Dx;
yf = D/2 + Dy;
q13f = Rcyc(3); q14f = Rcyc(4); q15f = Rcyc(5); q16f = Rcyc(6); q17f = Rcyc(7); q18f = Rcyc(8); q19f = Rcyc(9); q20f = Rcyc(10); Rollf = Rcyc(11); Pitchf = Rcyc(12);
q13pf = Rcyc(15); q14pf = Rcyc(16); q15pf = Rcyc(17); q16pf = Rcyc(18); q17pf = Rcyc(19); q18pf = Rcyc(20); q19pf = Rcyc(21); q20pf = Rcyc(22); Rollpf = Rcyc(23); Pitchpf = Rcyc(24);
% Display information
% ----------------------------------------------------
disp('Information for each step');
disp('==========================');
fprintf('Step length S: %d\n',S);
fprintf('Step width D: %d\n',D);
fprintf('Step time T: %d\n',T);
disp('-------------------------------------------');

%% Parameteres and initialization of ROMEO
% ======================================================================================
global alphaM % alphaM = [0-1]. Allow to remove gradually the value of all masses and inertias of the robot
% alphaM = 0 -> all masses are 0 -> all mass is concentrated in one point
% alphaM = 1 -> all masses are normal -> all masses are distributed
alphaM = 1;
if alphaM == 0
    fprintf('All mass concentred in ONE point (as a 3DLIP), i.e. alphaM = %f\n',alphaM)
elseif alphaM == 1
    fprintf('All masses distributed (as it should be), i.e. alphaM = %f\n',alphaM)
else
    fprintf('Masses distributed taking into account alphaM = %f . If alphaM -> 0 all masses will be concentred in ONE point\n',alphaM)
end
% ------------------------------------------------------------------------------------

% Generating the robot structure
horizon = round(T/gait_parameters.Tmuestreo);
robot = genebotV2(gait_parameters,horizon);
horizon = round(T/gait_parameters.Tmuestreo);
[robot.Zref,robot.tRef] = ZMPReferenceV2(N,horizon,S,D);
% Computation of the initial coefficients the polinomial trajectories for the controlled variables. 
% These coefficients are changed inmediately after the transition (really necessary when there is an impact)
gait_parameters.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_ver2(robot,gait_parameters);
gait_parameters.PolyCoeff = PolyCoeff;
%
gait_parametersStart.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_ver2(robot,gait_parametersStart);
gait_parametersStart.PolyCoeff = PolyCoeff;
%
gait_parametersStartStep.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_ver2(robot,gait_parametersStartStep);
gait_parametersStartStep.PolyCoeff = PolyCoeff;
%
gait_parametersStop.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_ver2(robot,gait_parametersStop);
gait_parametersStop.PolyCoeff = PolyCoeff;
%
gait_parametersStopStep.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_ver2(robot,gait_parametersStopStep);
gait_parametersStopStep.PolyCoeff = PolyCoeff;
% OPTION - For plotting of the evolution of the CoM in "PEvents.m" file (while the solver is working on the dynamics)
% ===========================================================================================================
% % If we do not want to plot anything we can uncomment these lines:
% global contC  
% global Stop   % 1-> If we want to pause the simulationn each time "PEvents" is executed
% contC = 1;    % It is used to create a vector that stores all the point of the CoM each time "PEvents" is executed
% Stop = 0;     % 1-> Each time  "PEvents" is executed the simulation will stop and it will wait until you press a key to continue
% % NOTE If we want that the solver shows who many iterations have been performed we must define "contB"
global DisplayIterNumber  % To show how many iteration have been performed by the solver 
DisplayIterNumber = 1;
% global contA  % To create one figure each time a cycle is carried out (this variable is more useful be inside "Cycle" function)
% contA = 1;
% % ====================================================================

%% Continue...
fprintf('Initial states final states of the CoM: \n[xf yf xpf ypf] = [%f,%f,%f,%f]\n',xf,yf,xpf,ypf);
disp('-------------------------------------------');
gait_parameters_gait = gait_parameters;
X_final = [0;D/2;q13f;q14f;q15f;q16f;q17f;q18f;q19f;q20f;Rollf;Pitchf;...
               xpf;ypf;q13pf;q14pf;q15pf;q16pf;q17pf;q18pf;q19pf;q20pf;Rollpf;Pitchpf];
[tStart,tStartStep,tStop,tStopStep,t,XtStart,XtStartStep,XtStop,XtStopStep,Xt,SupportFoot] = EssModelWbcLipOnline(X_final,gait_parameters_gait,gait_parametersStart,gait_parametersStartStep,gait_parametersStop,gait_parametersStopStep,N,robot,horizon);
%% =====================================
% Plots
% =============
% States for all the trajectory
xtAll = [];
ytAll = [];
ztAll = [];
xptAll = [];
yptAll = [];
zptAll = [];
tAll = [];
ExAll = [];
EyAll = [];
LAll = [];

% Sampled states for all the trajectory
xsAll = [];
ysAll = [];
zsAll = [];
xpsAll = [];
ypsAll = [];
zpsAll = [];
tsAll = [];

% To determine the maximum and minimum value of the CoM position to determine the dimension of the animation of the plot
% ------------------------------------------------------------------------------------------------------------
maxPosX = (N+3)*S;
minPosX = -S;
maxPosY = D+0.05;
minPosY = -D-0.05;

% ------------------------------------------------------------------------------------------------------------
% Building of trajectories for all the steps and animation
% ---------------------------------------------
if Animation && produceVideo
    writerobj = VideoWriter(strcat(['ReducedModel_',DataName],'.avi'));
    writerobj.FrameRate = framerate; % The smaller FrameRate the slower the video (Frames per second)
    open(writerobj);    
    disp('Making a video...')    
end
ZMPdS = cell(1,N);
XtStartAll = [XtStart;XtStartStep];
tStartAll = [tStart;tStart(end)+tStartStep];
XtStopAll = [XtStopStep;XtStop];
tStopAll = [tStopStep;tStopStep(end)+tStop];
for j=1:(N+4)
    if j==1
        xt = SupportFoot{j}(1) +  XtStart(:,1)';  % global position of x(t) for step "j"
        yt = SupportFoot{j}(2) + XtStart(:,2)'; % global position of y(t) for step "j"
        ypt = XtStart(:,14)';
        xpt = XtStart(:,13)';                       % xp(t) for step "j"     
        tG = tStart';  % tG is the global time for all the steps
        samples = length(tStart);
        ZMPxCoeff = gait_parametersStart.ZMPxCoeff;
        ZMPyCoeff = gait_parametersStart.ZMPyCoeff;
        ZMPdX = zeros(1,samples);
        ZMPdY = zeros(1,samples);
        for i=1:samples
            ZMPdX(i) = polyval(ZMPxCoeff,tStart(i));
            zt{j}(i) = polyval(gait_parametersStart.PolyCoeff.hd1,tStart(i));
            zpt{j}(i) = polyval(polyder(gait_parametersStart.PolyCoeff.hd1),tStart(i));
            if mod(j,2) % If j is impair (for pair steps the evoluition is the opossite direction)
                ZMPdY(i) = polyval(ZMPyCoeff,tStart(i));
            else % pair step
                ZMPdY(i) = -polyval(ZMPyCoeff,tStart(i));
            end
        end
        ZMPd{j}(1,:) = SupportFoot{j}(1) + ZMPdX;
        ZMPd{j}(2,:) = SupportFoot{j}(2) + ZMPdY;
    end
    if j==2
        xt = SupportFoot{j}(1) +  XtStartStep(:,1)';  % global position of x(t) for step "j"
        yt = SupportFoot{j}(2) + XtStartStep(:,2)'; % global position of y(t) for step "j"
        ypt = XtStartStep(:,14)';
        xpt = XtStartStep(:,13)';                       % xp(t) for step "j"     
        tG = tStart(end) + tStartStep';  % tG is the global time for all the steps
        samples = length(tStartStep);
        ZMPxCoeff = gait_parametersStartStep.ZMPxCoeff;
        ZMPyCoeff = gait_parametersStartStep.ZMPyCoeff;
        ZMPdX = zeros(1,samples);
        ZMPdY = zeros(1,samples);
        for i=1:samples
            ZMPdX(i) = polyval(ZMPxCoeff,tStartStep(i));
            zt{j}(i) = polyval(gait_parametersStartStep.PolyCoeff.hd1,tStartStep(i));
            zpt{j}(i) = polyval(polyder(gait_parametersStartStep.PolyCoeff.hd1),tStartStep(i));
            if mod(j,2) % If j is impair (for pair steps the evoluition is the opossite direction)
                ZMPdY(i) = polyval(ZMPyCoeff,tStartStep(i));
            else % pair step
                ZMPdY(i) = -polyval(ZMPyCoeff,tStartStep(i));
            end
        end
        ZMPd{j}(1,:) = SupportFoot{j}(1) + ZMPdX;
        ZMPd{j}(2,:) = SupportFoot{j}(2) + ZMPdY;
    end
    if j~=1 && j~=2 && j~=N+3 && j~=N+4
        xt = SupportFoot{j}(1) +  Xt{j-2}(:,1)';  % global position of x(t) for step "j"
        if mod(j,2)==false % If j is impair (for pair steps we add distance D and invert direction)    
            yt = SupportFoot{j}(2) + Xt{j-2}(:,2)'; % global position of y(t) for step "j"
            ypt = Xt{j-2}(:,14)';                       % global velocity yp(t) for step "j" 
        else
            yt = SupportFoot{j}(2) - Xt{j-2}(:,2)';  % global position of y(t) for step "j"
            ypt = -Xt{j-2}(:,14)';                       % global velocity yp(t) for step "j" 
        end
        xpt = Xt{j-2}(:,13)';                       % xp(t) for step "j"     
        tG = tStartAll(end) + (j-3)*T  + t{j-2}';  % tG is the global time for all the steps
        samples = length(t{j-2});
        ZMPxCoeff = gait_parameters_gait.ZMPxCoeff;
        ZMPyCoeff = gait_parameters_gait.ZMPyCoeff;
        ZMPdX = zeros(1,samples);
        ZMPdY = zeros(1,samples);
        for i=1:samples
            ZMPdX(i) = polyval(ZMPxCoeff,t{j-2}(i));
            zt{j}(i) = polyval(gait_parameters_gait.PolyCoeff.hd1,t{j-2}(i));
            zpt{j}(i) = polyval(polyder(gait_parameters_gait.PolyCoeff.hd1),t{j-2}(i));
            if mod(j,2) % If j is impair (for pair steps the evoluition is the opossite direction)
                ZMPdY(i) = polyval(ZMPyCoeff,t{j-2}(i));
            else % pair step
                ZMPdY(i) = -polyval(ZMPyCoeff,t{j-2}(i));
            end
        end
        ZMPd{j}(1,:) = SupportFoot{j}(1) + ZMPdX;
        ZMPd{j}(2,:) = SupportFoot{j}(2) + ZMPdY;
    end
    if j==N+3
        xt = SupportFoot{j}(1) +  XtStopStep(:,1)';  % global position of x(t) for step "j"
        if mod(j,2)==false % If j is impair (for pair steps we add distance D and invert direction)    
            yt = SupportFoot{j}(2) + XtStopStep(:,2)'; % global position of y(t) for step "j"
            ypt = XtStopStep(:,14)';                       % global velocity yp(t) for step "j" 
        else
            yt = SupportFoot{j}(2) - XtStopStep(:,2)';  % global position of y(t) for step "j"
            ypt = -XtStopStep(:,14)';                       % global velocity yp(t) for step "j" 
        end
        xpt = XtStopStep(:,13)';                       % xp(t) for step "j"     
        tG = tStartAll(end) + (j-3)*T  + tStopStep';  % tG is the global time for all the steps
        samples = length(tStopStep);
        ZMPxCoeff = gait_parametersStopStep.ZMPxCoeff;
        ZMPyCoeff = gait_parametersStopStep.ZMPyCoeff;
        ZMPdX = zeros(1,samples);
        ZMPdY = zeros(1,samples);
        for i=1:samples
            ZMPdX(i) = polyval(ZMPxCoeff,tStopStep(i));
            zt{j}(i) = polyval(gait_parametersStopStep.PolyCoeff.hd1,tStopStep(i));
            zpt{j}(i) = polyval(polyder(gait_parametersStopStep.PolyCoeff.hd1),tStopStep(i));
            if mod(j,2) % If j is impair (for pair steps the evoluition is the opossite direction)
                ZMPdY(i) = polyval(ZMPyCoeff,tStopStep(i));
            else % pair step
                ZMPdY(i) = -polyval(ZMPyCoeff,tStopStep(i));
            end
        end
        ZMPd{j}(1,:) = SupportFoot{j}(1) + ZMPdX;
        ZMPd{j}(2,:) = SupportFoot{j}(2) + ZMPdY;
    end
    if j==N+4
        xt = SupportFoot{j}(1) +  XtStop(:,1)';  % global position of x(t) for step "j"
        if mod(j,2) % If j is impair (for pair steps we add distance D and invert direction)    
            yt = SupportFoot{j}(2) + XtStop(:,2)'; % global position of y(t) for step "j"
            ypt = XtStop(:,14)';                       % global velocity yp(t) for step "j" 
        else
            yt = SupportFoot{j}(2) - XtStop(:,2)';  % global position of y(t) for step "j"
            ypt = -XtStop(:,14)';                       % global velocity yp(t) for step "j" 
        end
        xpt = XtStop(:,13)';                       % xp(t) for step "j"     
        tG = tStartAll(end) + (j-4)*T  + tStopStep(end) + tStop';  % tG is the global time for all the steps
        samples = length(tStop);
        ZMPxCoeff = gait_parametersStop.ZMPxCoeff;
        ZMPyCoeff = gait_parametersStop.ZMPyCoeff;
        ZMPdX = zeros(1,samples);
        ZMPdY = zeros(1,samples);
        for i=1:samples
            ZMPdX(i) = polyval(ZMPxCoeff,tStop(i));
            zt{j}(i) = polyval(gait_parametersStop.PolyCoeff.hd1,tStop(i));
            zpt{j}(i) = polyval(polyder(gait_parametersStop.PolyCoeff.hd1),tStop(i));
            if mod(j,2) % If j is impair (for pair steps the evoluition is the opossite direction)
                ZMPdY(i) = polyval(ZMPyCoeff,tStop(i));
            else % pair step
                ZMPdY(i) = -polyval(ZMPyCoeff,tStop(i));
            end
        end
        ZMPd{j}(1,:) = SupportFoot{j}(1) + ZMPdX;
        ZMPd{j}(2,:) = SupportFoot{j}(2) + ZMPdY;
    end
    % ===============================================================
    %     Variables for animation
    % ===============================================================
    if Animation                
        % Sampled variables
        OnesRowVectS = ones(1,n);
        if j==1
            Xs = sampling(XtStart',n); % Xs is the sampled evolution of the CoM  for step "j" in the LOCAL frame attached to the support foot
            ts = sampling(tStart',n);  % ts is the sampled time for all the steps
        end
        if j==2
            Xs = sampling(XtStartStep',n); % Xs is the sampled evolution of the CoM  for step "j" in the LOCAL frame attached to the support foot
            ts = sampling(tStartStep',n);  % ts is the sampled time for all the steps
        end
        if j~=1 && j~=2 && j~=N+3 && j~=N+4
            Xs = sampling(Xt{j-2}',n); % Xs is the sampled evolution of the CoM  for step "j" in the LOCAL frame attached to the support foot
            ts = sampling(tStartAll(end) + (j-2)*T  + t{j-2}',n);  % ts is the sampled time for all the steps
        end
        if j==N+3
            Xs = sampling(XtStopStep',n); % Xs is the sampled evolution of the CoM  for step "j" in the LOCAL frame attached to the support foot
            ts = sampling(tStartAll(end) + (j-3)*T  + tStopStep',n);  % ts is the sampled time for all the steps
        end
        if j==N+4
            Xs = sampling(XtStop',n); % Xs is the sampled evolution of the CoM  for step "j" in the LOCAL frame attached to the support foot
            ts = sampling(tStartAll(end) + (j-4)*T  + tStopStep(end) + tStop',n);  % ts is the sampled time for all the steps
        end
        ZMPdS{j} = sampling(ZMPd{j},n);  % ZMPdS is the sampled ZMP for each step;
        xs = SupportFoot{j}(1) + Xs(1,:); % Sampled position of the CoM in X for step "j" in the WORLD frame
        if mod(j,2) % If j is impair (for pair steps we add distance D and invert direction)
            ys = SupportFoot{j}(2) + Xs(2,:); % Sampled position of the CoM in Y for step "j" in the WORLD frame
        else
            ys = SupportFoot{j}(2) - Xs(2,:); % Sampled position of the CoM in Y for step "j" in the WORLD frame
        end
        xps = Xs(13,:);                      % Sampled velocity in X of the CoM for step "j"
        yps = Xs(14,:);                      % Sampled velocity in Y of the CoM for step "j"
        zs = sampling(zt{j},n); % Xs is the sampled evolution of the CoM  for step "j" in the LOCAL frame attached to the support foot           
%         zps = Xs(6,:);
        % zs = z0*OnesRowVectS;
        
        % Colors for plots % color = [R,G,B];
        % ------------------------------------
        color = rand(1,3); % Random Color
        
        xsAll = [xsAll xs];
        ysAll = [ysAll ys];
        zsAll = [zsAll zs];
        CoMIniEndPos{j} = [xs(1),ys(1),zs(1),xs(end),ys(end),zs(end)];
        for i=1:n
            fig = figure (1);
            % if we want to draw all the trace of the pendulum we must put it "on"
            hold off
            plot3([ZMPdS{j}(1,i),xs(i)],[ZMPdS{j}(2,i),ys(i)],[0,zs(i)],'-ko');
            hold on
            % The next part draw the initial and final position of the pendulum for each step
            % ------------------------------------------------------------------------------------
            for k=1:j
                % Initial position
                plot3([ZMPd{k}(1,1),CoMIniEndPos{k}(1,1)],[ZMPd{k}(2,1),CoMIniEndPos{k}(1,2)],[0,CoMIniEndPos{k}(1,3)],'--o', 'color',[0.68,0.47,0]);
                % Final position
                if k~=j % It doesn't draw the final position of the pendulum until the next step
                    plot3([ZMPd{k}(1,end),CoMIniEndPos{k}(1,4)],[ZMPd{k}(2,end),CoMIniEndPos{k}(1,5)],[0,CoMIniEndPos{k}(1,6)],'--o', 'color',[0.48,0.06,0.89]);
                end
                % Trajectory of the ZMP                
                if k<j
                    plot3(ZMPdS{k}(1,:),ZMPdS{k}(2,:),0*OnesRowVectS,'LineWidth',LineWidth);
                else
                    plot3(ZMPdS{k}(1,1:i),ZMPdS{k}(2,1:i),0*(1:i),'LineWidth',LineWidth);
                end
            end
            % Trajectory of the CoM
            plot3(xsAll(1:i+(j-1)*n),ysAll(1:i+(j-1)*n),zsAll(1:i+(j-1)*n),'color',color,'LineWidth',LineWidth)
            axis([minPosX,maxPosX,minPosY,maxPosY,0,0.4]); % axis([x0,xf,y0,yf,z0,zf]);
            xlabel('x [m]','interpreter','Latex','FontSize',FontSize);
            ylabel('y [m]','interpreter','Latex','FontSize',FontSize);
            zlabel('z [m]','interpreter','Latex','FontSize',FontSize);
            title(['t = ' num2str(ts(i)) ' [sec]']);
            grid on
            if  produceVideo
                writeVideo(writerobj,getframe(fig));
            end 
            pause(0.5)
        end        
        % Sampled states for all the trajectory
        xpsAll = [xpsAll xps];
        ypsAll = [ypsAll yps];
%         zpsAll = [zpsAll zps];
        tsAll = [tsAll ts];
        
    end
    % ===============================================================
    % States for all the trajectory
    xtAll = [xtAll xt];
    xptAll = [xptAll xpt];
    ytAll = [ytAll yt];
    yptAll = [yptAll ypt];  
    ztAll = [ztAll zt{j}];
    zptAll = [zptAll zpt{j}];
    tAll = [tAll;tG];
%     ExAll = [ExAll Ex{j}'];                  % ExAll is the orbital energy in X for all the steps
%     EyAll = [EyAll Ey{j}'];                  % ExAll is the orbital energy in Y for all the steps
%     LAll = [LAll L{j}'];                     % LAll is the synchronization measure for all the steps
end
if Animation && produceVideo
    close(writerobj);
    disp('Video produced successfully')
    disp('------------------------------')
end

%% Storing all the parameters and information of this simulation
% =====================================================================
Solution.t = t;
Solution.Xt = Xt;
Solution.XtStart = XtStart;
Solution.XtStartStep = XtStartStep;
Solution.XtStopStep = XtStopStep;
Solution.XtStop = XtStop;
Solution.tStart = tStart;
Solution.tStartStep = tStartStep;
Solution.tStopStep = tStopStep;
Solution.tStop = tStop;
% Solution.ZMPrefLip = ZMPrefLipCopy;

% Solution.XtAll = [tAll, xtAll', ytAll', xptAll', yptAll', ztAll', zptAll'];
% if Animation
%     Solution.XSampledAll = [tsAll', xsAll', ysAll', xpsAll', ypsAll', zsAll', zpsAll'];
% end
Solution.SupportFootPos = SupportFoot;
Solution.zt = zt;
% Build just ONE structure with all the information
InfNAO.robot = robot;
% % InfNAO.iniParameters = initParam;
InfNAO.gait_parameters_gait = gait_parameters_gait;
InfNAO.gait_parametersStart = gait_parametersStart;
InfNAO.gait_parametersStartStep = gait_parametersStartStep;
InfNAO.gait_parametersStop = gait_parametersStop;
InfNAO.gait_parametersStopStep = gait_parametersStopStep;
InfNAO.Solution = Solution;
disp(['Saving data as: ' DataName]);
disp('------------------------------');
save(DataName,'InfNAO')

%% =====================================================================
% Evolution of the position and velocity CoM in X w.r.t. time
% ---------------------------------------------
figure (2)
subplot(3,1,1)  
hold on
plot(tAll,xtAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$x(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(tAll,xptAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{x}(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);
% subplot(3,1,3)  
% hold on
% plot(tAll,ExAll,'color','k','LineWidth',LineWidth)
% axis([min(tAll) max(tAll) -inf inf])
% xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
% ylabel('$E_x(t)$ ','interpreter','Latex','FontSize',FontSize);

% Evolution of the position and velocity CoM in Y w.r.t. time
% ---------------------------------------------
figure (3)
subplot(3,1,1)  
hold on
plot(tAll,ytAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$y(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(tAll,yptAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{y}(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);
% subplot(3,1,3)  
% hold on
% plot(tAll,EyAll,'color','k','LineWidth',LineWidth)
% axis([min(tAll) max(tAll) -inf inf])
% xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
% ylabel('$E_y(t)$ ','interpreter','Latex','FontSize',FontSize);


% Evolution of the CoM X-Y
% ---------------------------------------------
figure (4)
subplot(3,1,1)  
hold on
plot(xtAll,ytAll,'color','k','LineWidth',LineWidth)
axis([min(xtAll) max(xtAll) -inf inf])
xlabel('$x$ [m]','interpreter','Latex','FontSize',FontSize);
ylabel('$y$ [m]','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(xptAll(1),yptAll(1),'*b')
plot(xptAll(end),yptAll(end),'*r')
legend('Begining','Ending' )
plot(xptAll,yptAll,'.k')
axis([min(xptAll) max(xptAll) -inf inf])
xlabel('$\dot{x}$ [m/s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{y}$ [m/s]','interpreter','Latex','FontSize',FontSize);
% subplot(3,1,3)  
% hold on
% plot(tAll,LAll,'color','k','LineWidth',LineWidth)
% axis([min(tAll) max(tAll) -inf inf])
% xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
% ylabel('$L(t)$','interpreter','Latex','FontSize',FontSize);
%
%------------------
% figure (5)
% subplot(3,1,1)  
% hold on
% plot(tAll,ztAll,'color','k','LineWidth',LineWidth)
% axis([min(tAll) max(tAll) -inf inf])
% xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
% ylabel('$z(t) [m]$','interpreter','Latex','FontSize',FontSize);
% subplot(3,1,2)  
% hold on
% plot(tAll,zptAll,'color','k','LineWidth',LineWidth)
% axis([min(tAll) max(tAll) -inf inf])
% xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
% ylabel('$\dot{z}(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);
% subplot(3,1,3)  
% hold on
% plot(tAll,ExAll,'color','k','LineWidth',LineWidth)
% axis([min(tAll) max(tAll) -inf inf])
% xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
% ylabel('$E_x(t)$ ','interpreter','Latex','FontSize',FontSize);

%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------