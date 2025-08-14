function [t,Xt,tau] = EssModelWbcStandingOneFootNoWBCTorque(X0,gait_parameters,robot)
T = gait_parameters.T;
time_step = 0.01;
current_time = 0;
samples = T/time_step;
X_final = X0;    
Xt = zeros(samples+1,length(X0));
Xt(1,:) = X0';
global ZMPRef Xref
tau = zeros(24,samples);
for i=1:samples
    timespan = [current_time, current_time + time_step];
    [Xref,ZMPRef] = MpcLIPOnlineV3(gait_parameters,[X_final(1);X_final(2);X_final(3);X_final(4)],robot.Zref,robot.ZMax,robot.ZMin,i,robot.Px,robot.Pu);
    Xtaux = ode4(@dynam_HZDMpcOutsideNoWBC,timespan,X_final);
    [~, ~, ~, ~, tau(:,i)] = Desired_qfpp_HZDtimeQPLipReferenceNoWBCTorque([ZMPRef(1);ZMPRef(2)],robot,X_final,gait_parameters,current_time);
    Xt(i+1,:) = Xtaux(end,:);
    X_final = Xtaux(end,:)';
    current_time = current_time + time_step;
end
t = 0:1e-2:T;
disp('-------------------------------------------');              