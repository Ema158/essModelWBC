% ============================================
% This file give us the trajectory of the CoM from the end of the previous step up to the end of the current step.
% Also give us the final position and velocity of the joints and all the structure in "robot".
% Namely: the last position of the previous step of the robot is given (in robot structure) -> The impact is computed -> 
%         the dynamic of the CoM is computed (ZeroDynamics) -> The last position of the robot for the current step is given
% After impact, re-labelling of the joints is performed.

function [t,X0,Xt] = robot_step_EssModel_t_basic(X_inicial)
%Relabelling + Simulation of one step of the robot 

% ==============================================================================================
% Options
% ----------------------------------------------------------------------------------------------
% NOTE The number of iterations performed by the solver are counted by "contB". This is used to stop the solver if the
% robot doesn't perform a step after a determinated number of iterations (this is done in "PEventsHZDtime")
global contB  % To show the number of iterations in PEVents and stop the solver if necessary
contB =  1;            % To count the number of iterations performed by the solver (recommended)
% DisplayIterNumber = []; % To DISPLAY the information of the number of iteration performed by the solver.. Empty-> Not display anything
% ==============================================================================================
global contD OutOfWorkSpace
contD = []; % Every time the robot is out of the workspace and "PEvents" is called, 'contD' is used to stop de integration 
OutOfWorkSpace = []; % Reset workspace flag

global gait_parameters robot

T = gait_parameters.T;

%% Evaluating the dynamics of the Essential model
% ====================================================================
% Initial states (after impact)
x0 = X_inicial(1);
y0 = X_inicial(2);
xp0 = X_inicial(3);
yp0 = X_inicial(4);
X0 = [x0, y0, xp0, yp0];
% % -----------------------------------------------------------------------------------------------
% % The next is just to see how the robot looks after impact and by considering the gait trajectory
% % -----------------------------------------------------------------------------------------------
% qf_initial = [x0; y0]; % CoM position at the begining of the step
% qfp_initial = [xp0; yp0]; % CoM velocity at the begining of the step
% [qIni,qpIni,~,~,~] = JointsPosVel_from_CoMPosVel_HZDtime(qf_initial,qfp_initial,robot,gait_parameters,0);
% robotIni = robot_move(robot,qIni); % A new structure of the robot is used to store its configuration after impact
% robotIni.qD = qpIni;               % and considering the initial desired trajectories
% % Configuration of the robot after impact (AND INITIAL desired trajectories)
% figure(3)
% robot_draw(robotIni,0,0)             % Supported on the right foot
% view(3) % to assigne a "standard" view in 3D
% axis equal 
% % ----------------------------------------------------------------------------------------------------

options = odeset('Events', @PEvents_HDZtime,'RelTol', 1.e-7, 'AbsTol', 1.e-9);
[t,Xt] = ode45(@dynam_HZDtime,0:1e-3:T,X0,options);

%% Configuration of the last canfiguration of the robot
% Computing of the joints velocities and positions at the end of the step
if isempty(OutOfWorkSpace) % If the CoM of the robot is always inside the workspace of the robot....
    qf_final = Xt(end,1:2)'; % CoM position at the end of the step
    qfp_final = Xt(end,3:4)'; % CoM velocity at the end of the step
    [q,qp,~,~,~] = JointsPosVel_from_CoMPosVel_HZDtime(qf_final,qfp_final,robot,gait_parameters,t(end));
    robot = robot_move(robot,q); % All the structure of the robot is updated based on the New Final joint positions
    robot.qD = qp;               % New Final joint velocities of the robot
    % Configuration of the robot at the end of the step
    figure(4)
    robot_draw(robot,0,0)             % Supported on the right foot
    view(3) % to assigne a "standard" view in 3D
    axis equal
    % ---------------------------------------------------------
else 
    disp('Robot configuration is OUT OF WORKSAPCE at the end of the step in "robot_step...m". Robot configuration RE-Initialized')
    robot = genebot();     
end 

global noLanding
if ~(isempty(noLanding) || noLanding==0) % if there was no impact
    disp('Robot configuration is INACCESSIBLE in "robot_step...m". Robot configuration RE-Initialized')
    robot = genebot();  
end


end

