function [Q, Qp] = current_states(robot)
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
Hips = hipsAttitude(robot);
Q = [state_v(robot);G(1);G(2);robot.q(13:16);robot.q(18:21);Hips(1:2)'];  %

%-------------------
% Velocities Qp = JQ(q)*qp ...where JQ = df(q)/dq
%-----------------
%Jacobian (dQ/dq)
aux = zeros(8,24);
aux(1:4,13:16) = eye(4);
aux(5:8,18:21) = eye(4);
hipsJ = hipsJacobian(robot);
JQ = [J_state_v(robot);robot.J_CoM(1:2,:);aux;hipsJ(1:2,:)];
Qp =  JQ*robot.qD;

