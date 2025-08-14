
function [t,Xt,t_SS,Xt_SS,t_DS,Xt_DS,t_DS_final,Xt_DS_final,gait_parameters_SS,gait_parameters_DS,gait_parameters_DS_final] = robot_step_LIPModel_Start_DS_SS_DS_t(gait_parameters_SS,gait_parameters_DS,gait_parameters_DS_final)

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
ZMPxCoeff = gait_parameters.ZMPxCoeff;
ZMPyCoeff = gait_parameters.ZMPyCoeff;
disp('DS phase')
disp('--------------------------')
% Initial states
x0 = 0;
y0 = D/2;
xp0 = 0;
yp0 = 0;
X0_DS = [x0,y0,xp0,yp0];

% Double Support (SS) Phase
[t_DS,Xt_DS] = Nsteps_3DLIP_model_v2(X0_DS);

xf_DS = Xt_DS(end,1);
yf_DS = Xt_DS(end,2);
xpf_DS = Xt_DS(end,3);
ypf_DS = Xt_DS(end,4);
% figure
% robot_draw(robot,0,0);
% axis equal
%% Single Support (SS) Phase
gait_parameters = gait_parameters_SS;
T = gait_parameters.T;
% Restart iteration counter
contB = 1;
disp('SS phase')
disp('--------------------------')
% Initial states for SS phase
x0 = xf_DS;
y0 = yf_DS;
xp0 = xpf_DS;
yp0 = ypf_DS;
X0_SS = [x0,y0,xp0,yp0];
% In PEventsDS the high of the foot is not checked.. but since the gait is defined by a constant desired time T, that
% condition is not SO important
[t_SS,Xt_SS] = Nsteps_3DLIP_model_v2(X0_SS);

xf_SS = Xt_SS(end,1);
yf_SS = Xt_SS(end,2);
xpf_SS = Xt_SS(end,3);
ypf_SS = Xt_SS(end,4);
% figure
% robot_draw(robot,0,0);
% axis equal
%% DS final phase
% ==========================================================
gait_parameters = gait_parameters_DS_final;
T = gait_parameters.T;
D = gait_parameters.D;
% Restart iteration counter
contB = 1;
disp('DS phase (final)')
disp('--------------------------')
% Initial states for SS phase
x0 = xf_SS;
y0 = yf_SS;
xp0 = xpf_SS;
yp0 = ypf_SS;
X0_DS_final = [x0,y0,xp0,yp0];

% Double Support (SS) Phase
[t_DS_final,Xt_DS_final] = Nsteps_3DLIP_model_v2(X0_DS_final);


% Complete solution
Xt = [Xt_DS; Xt_SS; Xt_DS_final];
t = [t_DS; t_DS(end) + t_SS; t_DS(end) + t_SS(end) + t_DS_final];
% figure
% robot_draw(robot,0,0);
% axis equal
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


