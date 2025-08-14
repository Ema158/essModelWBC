function [Xref,ZMPRef] = MpcLIPOnlineJerkConstraintsDS(gait_parameters,X0,Zref,ZMax,ZMin,k,Px,Pu)
    global xpp
    Tstep = gait_parameters.T*(1/0.2); %Time step porque es el 20% del paso
    z = gait_parameters.z_i; %height
    g = gait_parameters.g;
    T = 0.005; %time step
    alpha=0.00001;
    gamma=1;
    N = round(Tstep/T); %horizon, also number of samples of one step
    A = [1 T (T^2)/2; 0 1 T; 0 0 1];
    B = [(T^3)/6; (T^2)/2; T];
    C = [1 0 -z/g];
    xk = [X0(1);X0(3);X0(5)];
    yk = [X0(2);X0(4);X0(6)];
    Q = eye(N,N)*alpha + gamma*(Pu'*Pu);
    %Constraints
    Aineq = [Pu;-Pu];
    bineqX = [ZMax(1,k:N+k-1)' - Px*xk;-ZMin(1,k:N+k-1)' + Px*xk];
    bineqY = [ZMax(2,k:N+k-1)' - Px*yk;-ZMin(2,k:N+k-1)' + Px*yk];
    %
    options = optimset('Display', 'off');
    pkX = gamma*Pu'*(Px*xk-Zref(1,k:N+k-1)');
    pkY = gamma*Pu'*(Px*yk-Zref(2,k:N+k-1)');
    xppp = quadprog(Q,pkX,Aineq,bineqX,[],[],[],[],[],options);
    yppp = quadprog(Q,pkY,Aineq,bineqY,[],[],[],[],[],options);
    xkNew = A*xk + B*xppp(1);
    ykNew = A*yk + B*yppp(1);
    ZMPRefXNew = C*xkNew;
    ZMPRefYNew = C*ykNew;
    Xref = [xkNew;ykNew];
    ZMPRef = [ZMPRefXNew;ZMPRefYNew];
    xpp(1) = xkNew(3);
    xpp(2) = ykNew(3);
end