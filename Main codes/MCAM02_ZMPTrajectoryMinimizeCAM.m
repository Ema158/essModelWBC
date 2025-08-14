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
% Testing Essential dynamics standing on one foot
% ==============================
% Creation: 28/Ago/2024
% Last modification: -/--/--
% --------------------------------------------------------------------------------------------------
% Robot stands in one foot and regulates 
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
Nao_param = ParamZMPTrajectoryWBCMinimizeCAM();
% ---------------------------------------------------------
gait_parameters = Nao_param.gait_parameters;

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
DataName = 'InfoNAO_ZMPTrajectoryWBCCAM';
Animation = false;  % Do you want to show the animation?
n = 8; % number of SAMPLES for each step of the animation
LineWidth = 2;  % For plots and animation
FontSize = 14;  % For plots and animation 
produceVideo = true;   % Do you want to produce a video? (if animation if false no video will be produced)
framerate = (n/T)/3; % with n/T the real time duration of the video will be T, the last divition will produce
                    %  a duration of video "factor*T". For example if T=0.5, " (n/T)/3" will produce a video of 1.5 sec 
% ----------------------------------------------------
N = 7; % number of steps
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
CAMxf = Rcyc(25); CAMyf = Rcyc(26);
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
horizon = round(gait_parameters.Thorizon/gait_parameters.Tmuestreo);
muestrasTotal = round(gait_parameters.T/gait_parameters.Tmuestreo);
robot = genebotV5Acc(gait_parameters,horizon);
[robot.Zref,robot.tRef] = ZMPReferenceTrajectoryV2(horizon,muestrasTotal);
% robot.ZMax = robot.Zref + [0.007;0.007];
% robot.ZMin = robot.Zref - [0.007;0.007];
robot.ZMax = robot.Zref + [0.1;0.1];
robot.ZMin = robot.Zref - [0.1;0.1];
% Computation of the initial coefficients the polinomial trajectories for the controlled variables. 
% These coefficients are changed inmediately after the transition (really necessary when there is an impact)
gait_parameters.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_ver2(robot,gait_parameters);
gait_parameters.PolyCoeff = PolyCoeff;
%
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
X_final = [0.00;0.05;q13f;q14f;q15f;q16f;q17f;q18f;q19f;q20f;Rollf;Pitchf;...
               xpf;ypf;q13pf;q14pf;q15pf;q16pf;q17pf;q18pf;q19pf;q20pf;Rollpf;Pitchpf;CAMxf;CAMyf];
[t,Xt,SupportFoot] = EssModelWbcZMPTrajectoryAccMinimizeCAM(X_final,gait_parameters);
%% =====================================
% Plots
% =============

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
if Animation && produceVideo
    close(writerobj);
    disp('Video produced successfully')
    disp('------------------------------')
end

%% Storing all the parameters and information of this simulation
% =====================================================================
Solution.t = t;
Solution.Xt = Xt;
% Solution.ZMPrefLip = ZMPrefLipCopy;

% Solution.XtAll = [tAll, xtAll', ytAll', xptAll', yptAll', ztAll', zptAll'];
% if Animation
%     Solution.XSampledAll = [tsAll', xsAll', ysAll', xpsAll', ypsAll', zsAll', zpsAll'];
% end
Solution.SupportFootPos = SupportFoot;
% Build just ONE structure with all the information
InfNAO.robot = robot;
% % InfNAO.iniParameters = initParam;
InfNAO.gait_parameters = gait_parameters;
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
plot(t,Xt(:,1),'color','k','LineWidth',LineWidth)
axis([min(t) max(t) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$x(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(t,Xt(:,13),'color','k','LineWidth',LineWidth)
axis([min(t) max(t) -inf inf])
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
plot(t,Xt(:,2),'color','k','LineWidth',LineWidth)
axis([min(t) max(t) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$y(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(t,Xt(:,14),'color','k','LineWidth',LineWidth)
axis([min(t) max(t) -inf inf])
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
plot(Xt(:,1),Xt(:,2),'color','k','LineWidth',LineWidth)
axis([min(Xt(:,1)) max(Xt(:,1)) -inf inf])
xlabel('$x$ [m]','interpreter','Latex','FontSize',FontSize);
ylabel('$y$ [m]','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(Xt(1,13),Xt(1,14),'*b')
plot(Xt(end,13),Xt(end,14),'*r')
legend('Begining','Ending' )
plot(Xt(:,13),Xt(:,14),'.k')
axis([min(Xt(:,13)) max(Xt(:,13)) -inf inf])
xlabel('$\dot{x}$ [m/s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{y}$ [m/s]','interpreter','Latex','FontSize',FontSize);
figure (5)
subplot(3,1,1)  
hold on
plot(t,Xt(:,11),'color','k','LineWidth',LineWidth)
axis([min(t) max(t) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$Roll(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(t,Xt(:,23),'color','k','LineWidth',LineWidth)
axis([min(t) max(t) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{Roll}(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);
%
figure (6)
subplot(3,1,1)  
hold on
plot(t,Xt(:,12),'color','k','LineWidth',LineWidth)
axis([min(t) max(t) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$Pitch(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(t,Xt(:,24),'color','k','LineWidth',LineWidth)
axis([min(t) max(t) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{Pitcht}(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);
figure (7)
subplot(3,1,1)  
hold on
plot(t,Xt(:,25),'color','k','LineWidth',LineWidth)
axis([min(t) max(t) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$Kx(t) $','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(t,Xt(:,26),'color','k','LineWidth',LineWidth)
axis([min(t) max(t) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$Ky(t)(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);
%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------