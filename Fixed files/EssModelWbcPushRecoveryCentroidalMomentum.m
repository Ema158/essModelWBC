function [t,Xt,SupportFoot] = EssModelWbcPushRecoveryCentroidalMomentum(X0,gait_parameters,N)
T = gait_parameters.T;
SupportFootX = 0;
SupportFootY = 0;
X_final = X0;   
SupportFoot = [SupportFootX,SupportFootY];
Xt = ode4(@dynam_HZDtimeLipReferenceOnlineAcc,0:1e-2:T*N,X_final);
t = 0:1e-2:T*N;
disp('-------------------------------------------');                  