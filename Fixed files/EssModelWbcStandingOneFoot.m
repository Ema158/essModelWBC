function [t,Xt,SupportFoot] = EssModelWbcStandingOneFoot(X0,gait_parameters,N,robot,horizon)
global robot xpp
t = cell(1,N);
Xt = cell(1,N); 
SupportFoot = cell(1,N+2);
S = gait_parameters.S;
D = gait_parameters.D;
T = gait_parameters.T;
% g = gait_parameters.g;
% z0 = gait_parameters.z_i;
% omega = sqrt(g/z0); % the units are:  sqrt((m/s^2)/m) = 1/s
SupportFootX = 0;
SupportFootY = 0;
X_final = X0;  
for j=1:N    
    SupportFoot{j} = [SupportFootX,SupportFootY];
    Xt{j} = ode4(@dynam_HZDtimeLipReferenceOnlineJerk,0:1e-2:T,X_final);
    t{j} = 0:1e-2:T;
    % IMPORTANT: IN THIS PART of the CODE IS JUST FOR VISUALIZATION for the trajectory of the Desired ZMP.
    %            The REAL evolution of the ZMP will be obtained by runing code "M20_..." =)
    % Evolution of the ZMP 
    % Final states:
    X_final = Xt{j}(end,:)';
    disp('-------------------------------------------');
    % Initial conditions for the Next step
    %-------------------------                    
    SupportFootX = SupportFootX + S;
    SupportFootY = 0;
end