function [q,qp,JPhi,JQ,Jd] = JointsPosVel_from_CoMPosVel_HZDtimeNoWBC(qf,qfp,robot,gait_parameters,t)
% Computation of Joints positions and velocities from CoM position and VELOCITIES
x = qf(1);
y = qf(2);
% Posiciones
%-----------------
q = InvGeometricHZDtimeNoWBC(x,y,robot,gait_parameters,t);
%-------------------------
robot = robot_move(robot,q);

Case = 'velocity';
% "Case", "gait_parameters", "qfp" and "x" are used inside "OptionDesiredTrajectory"
OptionDesiredTrajectoryNoWBC();

% Velocities
%-----------------
%Jacobian (dQ/dq)
JQ = [J_state_vNoWBC(robot);robot.J_CoM(1:2,:)];
%Matrix Jd
Jd = [dhd_Phi;    
        1, 0, zeros(1,phiDim);
        0, 1, zeros(1,phiDim)];
JPhi = JQ\Jd;

%-------------------------
qp = JPhi*Phip;
%-------------------------