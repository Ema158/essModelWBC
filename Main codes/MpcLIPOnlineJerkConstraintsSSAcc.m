function [Xref,ZMPRef] = MpcLIPOnlineJerkConstraintsSSAcc(gait_parameters,X0,Zref,ZMax,ZMin,k,Px,Pu)
    Tstep = gait_parameters.T*(1/0.8); %Time step porque es el 80% del tiempo total
    z = gait_parameters.z_i; %height
    g = gait_parameters.g;
    T = 0.005; %time step
    alpha=0.00001;
    gamma=1;
    N = round(Tstep/T); %horizon, also number of samples of one step
    A = [1 T; 0 1];
    B = [(T^2)/2; T];
    C = [1 0];
    D = -z/g;
    xk = [X0(1);X0(3)];
    yk = [X0(2);X0(4)];
    Q = eye(N+1,N+1)*alpha + gamma*(Pu'*Pu);
    %Constraints
    Aineq = [Pu;-Pu];
    bineqX = [ZMax(1,k:N+k-1)' - Px*xk;-ZMin(1,k:N+k-1)' + Px*xk];
    bineqY = [ZMax(2,k:N+k-1)' - Px*yk;-ZMin(2,k:N+k-1)' + Px*yk];
    %
    options = optimset('Display', 'off');
    pkX = gamma*Pu'*(Px*xk-Zref(1,k:N+k-1)');
    pkY = gamma*Pu'*(Px*yk-Zref(2,k:N+k-1)');
    xpp = quadprog(Q,pkX,Aineq,bineqX,[],[],[],[],[],options);
    ypp = quadprog(Q,pkY,Aineq,bineqY,[],[],[],[],[],options);
    xkNew = A*xk + B*xpp(1);
    ykNew = A*yk + B*ypp(1);
    ZMPRefXNew = C*xkNew + D*xpp(1);
    ZMPRefYNew = C*ykNew + D*ypp(1);
    Xref = [xkNew;xpp(1);ykNew;ypp(1)];
    ZMPRef = [ZMPRefXNew;ZMPRefYNew];
end