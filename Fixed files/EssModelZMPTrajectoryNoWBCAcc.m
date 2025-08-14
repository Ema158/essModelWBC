function [t,Xt,SupportFoot] = EssModelZMPTrajectoryNoWBCAcc(X0,gait_parameters)
T = gait_parameters.T;
SupportFootX = 0;
SupportFootY = 0;
SupportFoot = [SupportFootX,SupportFootY];
Xt = ode4(@dynam_HZDtimeLipReferenceOnlineAccNoWBC,0:1e-2:T,X0);
t = 0:1e-2:T;
disp('-------------------------------------------');                  