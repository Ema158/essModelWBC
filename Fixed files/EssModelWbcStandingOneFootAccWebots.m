function [t,Xt,SupportFoot] = EssModelWbcStandingOneFootAccWebots(X0,gait_parameters)
T = gait_parameters.T;
time_step = 0.01;
current_time = 0;
samples = T/time_step;
SupportFootX = 0;
SupportFootY = 0;
X_final = X0;   
SupportFoot = [SupportFootX,SupportFootY];
Xt = zeros(samples+1,length(X0));
Xt(1,:) = X0';
for i=1:samples
    timespan = [current_time, current_time + time_step];
    Xtaux = ode4(@dynam_HZDtimeLipReferenceOnlineAcc,timespan,X_final);
    Xt(i+1,:) = Xtaux(end,:);
    X_final = Xtaux(end,:)';
    current_time = current_time + time_step;
end
t = 0:1e-2:T;
disp('-------------------------------------------');                  