function h_d = hd_PolynNoWBC(gait_parameters,Phi)
% 
% h_d = [ z_d(Phi) = h_d1(Phi)      	     % Desired position in z of the CoM 
%         x_foot,d(Phi) = h_d2(Phi)          % Desired position in x of the free foot.
%         y_foot,d(Phi) = h_d3(Phi)          % Desired position in y of the free foot.
%         z_foot,d(Phi) = h_d4(Phi)          % Desired position in z of the free foot.
%         psi_foot,d(Phi) = h_d5(Phi)        % Desired roll orientation. Rotation in x of the free foot.
%         theta_foot,d(Phi) = h_d6(Phi)      % Desired pitch orientation. Rotation in y of the free foot.
%         phi_foot,d(Phi) = h_d7(Phi)        % Desired yaw orientation. Rotation in z of the free foot.
%         psi_torso,d(Phi) = h_d8(Phi)       % Desired roll orientation. Rotation in x of the torso.
%         theta_torso,d(Phi) = h_d9(Phi)     % Desired pitch orientation. Rotation in y of the torso.
%         phi_torso,d(Phi) = h_d10(Phi)      % Desired yaw orientation. Rotation in z of the torso.
%         q13,d(t) = h_d11(t)            % Desired 10 Joint positions of the rest of the upper body...
%         ...                            % ...
%         q22,d(t) = h_d20(t)]           % ...
PolyCoeff = gait_parameters.PolyCoeff;

% Position
% ------------------------
h_d = zeros(22,1);
for i=1:22
    h_d(i) = polyval(PolyCoeff.(['hd', int2str(i)]),Phi);
end
