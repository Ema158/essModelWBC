function [t,Xt] = robot_step_prueba_fase_inicio(gait_parameters_DS)

% ==============================================================================================
% Options
% ----------------------------------------------------------------------------------------------
% NOTE The number of iterations performed by the solver are counted by "contB". This is used to stop the solver if the
% robot doesn't perform a step after a determinated number of iterations (this is done in "PEventsHZDtime")
global contB 
contB =  1;            % To count the number of iterations performed by the PEvents file (recommended)
% global DisplayIterNumber % To show how many iteration have been performed by the solver 
% DisplayIterNumber = []; % To DISPLAY the information of the number of iteration performed by the solver.. Empty-> Not display anything
% ==============================================================================================
global contD OutOfWorkSpace
contD = []; % Every time the robot is out of the workspace and "PEvents" is called, 'contD' is used to stop de integration 
OutOfWorkSpace = []; % Reset workspace flag

global robot gait_parameters
%% DS phase
% ==========================================================
gait_parameters = gait_parameters_DS;
T = gait_parameters.T;
D = gait_parameters.D;
disp('DS phase')
disp('--------------------------')
% Initial states
x0 = 0;
y0 = D/2;
xp0 = 0;
yp0 = 0;
X0_DS = [x0,y0,xp0,yp0];

% Double Support (SS) Phase
options = odeset('Events', @PEvents_HDZtimeDS,'RelTol', 1.e-7, 'AbsTol', 1.e-9);
[t,Xt] = ode45(@dynam_HZDtime,0:1e-3:T,X0_DS,options);

figure(2)
plot(Xt(:,1),Xt(:,2));
hold on