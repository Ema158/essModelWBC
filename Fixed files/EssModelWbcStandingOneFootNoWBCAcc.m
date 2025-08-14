function [t,Xt,SupportFoot] = EssModelWbcStandingOneFootNoWBCAcc(X0,gait_parameters)
T = gait_parameters.T;
% g = gait_parameters.g;
% z0 = gait_parameters.z_i;
% omega = sqrt(g/z0); % the units are:  sqrt((m/s^2)/m) = 1/s
SupportFootX = 0;
SupportFootY = 0;
X_final = X0;    
SupportFoot = [SupportFootX,SupportFootY];
Xt = ode4(@dynam_HZDtimeLipReferenceOnlineAccNoWBC,0:1e-2:T,X_final);
t = 0:1e-2:T;
% IMPORTANT: IN THIS PART of the CODE IS JUST FOR VISUALIZATION for the trajectory of the Desired ZMP.
%            The REAL evolution of the ZMP will be obtained by runing code "M20_..." =)
% Evolution of the ZMP 
% Final states:              