function dPhi_dhd_x = dPhi_dhd_x_Polyn(gait_parameters,Phi)
% % This is the partial dereivative of "dhd_x" with respect to "Phi = [qf^T phi^T]".
% Remember that..
% h_d = [   z_d(Phi) = h_d1(Phi)      	     % Desired position in z of the CoM 
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
%         q14,d(Phi) = h_d12(Phi)            % Desired 18 Joint positions of the rest of the upper body...
%         ...                                % ...
%         q31,d(Phi) = h_d29(Phi)]           % ...
% dhd_x - > is the partial derivative of vector "h_d" w.r.t. "x"
% In other words, "dPhi_dhd_x" is the partial derivative of the partial derivative of the plonomial w.r.t "x" w.r.t. 
% all vector "Phi". Nevertheles, in this case vector "Phi" just depends on "x" and "y", 

x = Phi(1);
PolyCoeff = gait_parameters.PolyCoeff;

% Al this vectors are used later (in other files) and along with other files if necesary (dPhi_dhd_y, etc)
% to compute the desired acceleration
% ---------------------------------------------------------------
dx_dhd_x = zeros(20,1);
for i=1:20
    dx_dhd_x(i) =   polyval(polyder(polyder(PolyCoeff.(['hd', int2str(i)]) )),x);
end
% Since all trajectories depends only on "x", the derivative w.r.t. "y" is zero
dy_dhd_x = zeros(20,1);

dPhi_dhd_x = [dx_dhd_x, dy_dhd_x];