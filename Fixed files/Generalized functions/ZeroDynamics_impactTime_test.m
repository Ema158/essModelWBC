function [Qplus,QPplus,ErrorQ, ErrorQp] = ZeroDynamics_impactTime_test(qf,qfp0,robot,gait_parameters)

% This function check if the new states after the impact are inside the Zero dynamics, i.e. if the new states could be
% defined by the desired evolution of the CoM given by polinomials in the contraints

%-----------------------------------
% Current positions Q+ = f(q) and Velocities Qp+ = J_Q(q)*qp
% Desired positions Q_d+ = f_d(Phi) and Velocities Qp_d+ = J_Phi(Phi)*Phip
%-----------------------------------
[Qplus, QPplus] = current_states(robot);

% Desired Positions and velocities
%-----------------------------------
t0 = 0;
[Qplus_d, QPplus_d] = current_desired_states_Phi(qf,qfp0,gait_parameters,t0);

ErrorQ = Qplus-Qplus_d;
ErrorQp = QPplus-QPplus_d;

% % Result:  If it is zero, it means we are in the Zero dynamics
Qt = max(abs(ErrorQ));    % Error in position of states Q
Qpt = max(abs(ErrorQp)); % Error in velocity of states Qp
fprintf('After impact max(|Q(q)+ - Q_d(Phi)+|) = %e\n',Qt);
fprintf('After impact max(|Qp(q,qp)+ - Qp_d(Phi,Phip)+|) = %e \n',Qpt);

error = 1e-5; % Admissible error
if Qt>error
    warning('After impact, state positions Q could be out the Manifold (HZD)')
end

if Qpt>error
    warning('After impact, state velocities Qp could be out the Manifold (HZD)')
end
