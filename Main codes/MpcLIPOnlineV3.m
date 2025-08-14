function [Xref,ZMPRef] = MpcLIPOnlineV3(gait_parameters,X0,Zref,ZMax,ZMin,k,Px,Pu)
    z = gait_parameters.z_i; %height
    g = gait_parameters.g;
    T = gait_parameters.Tmuestreo; %time step
    Thorizon = gait_parameters.Thorizon;
    alpha = 1e-3; %1e-3
    gamma=1;
    N = round(Thorizon/T); %horizon, also number of samples of one step
    A = [1 T; 0 1];
    B = [(T^2)/2; T];
    C = [1 0];
    D = -z/g;
    xk = [X0(1);X0(3)];
    yk = [X0(2);X0(4)];
    Q = eye(N+1,N+1)*alpha + gamma*(Pu'*Pu);
    Aineq = [Pu;-Pu];
    bineqX = [ZMax(1,k:N+k)' - Px*xk;-ZMin(1,k:N+k)' + Px*xk];
    bineqY = [ZMax(2,k:N+k)' - Px*yk;-ZMin(2,k:N+k)' + Px*yk];
    %
%     Aeq = zeros(1,N+1);
%     Aeq(1,end) = 1;
%     beq = 0;
    %
    options = optimset('Display', 'off');
    pkX = gamma*Pu'*(Px*xk-Zref(1,k:N+k)');
    pkY = gamma*Pu'*(Px*yk-Zref(2,k:N+k)');
    xpp = quadprog(Q,pkX,Aineq,bineqX,[],[],[],[],[],options);
    ypp = quadprog(Q,pkY,Aineq,bineqY,[],[],[],[],[],options);
%     xpp = quadprog(Q,pkX,[],[],[],[],[],[],[],options);
%     ypp = quadprog(Q,pkY,[],[],[],[],[],[],[],options);
    xkNew = A*xk + B*xpp(1);
    ykNew = A*yk + B*ypp(1);
    ZMPRefXNew = C*xk + D*xpp(1); 
    ZMPRefYNew = C*yk + D*ypp(1);
    Xref = [xkNew;xpp(1);ykNew;ypp(1)];
    ZMPRef = [ZMPRefXNew;ZMPRefYNew];
end