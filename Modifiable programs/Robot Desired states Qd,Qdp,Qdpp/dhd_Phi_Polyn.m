function dhd_Phi = dhd_Phi_Polyn(gait_parameters,Phi)
% % This is the partial dereivative of "hd" with respect to vector "Phi = [qf^T phi^T]".
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

PolyCoeff = gait_parameters.PolyCoeff;
x = Phi(1);
% Al this vectors are used later (in other files) to compute the desired velocity
% ---------------------------------------------------------------
% dhd_x - > is the partial derivative of vector "h_d" w.r.t. "x"
% ------------------------
dhd_x = zeros(20,1);
for i=1:20
    dhd_x(i) =  polyval(polyder(PolyCoeff.(['hd', int2str(i)]) ),x);
end
% dhd_y - > is the partial derivative of vector "h_d" w.r.t. "y"
dhd_y = zeros(20,1);

dhd_Phi = [dhd_x, dhd_y];