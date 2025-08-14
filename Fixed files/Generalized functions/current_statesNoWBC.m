function [Q, Qp] = current_statesNoWBC(robot)
% This function give the current states of the robot Q -> 31x1 and Qp-> 31x1 where Q is given by
% Q =   [   z       	 % Position in z of the CoM 
%         x_foot         % Position in x of the free foot. Obtained from frame 12
%         y_foot         % Position in y of the free foot. Obtained from frame 12
%         z_foot         % Position in z of the free foot. Obtained from frame 14
%         psi_foot       % Roll orientation. Rotation in x of the free foot. Obtained from frame 14
%         theta_foot     % Pitch orientation. Rotation in y of the free foot. Obtained from frame 14
%         phi_foot       % Yaw orientation. Rotation in z of the free foot. Obtained from frame 14
%         psi_torso      % Roll orientation. Rotation in x of the torso. Obtained from frame 7
%         theta_torso    % Pitch orientation. Rotation in y of the torso. Obtained from frame 7
%         phi_torso      % Yaw orientation. Rotation in z of the torso. Obtained from frame 7
%         phi_Uper_torso % Yaw orientation. Rotation in z of the upper torso. Obtained from frame 15
%           x            % Position in x of the CoM 
%           y]           % Position in y of the CoM 
% and Qp = dQ/dt - > are the velocities.

% -----------------------
% Positions: Q = f(q) = [h(q); x; y]
% ------------------
G = robot.CoM;  % Posición X,Y del COM del robot
Q = [state_vNoWBC(robot);G(1);G(2)];  %

%-------------------
% Velocities Qp = JQ(q)*qp ...where JQ = df(q)/dq
%-----------------
JQ = [J_state_vNoWBC(robot);robot.J_CoM(1:2,:)];
Qp =  JQ*robot.qD;

