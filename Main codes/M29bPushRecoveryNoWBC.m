close all;
clear all;
clc
% ---------------------------------------------------------------------------------------------
currentfolder = pwd; % save current path
cd ..                % go one folder down (go out of the current folder and stay in the previous one)
add_paths;           % add all folders where all files are founded in order to acces to them
cd(currentfolder);   % return to the original path
% ---------------------------------------------------------------------------------------------
    
echo on
% Computing of joint trajectories positions velocities and accelerations  based on the CoM trajectory (Position and velocity)
% Also, computing reaction moment and force on the support foot, joint torques and ZMP.
% ==============================================================================================
% Creation: 19/dic/2017
% Last modification: -/-/-
% --------------------------------------------------------------------------------------------------
% This file load the CoM trajectory, gait information and others parameters to compute the Reaction
% moment and force of the ground, joint torques and ZMP produced.
% IN HERE the evolution of the ZMP COULD be OUTSIDE of the sole, all deppends of the CoM trajectory in position and
% velocity and the motion given to the free foot.
% --------------------------------------------------------------------------------------------------
% 
%
echo off
global coms;% En 1 se grafican los centros de masa de cada eslabon
                %En 0 no
coms=0;
% -----------------------------------------------   
Hour = datestr(now,13);
disp([Hour ' -> Reading data']);
% -----------------------------------------------   
% Options
% ----------------------------------------------- 
% DataName = 'InfoNAO_NoWBC'; % File produced in "M04d_...m" CHANGE OptionContVar = 1;
DataName = 'InfoNAO_PushRecoveryNoWBC';
% DataName = 'InfoNAO_OutCoMNoWBC';
anim = 1; % Do you want animation? 1-> yes, 0-> no
% -------------------------------------------------------------------------------------------------
% CHOSING CONTROLLED VARIABLE FILES
% -------------------------------------------------------------------------------------------------
global OptionContVar  % Option to chose the controlled variables "hd", "hpd" and "hppd"
% 1 -> Controlled variables defined by polynomials w.r.t. time, IMPACT is considered. Files: "hd_Polyn", "hpd_Polyn" and "hppd_Polyn". 
% 2 -> Controlled variables defined by cycloidal motion w.r.t. time, IMPACT is NOT considered. Files: "hd_CycMotion_t", "hpd_CycMotion_t" and "hppd_CycMotion_t". 
% 3 -> Controlled variables defined by polynomials w.r.t. "x" of the CoM, IMPACT is considered. Files: "hd_Polyn", "hpd_Polyn_x" and "hppd_Polyn_x". 
% OptionContVar = 2;
OptionContVar = 1;
% -----------------------------------------------
% input
% -----------------------------------------------
load(DataName); 
NameAnim = ['anim_', DataName];
% -----------------------------------------------
robot = InfNAO.robot;
% robot = genebot(); 
% initParam = InfROMEO.iniParameters;
gait_parameters = InfNAO.gait_parameters;
Solution = InfNAO.Solution;

t = Solution.t;    % Cell array of elapsed time for each step
Xt = Solution.Xt;  % Cell array of solution X(t) for each step

% % Torque, force and ZMP computation
% -----------------------------------------------  
DateVecOld = datevec(Hour);
Hour = datestr(now,13);
disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
disp([Hour ' -> Computing joint positions velocities and acceleration based on the CoM position and velocity']);
[qt,qDt,qDDt] = joints_fromCoMpos_Vel_HZDtimeNoWBC(robot,Xt,gait_parameters,t);
samples = size(t,2);
% ------------------------------------------------    
% % Torque, force and ZMP computation
% -----------------------------------------------
DateVecOld = datevec(Hour);
Hour = datestr(now,13);
disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
disp([Hour ' -> Computation of torques, forces and ZMP based on "q", "qp" and "qpp" ...']);
% ------------------------------------------------    
ZMP = zeros(2,samples);
CAM = zeros(2,samples);
F = zeros(3,samples);
M = zeros(3,samples);
Tau = zeros(robot.joints,samples);

for i = 1:samples
    % "Newton_Euler.m" Algorithm
    [F(:,i),M(:,i),Tau(:,i)]= Newton_Euler(qt(:,i),qDt(:,i),qDDt(:,i));
    ZMP(1,i) = -M(2,i)/F(3,i);
    ZMP(2,i) =  M(1,i)/F(3,i);    
    CAM(1,i) = (ZMP(2,i)-Xt(i,2))*F(3,i) + F(2,i)*gait_parameters.z_i;
    CAM(2,i) = (Xt(i,1)-ZMP(1,i))*F(3,i) - F(1,i)*gait_parameters.z_i;
end
qtAll = qt;  % joint position q(t) for all the steps
qDtAll = qDt;  % joint velocities q(t) for all the steps
qDDtAll = qDDt;  % joint accelerations q(t) for all the steps
F_All = F;
M_All = M;
Tau_All = Tau;
ZMP_All = ZMP;
% ---------------------------------------------------------

%% Evolution of the key point variables (20 controlled variables and X-Y CoM)
disp('--------------------------------------------------------------------------------------------');
disp('Computing controlled variables evolution (Q and Qp) based on joint information (q and qp)...')
samples = length(t);
for i=1:samples
    robot = robot_move(robot,qt(:,i));
    robot.qD = qDt(:,i);
    % Checking states of the robot
    [Q(:,i), Qp(:,i)] = current_statesNoWBC(robot);
end

%% Storing all the parameters and information of this simulation
% =====================================================================
Solution.JointPos = qt;
Solution.JointVel = qDt;
Solution.JointAcc = qDDt;
Solution.JointPosAll = qtAll;
Solution.JointVelAll = qDtAll;
Solution.JointAccAll = qDDtAll;
Solution.ReactionForce = F;
Solution.ReactionMoment = M;
Solution.Torques = Tau;
Solution.ZMP = ZMP;
Solution.ReactionForceAll = F_All;
Solution.ReactionMomentAll = M_All;
Solution.TorquesAll = Tau_All;
Solution.ZMPAll = ZMP_All;
Solution.Q = Q;
Solution.Qp = Qp;

% Save just ONE structure with all the information
InfNAO.Solution = Solution;
% ---------------------------------------------------------
DateVecOld = datevec(Hour);
Hour = datestr(now,13);
disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
disp([Hour ' -> Adding data from joints, tau, F, M, ZMP and others to the data file: ' DataName]);
disp('------------------------------');
% ---------------------------------------------------------
save(DataName,'InfNAO')


%% Walking ANIMATION
% ==============================================================================
if anim    
    dataS = cell(1,1); % Sampled joint positions
    disp('Animation...')
    % This part is just to make the animation faster, the larger "n" the slower and finer the animation
    n = 10; % Number of samples of vector
    qS = sampling(qt,n); % sampling of joint position "q"       
    % We don't need the joint velocities to draw the robot, so we don't sample the velocity "qp"
    dataS{1,1} = qS;
    framerate = 5;
    animationStandingOnefoot(dataS,1,NameAnim,framerate); % ("parametro"= Numero de pasos a observar al final de la simulaci�n y a grabar en el video
    animation_stick(dataS,1);    %"parametro"= Numero de pasos que se dibujar�n
    disp(['Animation stored as: ' NameAnim]);
    disp('----------------------------------');
end
% ==============================================================================

%% PLOTS
% =======================================================
DateVecOld = datevec(Hour);
Hour = datestr(now,13);
disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
disp([Hour ' -> Plotting...']);
% -----------------------------------------
% In the variable "plots" we chose which plot we want to show...
plots(1) = 0;
plots(2) = 1;
plots(3) = 1;
plots(4) = 1;
plots(5) = 1;
plots(6) = 0;
plots(7) = 0;
plots(8) = 0;
% plots(1) -> joint position, velocity and acceleration
% plots(2) -> reaction force and moment
% plots(3) -> joint torques
% plots(4) -> ZMP time
% plots(5) -> ZMP foot
% plots(6) -> CoM time
% plots(7) -> CoM X-Y
% plots(8) -> CoM samples
% ------------------------------------------------------------
% General file for plotting:
colors = 'krbgymckrbgymc'; % Posible color for the lines of each step. Maximum 7 steps (since there are 7 different colors)
hold on
LineType = colors(1);
graphix(plots,Xt,Tau,t,qt,qDt,qDDt,F,M,ZMP,LineType,5);
% ------------------------------------------------------------
figure(30)
FootCenter = [0,0];
width = 0.08; % foot width [m]
length2Ankle = 0.05; % foot lenght from center to ankle [m]
length2toes = 0.095; % foot lenght from center to the toes 
ZMPfootprints(ZMP,FootCenter,width,length2Ankle,length2toes,colors(1))
hold on
ZMPlimits(robot.ZMax,robot.ZMin)
plot(Xt(:,1),Xt(:,2),'g')
plot(Xt(1,1),Xt(1,2),'og')
plot(Xt(end,1),Xt(end,2),'xg')
figure(31)
plot(t,CAM(1,:))
title('Angular Momentum rate in x');
figure(32)
plot(t,CAM(2,:))
title('Angular Momentum rate in y');
figure(35)
plot(t,Xt(:,6))
title('Angular Momentum in y');
figure(36)
plot(t,Xt(:,5))
title('Angular Momentum in x');
%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------