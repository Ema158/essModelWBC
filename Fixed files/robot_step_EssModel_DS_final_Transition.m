function [t,Xt,gait_parameters_Starting_DS_final,gait_parameters_Transition_SS,gait_parameters_Transition_DS] = ...
    robot_step_EssModel_DS_final_Transition(X_final,gait_parameters_Starting_DS_final,gait_parameters_Transition_SS,gait_parameters_Transition_DS)

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

%% DS final phase
% ==========================================================

gait_parameters = gait_parameters_Starting_DS_final;
T = gait_parameters.T;
D = gait_parameters.D;
S = gait_parameters.S;
disp('DS phase (final)')
disp('--------------------------')
% Initial states for SS phase
x0 = X_final(1);
y0 = X_final(2);
xp0 = X_final(3);
yp0 = X_final(4);
X0_DS_final = [x0,y0,xp0,yp0];

% Double Support (SS) Phase
options = odeset('Events', @PEvents_HDZtimeDS,'RelTol', 1.e-7, 'AbsTol', 1.e-9);
[t_DS_final,Xt_DS_final] = ode45(@dynam_HZDtime,0:1e-3:T,X0_DS_final,options);


xf_DS_final = (Xt_DS_final(end,1)-S);
yf_DS_final = D-Xt_DS_final(end,2);
xpf_DS_final = Xt_DS_final(end,3);
ypf_DS_final = Xt_DS_final(end,4)*-1;

% figure(5)
% robot_draw(robot,0,0)             % Supported on the right foot
% view(3) % to assigne a "standard" view in 3D
% axis equal 
%%  SS Transition
gait_parameters = gait_parameters_Transition_SS;
T_SS = gait_parameters.T;
contB = 1;
D_SS = gait_parameters.D;
S_SS = gait_parameters.S;
disp('Gait phase')
disp('--------------------------')
% Initial states for SS phase
xf = xf_DS_final;
yf = yf_DS_final;
xpf = xpf_DS_final;
ypf = ypf_DS_final ;
X0_SS_Transition = [xf,yf,xpf,ypf];
% Double Support (SS) Phase
options = odeset('Events', @PEvents_HDZtimeDS,'RelTol', 1.e-7, 'AbsTol', 1.e-9);
[t_SS_Transition,Xt_SS_Transition] = ode45(@dynam_HZDtime,0:1e-3:T_SS,X0_SS_Transition,options);

xf_SS_Transition = Xt_SS_Transition(end,1);
yf_SS_Transition = Xt_SS_Transition(end,2);
xpf_SS_Transition = Xt_SS_Transition(end,3);
ypf_SS_Transition = Xt_SS_Transition(end,4);
%%  DS Transition
gait_parameters = gait_parameters_Transition_DS;
T_DS = gait_parameters.T;
D_DS = gait_parameters.D;
S_DS = gait_parameters.S;
disp('Gait phase')
disp('--------------------------')
% Initial states for SS phase
xf = xf_SS_Transition;
yf = yf_SS_Transition;
xpf = xpf_SS_Transition;
ypf = ypf_SS_Transition ;
X0_DS_Transition = [xf,yf,xpf,ypf];
% Double Support (SS) Phase
options = odeset('Events', @PEvents_HDZtimeDS,'RelTol', 1.e-7, 'AbsTol', 1.e-9);
[t_DS_Transition,Xt_DS_Transition] = ode45(@dynam_HZDtime,0:1e-3:T_DS,X0_DS_Transition,options);

Xt = [Xt_DS_final; Xt_SS_Transition; Xt_DS_Transition];
t = [t_DS_final; t_DS_final(end) + t_SS_Transition; t_DS_final(end) + t_SS_Transition(end) + t_DS_Transition];
%% Reinitialization if needed...
% Computing of the joints velocities and positions at the end of the step
if ~isempty(OutOfWorkSpace) % If the CoM of the robot is always inside the workspace of the robot....    
    disp('Robot configuration is OUT OF WORKSAPCE at the end of the step in "robot_step...m". Robot configuration RE-Initialized')
    robot = genebot();     
end 

global noLanding
if ~(isempty(noLanding) || noLanding==0) % if there was no impact
    disp('Robot configuration is INACCESSIBLE in "robot_step...m". Robot configuration RE-Initialized')
    robot = genebot();  
end
