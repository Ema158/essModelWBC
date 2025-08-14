
function [t,Xt,t_SS,Xt_SS,t_DS,Xt_DS,gait_parameters_SS_Stopping,gait_parameters_DS_Stopping] = robot_step_LIPModel_Stopping_SS_DS_t(X_final,gait_parameters_SS_Stopping,gait_parameters_DS_Stopping)

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
%% SS phase
% ==========================================================
gait_parameters = gait_parameters_SS_Stopping;
T = gait_parameters.T;
D = gait_parameters.D;
disp('SS phase')
disp('--------------------------')
% Initial states
x0 = X_final(1);
y0 = X_final(2);
xp0 = X_final(3);
yp0 = X_final(4);
X0_SS = [x0,y0,xp0,yp0];

% Single Support (SS) Phase
[t_SS,Xt_SS] = Nsteps_3DLIP_model_v2(X0_SS);

xf_SS = Xt_SS(end,1);
yf_SS = Xt_SS(end,2);
xpf_SS = Xt_SS(end,3);
ypf_SS = Xt_SS(end,4);
% figure
% robot_draw(robot,0,0);
% axis equal
%% Double Support (DS) Phase
gait_parameters = gait_parameters_DS_Stopping;
T = gait_parameters.T;
% Restart iteration counter
contB = 1;
disp('DS phase')
disp('--------------------------')
% Initial states for SS phase
x0 = xf_SS;
y0 = yf_SS;
xp0 = xpf_SS;
yp0 = ypf_SS;
X0_DS = [x0,y0,xp0,yp0];
% In PEventsDS the high of the foot is not checked.. but since the gait is defined by a constant desired time T, that
% condition is not SO important
[t_DS,Xt_DS] = Nsteps_3DLIP_model_v2(X0_DS);

% xf_DS = Xt_DS(end,1);
% yf_DS = Xt_DS(end,2);
% xpf_DS = Xt_DS(end,3);
% ypf_DS = Xt_DS(end,4);
% Complete solution
Xt = [Xt_SS; Xt_DS];
t = [t_SS; t_SS(end) + t_DS];
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


