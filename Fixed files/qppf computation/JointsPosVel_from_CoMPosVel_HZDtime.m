function [q,qp,JPhi,JQ,Jd] = JointsPosVel_from_CoMPosVel_HZDtime(qf,qfp,robot,gait_parameters,t)
% Computation of Joints positions and velocities from CoM position and VELOCITIES
% Posiciones
%-----------------
q = InvGeometricHZDtime(qf,robot,gait_parameters,t);
%-------------------------
robot = robot_move(robot,q);

Case = 'velocity';
% "Case", "gait_parameters", "qfp" and "x" are used inside "OptionDesiredTrajectory"
OptionDesiredTrajectory;

% Velocities
%-----------------
%Jacobian (dQ/dq)
aux = zeros(8,24);
aux(1:4,13:16) = eye(4);
aux(5:8,18:21) = eye(4);
hipsJ = hipsJacobian(robot);
JQ = [J_state_v(robot);robot.J_CoM(1:2,:);aux;hipsJ(1:2,:)];
%Matrix Jd
Jd = [dhd_Phi;    
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, zeros(1,phiDim);
        0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, zeros(1,phiDim);
        0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, zeros(1,phiDim);
        0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, zeros(1,phiDim);
        0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, zeros(1,phiDim);
        0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, zeros(1,phiDim);
        0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, zeros(1,phiDim);
        0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, zeros(1,phiDim);
        0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, zeros(1,phiDim);
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, zeros(1,phiDim);
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, zeros(1,phiDim);
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, zeros(1,phiDim)];
JPhi = JQ\Jd;

%-------------------------
qp = JPhi*Phip;
%-------------------------