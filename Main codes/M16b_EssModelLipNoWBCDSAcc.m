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
% Creation: 26/Ago/2024
% Last modification: -/--/--
% --------------------------------------------------------------------------------------------------
% Walking of a Essential with free hips and arms motion following a
% reference obtained by the LIP model.
% -----------------------------------------------------------------------------------------------------
% --------------------------------------------------------------------------------------------------
% 
%
echo off

global robot coms nStepDisturbance
nStepDisturbance = 1;
coms=0;

% Parameters
% ---------------------------------------------------------
Nao_paramSS = ParamQPLIPNoWBCSS();
Nao_paramDS = ParamQPLIPNoWBCDS();
Nao_paramStart = ParamQPLIPStartNoWBC();
Nao_paramStartStep = ParamQPLIPStartSSNoWBC();
Nao_paramStop = ParamQPLIPStopNoWBC();
Nao_paramStopStep = ParamQPLIPStopSSNoWBC();
% %
% Nao_paramSS = ParamQPLIPNoWBCSSLongStep();
% Nao_paramDS = ParamQPLIPNoWBCDSLongStep();
% Nao_paramStart = ParamQPLIPStartNoWBCLongStep();
% Nao_paramStartStep = ParamQPLIPStartSSNoWBCLongStep();
% Nao_paramStop = ParamQPLIPStopNoWBCLongStep();
% Nao_paramStopStep = ParamQPLIPStopSSNoWBCLongStep();
%
% Nao_paramSS = ParamQPLIPNoWBCSSLongStepandTime();
% Nao_paramDS = ParamQPLIPNoWBCDSLongStepandTime();
% Nao_paramStart = ParamQPLIPStartNoWBCLongStepandTime();
% Nao_paramStartStep = ParamQPLIPStartSSNoWBCLongStepandTime();
% Nao_paramStop = ParamQPLIPStopNoWBCLongStepandTime();
% Nao_paramStopStep = ParamQPLIPStopSSNoWBCLongStepandTime();

% ---------------------------------------------------------
gait_parametersSS = Nao_paramSS.gait_parameters;
gait_parametersDS = Nao_paramDS.gait_parameters;
gait_parametersStart = Nao_paramStart.gait_parameters;
gait_parametersStartStep = Nao_paramStartStep.gait_parameters;
gait_parametersStop = Nao_paramStop.gait_parameters;
gait_parametersStopStep = Nao_paramStopStep.gait_parameters;

T = gait_parametersSS.T + gait_parametersDS.T;
S = gait_parametersSS.S;
D = gait_parametersSS.y_ffoot_i;

% CHOSING CONTROLLED VARIABLE FILES
% -------------------------------------------------------------------------------------------------
global OptionContVar  % Option to chose the controlled variables "hd", "hpd" and "hppd"
% 1 -> Controlled variables defined by polynomials w.r.t. time, IMPACT is considered. Files: "hd_Polyn", "hpd_Polyn_t" and "hppd_Polyn_t". 
% 2 -> Controlled variables defined by cycloidal motion w.r.t. time, IMPACT is NOT considered. Files: "hd_CycMotion_t", "hpd_CycMotion_t" and "hppd_CycMotion_t". 
% 3 -> Controlled variables defined by polynomials w.r.t. "x" of the CoM, IMPACT is considered. Files: "hd_Polyn", "hpd_Polyn_x" and "hppd_Polyn_x". 
OptionContVar = Nao_paramSS.ControlledVariableOption;
% -------------------------------------------------------------------------------------------------

% GENERAL OPTIONS
% ----------------------------------------------------
DataName = 'InfoNAO_DSNoWBCAcc';
Animation = false;  % Do you want to show the animation?
n = 8; % number of SAMPLES for each step of the animation
LineWidth = 2;  % For plots and animation
FontSize = 14;  % For plots and animation 
produceVideo = true;   % Do you want to produce a video? (if animation if false no video will be produced)
framerate = (n/T)/3; % with n/T the real time duration of the video will be T, the last divition will produce
                    %  a duration of video "factor*T". For example if T=0.5, " (n/T)/3" will produce a video of 1.5 sec 
% ----------------------------------------------------
N = 10; % number of steps
% Initial support for the first step
SupportFootX = 0;
SupportFootY = 0;
ZMPd = cell(1,N+1);

% Final conditions for the step 0
% Cyclic motions:
% -------------------------------------------------------------------------------------------------------------------
Rcyc = Nao_paramSS.Rcyc;

% If NO error in the velocity is desired, chose "Error = 0"
Error = 0.0; % Percentage of error   <-------
if Error ~= 0
    fprintf('Motion started OUTSIDE the periodic motion, with an error in velocity of %.2f %%\n',Error*100)
    disp('-----------------------------------------------------------------------------------')
end
% ----------------------------------
Dx = Rcyc(1);
Dy = Rcyc(2);
xpf = Rcyc(3)*(1+Error);
ypf = Rcyc(4)*(1+Error);
% Initial and final position is computed as 
x0 = Dx;
y0 = D/2 - Dy;
xf = S/2 + Dx;
yf = D/2 + Dy;
CAMxf = Rcyc(5);
CAMyf = Rcyc(6);
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
horizon = round(T/gait_parametersSS.Tmuestreo);
robot = genebotV5Acc(gait_parametersSS,horizon);
horizon = round(T/gait_parametersSS.Tmuestreo);
[robot.Zref,robot.tRef] = ZMPReferenceV2(N,horizon,S,D);
Solution.Zref = robot.Zref;
Solution.tRef = robot.tRef;
[robot.ZMax,robot.ZMin,offsetX] = ZMPConstraints(N,horizon,S,D);
Solution.offsetX = offsetX;
Solution.ZMax = robot.ZMax;
Solution.ZMin = robot.ZMin;
% Computation of the initial coefficients the polinomial trajectories for the controlled variables. 
% These coefficients are changed inmediately after the transition (really necessary when there is an impact)
gait_parametersSS.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_NoWBC(robot,gait_parametersSS);
gait_parametersSS.PolyCoeff = PolyCoeff;
%
gait_parametersDS.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_NoWBC(robot,gait_parametersDS);
gait_parametersDS.PolyCoeff = PolyCoeff;
%
gait_parametersStart.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_NoWBC(robot,gait_parametersStart);
gait_parametersStart.PolyCoeff = PolyCoeff;
%
gait_parametersStartStep.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_NoWBC(robot,gait_parametersStartStep);
gait_parametersStartStep.PolyCoeff = PolyCoeff;
%
gait_parametersStop.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_NoWBC(robot,gait_parametersStop);
gait_parametersStop.PolyCoeff = PolyCoeff;
%
gait_parametersStopStep.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_NoWBC(robot,gait_parametersStopStep);
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
X_final = [0;D/2;xpf;ypf;CAMxf;CAMyf];
[tStart,tStartStep,tStop,tStopStep,tSS,tDS,XtStart,XtStartStep,XtStop,XtStopStep,XtSS,XtDS,SupportFoot] = EssModelWbcLipOnlineAccNoWBCDS(X_final,gait_parametersSS,gait_parametersDS,gait_parametersStart,gait_parametersStartStep,gait_parametersStop,gait_parametersStopStep,N,horizon);
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
angMomXAll = [];
angMomYAll = [];

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
        ypt = XtStart(:,4)';
        xpt = XtStart(:,3)';                       % xp(t) for step "j"  
        angMomX = XtStart(:,5)';
        angMomY = XtStart(:,6)';
        tG = tStart';  % tG is the global time for all the steps
    end
    if j==2
        xt = SupportFoot{j}(1) +  XtStartStep(:,1)';  % global position of x(t) for step "j"
        yt = SupportFoot{j}(2) + XtStartStep(:,2)'; % global position of y(t) for step "j"
        ypt = XtStartStep(:,4)';
        xpt = XtStartStep(:,3)';                       % xp(t) for step "j"   
        angMomX = XtStartStep(:,5)';
        angMomY = XtStartStep(:,6)';
        tG = tStart(end) + tStartStep';  % tG is the global time for all the steps
    end
    if j~=1 && j~=2 && j~=N+3 && j~=N+4
        xt = SupportFoot{j}(1) +  [XtSS{j-2}(:,1);XtDS{j-2}(:,1)]';  % global position of x(t) for step "j"
        if mod(j,2)==false % If j is impair (for pair steps we add distance D and invert direction)    
            yt = SupportFoot{j}(2) + [XtSS{j-2}(:,2);XtDS{j-2}(:,2)]'; % global position of y(t) for step "j"
            ypt = [XtSS{j-2}(:,4);XtDS{j-2}(:,4)]';                       % global velocity yp(t) for step "j" 
            angMomX = [XtSS{j-2}(:,5);XtDS{j-2}(:,5)]';
        else
            yt = SupportFoot{j}(2) - [XtSS{j-2}(:,2);XtDS{j-2}(:,2)]';  % global position of y(t) for step "j"
            ypt = -[XtSS{j-2}(:,4);XtDS{j-2}(:,4)]';                       % global velocity yp(t) for step "j" 
            angMomX = -[XtSS{j-2}(:,5);XtDS{j-2}(:,5)]';
        end
        xpt = [XtSS{j-2}(:,3);XtDS{j-2}(:,3)]';                       % xp(t) for step "j"     
        angMomY = [XtSS{j-2}(:,6);XtDS{j-2}(:,6)]';
        tG = tStartAll(end) + (j-3)*T  + [tSS{j-2},tSS{j-2}(end)+tDS{j-2}]';  % tG is the global time for all the steps
    end
    if j==N+3
        xt = SupportFoot{j}(1) +  XtStopStep(:,1)';  % global position of x(t) for step "j"
        if mod(j,2)==false % If j is impair (for pair steps we add distance D and invert direction)    
            yt = SupportFoot{j}(2) + XtStopStep(:,2)'; % global position of y(t) for step "j"
            ypt = XtStopStep(:,4)';                       % global velocity yp(t) for step "j" 
            angMomX = XtStopStep(:,5)';
        else
            yt = SupportFoot{j}(2) - XtStopStep(:,2)';  % global position of y(t) for step "j"
            ypt = -XtStopStep(:,4)'; 
            angMomX = -XtStopStep(:,5)';% global velocity yp(t) for step "j" 
        end
        xpt = XtStopStep(:,3)';                       % xp(t) for step "j"     
        angMomY = XtStopStep(:,6)';
        tG = tStartAll(end) + (j-3)*T  + tStopStep';  % tG is the global time for all the steps
    end
    if j==N+4
        xt = SupportFoot{j}(1) +  XtStop(:,1)';  % global position of x(t) for step "j"
        if mod(j,2) % If j is impair (for pair steps we add distance D and invert direction)    
            yt = SupportFoot{j}(2) + XtStop(:,2)'; % global position of y(t) for step "j"
            ypt = XtStop(:,4)';                       % global velocity yp(t) for step "j" 
            angMomX = XtStop(:,5)';
        else
            yt = SupportFoot{j}(2) - XtStop(:,2)';  % global position of y(t) for step "j"
            ypt = -XtStop(:,4)';                       % global velocity yp(t) for step "j" 
            angMomX = -XtStop(:,5)';
        end
        xpt = XtStop(:,3)';                       % xp(t) for step "j"     
        angMomY = XtStop(:,6)';
        tG = tStartAll(end) + (j-4)*T  + tStopStep(end) + tStop';  % tG is the global time for all the steps
    end
    % ===============================================================
    %     Variables for animation
    % ===============================================================
    % ===============================================================
    % States for all the trajectory
    xtAll = [xtAll xt];
    xptAll = [xptAll xpt];
    ytAll = [ytAll yt];
    yptAll = [yptAll ypt];  
    tAll = [tAll;tG];
    angMomXAll = [angMomXAll angMomX];
    angMomYAll = [angMomYAll angMomY];
end
if Animation && produceVideo
    close(writerobj);
    disp('Video produced successfully')
    disp('------------------------------')
end

%% Storing all the parameters and information of this simulation
% =====================================================================
Solution.tSS = tSS;
Solution.XtSS = XtSS;
Solution.tDS = tDS;
Solution.XtDS = XtDS;
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
% Build just ONE structure with all the information
InfNAO.robot = robot;
% % InfNAO.iniParameters = initParam;
InfNAO.gait_parametersSS = gait_parametersSS;
InfNAO.gait_parametersDS = gait_parametersDS;
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
subplot(2,1,1)  
hold on
plot(tAll,xtAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$x(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(2,1,2)  
hold on
plot(tAll,xptAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{x}(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);

% Evolution of the position and velocity CoM in Y w.r.t. time
% ---------------------------------------------
figure (3)
subplot(2,1,1)  
hold on
plot(tAll,ytAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$y(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(2,1,2)  
hold on
plot(tAll,yptAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{y}(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);

% Evolution of the CoM X-Y
% ---------------------------------------------
figure (4)
subplot(2,1,1)  
hold on
plot(xtAll,ytAll,'color','k','LineWidth',LineWidth)
axis([min(xtAll) max(xtAll) -inf inf])
xlabel('$x$ [m]','interpreter','Latex','FontSize',FontSize);
ylabel('$y$ [m]','interpreter','Latex','FontSize',FontSize);
subplot(2,1,2)  
hold on
plot(xptAll(1),yptAll(1),'*b')
plot(xptAll(end),yptAll(end),'*r')
legend('Begining','Ending' )
plot(xptAll,yptAll,'.k')
axis([min(xptAll) max(xptAll) -inf inf])
xlabel('$\dot{x}$ [m/s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{y}$ [m/s]','interpreter','Latex','FontSize',FontSize);
%------------------
figure (5)
subplot(2,1,1)  
hold on
plot(tAll,angMomXAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$K_x(t)$','interpreter','Latex','FontSize',FontSize);
subplot(2,1,2)  
hold on
plot(tAll,angMomYAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$K_y(t)$','interpreter','Latex','FontSize',FontSize);

%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------