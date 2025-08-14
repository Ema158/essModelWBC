% ============================================
% This file give us the trajectory of the CoM from the end of the previous step up to the end of the current step.
% Also give us the final position and velocity of the joints and all the structure in "robot".
% Namely: the last position of the previous step of the robot is given (in robot structure) -> The impact is computed -> 
%         the dynamic of the CoM is computed (ZeroDynamics) -> The last position of the robot for the current step is given
% After impact, re-labelling of the joints is performed.

function [tSS,tDS,XtSS,XtDS] = robot_step_EssModel_tJerkNoWBCDS(X_final,gait_parametersSS,gait_parametersDS)
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

T = gait_parametersDS.T;

qf_final = X_final(1:2);
qfp_final = X_final(3:4);
%% Computation of the Impact and Rellabelling
% ====================================================================
% By using the final position and velocity of the CoM at time T, we compute the final joint positions and velocities
% of the robot in order to compute the impact
[q_end,qp_end,~,~,~] = JointsPosVel_from_CoMPosVel_HZDtimeNoWBC(qf_final,qfp_final,robot,gait_parametersDS,T);
% By using final joints information, the structure of the robot is updated, i.e Jacobians,transformation matrices, etc.
robot = robot_move(robot,q_end);
robot.qD = qp_end;
% % ----------------------------------------------------------------
% % Configuration of the robot before impact
% figure(4)
% robot_draw(robot,0,0)             % Supported on the right foot
% view(3) % to assigne a "standard" view in 3D
% axis equal 

% ==================================================================
% Checking velocity of free foot before impact
[~, Qp] = current_statesNoWBC(robot);
fprintf('The linear velocity of the free foot before impact is:\n xp = %f \n yp = %f \n zp = %f \n',Qp(1),Qp(2),Qp(3));
% ==================================================================

[qfp0,robot] = impact_Pos_VelNoWBC(robot,gait_parameters.v_foot_f); %
% The New robot position and velocity of the joints after impact and
% The New CoM velocity after impact are computed
% Computation of the initial position of the CoM after impact
xp0 = qfp0(1);    % Initial velocity in X of the CoM for the new step j+1
yp0 = qfp0(2);    % Initial velocity in Y of the CoM for the new step j+1
% ====================================================================
% -------------------------------------------------------------
% COMPUTING POLYNOMIALS
% Computing of Coefficients for the polinomials by taking into account the states after impact
gait_parametersSS.transition = true;
PolyCoeff = Coeff_DesiredTrajectories_t_NoWBC(robot,gait_parametersSS);
gait_parametersSS.PolyCoeff = PolyCoeff;   
%
gait_parametersDS.transition = false;
PolyCoeff = Coeff_DesiredTrajectories_t_NoWBC(robot,gait_parametersDS);
gait_parametersDS.PolyCoeff = PolyCoeff;  
% Just to chck if the all the controlled variables are in the ZERO DYNAMICS MANIFOLD
ZeroDynamics_impactTime_testNoWBC(robot.CoM(1),robot.CoM(2),qfp0,robot,gait_parametersSS);
% ---------------------------------------------------------------------------------

%% Evaluating the dynamics of the Essential model
% ====================================================================
% Initial states (after impact)
X0 = [robot.CoM(1:2); xp0; yp0];
% % -----------------------------------------------------------------------------------------------
% % ----------------------------------------------------------------------------------------------------
gait_parameters = gait_parametersSS;
XtSS = ode4(@dynam_HZDtimeLipReferenceOnlineJerkNoWBCSS,0:1e-2:gait_parametersSS.T,X0);
tSS = 0:1e-2:gait_parametersSS.T;
X0 = XtSS(end,:)';
gait_parameters = gait_parametersDS;
XtDS = ode4(@dynam_HZDtimeLipReferenceOnlineJerkNoWBCDS,0:1e-2:gait_parametersDS.T,X0);
tDS = 0:1e-2:gait_parametersDS.T;
%% Configuration of the last canfiguration of the robot
% Computing of the joints velocities and positions at the end of the step
if isempty(OutOfWorkSpace) % If the CoM of the robot is always inside the workspace of the robot....
    qf_final = XtDS(end,1:2)'; % CoM position at the end of the step
    qfp_final = XtDS(end,3:4)'; % CoM velocity at the end of the step
    [q,qp,~,~,~] = JointsPosVel_from_CoMPosVel_HZDtimeNoWBC(qf_final,qfp_final,robot,gait_parametersDS,tDS(end));
    robot = robot_move(robot,q); % All the structure of the robot is updated based on the New Final joint positions
    robot.qD = qp;               % New Final joint velocities of the robot
    % Configuration of the robot at the end of the step
%     figure(4)
%     robot_draw(robot,0,0)             % Supported on the right foot
%     view(3) % to assigne a "standard" view in 3D
%     axis equal
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

