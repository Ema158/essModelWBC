function [Q_d, Qp_d] = current_desired_states_Phi(qf,qfp,gait_parameters,t)
% This function give the current desired states of the robot Q_d -> 31x1 and Qp_d-> 31x1 where Q_d is given by
% Q_d = [   z_d(Phi) = h_d1(Phi)      	     % Desired position in z of the CoM 
%         x_foot,d(Phi) = h_d2(Phi)          % Desired position in x of the free foot.
%         y_foot,d(Phi) = h_d3(Phi)          % Desired position in y of the free foot.
%         z_foot,d(Phi) = h_d4(Phi)          % Desired position in z of the free foot.
%         psi_foot,d(Phi) = h_d5(Phi)        % Desired roll orientation. Rotation in x of the free foot.
%         theta_foot,d(Phi) = h_d6(Phi)      % Desired pitch orientation. Rotation in y of the free foot.
%         phi_foot,d(Phi) = h_d7(Phi)        % Desired yaw orientation. Rotation in z of the free foot.
%         psi_torso,d(Phi) = h_d8(Phi)       % Desired roll orientation. Rotation in x of the torso.
%         theta_torso,d(Phi) = h_d9(Phi)     % Desired pitch orientation. Rotation in y of the torso.
%         phi_torso,d(Phi) = h_d10(Phi)      % Desired yaw orientation. Rotation in z of the torso.
%         phi_Uper_torso,d(Phi) = h_d11(Phi) % Desired yaw orientation. Rotation in z of the upper torso.
%         q14,d(Phi) = h_d12(Phi)            % Desired 20 Joint positions of the rest of the upper body...
%         ...                                % from q14 to q15 corresponding to neck and arms...
%         q31,d(Phi) = h_d29(Phi)            %
%           x                       % REAL Position in x of the CoM (these two still be the same as the elementes in Q)
%           y]                      % REAL Position in y of the CoM 
% All "h_di" are plonomials functions that depend of "qf = [x; y]" and define some desired trayectories for each state variable
% and Qp_d = dQ_d/dt - > are the desired velocities.
global robot
x = qf(1);
y = qf(2);

Case = 'position';
% "Case", "gait_parameters", "qfp" and "t" are used inside "OptionDesiredTrajectory"
OptionDesiredTrajectory;
Case = 'velocity';
OptionDesiredTrajectory;

% Desired Positions
%-----------------
Hips = hipsAttitude(robot);
Q_d = [hd; x; y; robot.q(13:16); robot.q(18:21); Hips(1:2)']; 

% Desired velocities
%-----------------
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
%-------------------------
Qp_d = Jd*Phip;
%-------------------------

