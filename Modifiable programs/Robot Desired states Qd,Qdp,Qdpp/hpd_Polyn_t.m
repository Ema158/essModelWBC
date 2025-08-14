function hp_d = hpd_Polyn_t(gait_parameters,t)
% % This is the first dereivative with respect to time of h_d, which is
% h_d = [   z_d(t) = h_d1(t)      	     % Desired position in z of the CoM 
%         x_foot,d(t) = h_d2(t)          % Desired position in x of the free foot.
%         y_foot,d(t) = h_d3(t)          % Desired position in y of the free foot.
%         z_foot,d(t) = h_d4(t)          % Desired position in z of the free foot.
%         psi_foot,d(t) = h_d5(t)        % Desired roll orientation. Rotation in x of the free foot.
%         theta_foot,d(t) = h_d6(t)      % Desired pitch orientation. Rotation in y of the free foot.
%         phi_foot,d(t) = h_d7(t)        % Desired yaw orientation. Rotation in z of the free foot.
%         psi_torso,d(t) = h_d8(t)       % Desired roll orientation. Rotation in x of the torso.
%         theta_torso,d(t) = h_d9(t)     % Desired pitch orientation. Rotation in y of the torso.
%         phi_torso,d(t) = h_d10(t)      % Desired yaw orientation. Rotation in z of the torso.
%         q13,d(t) = h_d11(t)            % Desired 10 Joint positions of the rest of the upper body...
%         ...                            % ...
%         q22,d(t) = h_d20(t)]           % ...

PolyCoeff = gait_parameters.PolyCoeff;

% Velocity
% ------------------------
hp_d = zeros(12,1);
for i=1:12
    hp_d(i) =  polyval(polyder(PolyCoeff.(['hd', int2str(i)]) ),t);
end
