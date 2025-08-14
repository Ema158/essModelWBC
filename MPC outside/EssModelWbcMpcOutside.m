function [t,Xt,SupportFoot] = EssModelWbcMpcOutside(X0,gait_parameters,robot)
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
global ZMPRef Xref
for i=1:samples
    timespan = [current_time, current_time + time_step];
    
    [Xref,ZMPRef] = MpcLIPOnlineV3(gait_parameters,[X_final(1);X_final(2);X_final(13);X_final(14)],robot.Zref,robot.ZMax,robot.ZMin,i,robot.Px,robot.Pu);
    
    Xtaux = ode4(@dynam_HZDMpcOutside,timespan,X_final);
    
    
    Xt(i+1,:) = Xtaux(end,:);
    X_final = Xtaux(end,:)';
    current_time = current_time + time_step;
end
t = 0:1e-2:T;
disp('-------------------------------------------');                  