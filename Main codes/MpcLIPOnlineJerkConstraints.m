function [Xref,ZMPRef] = MpcLIPOnlineJerkConstraints(gait_parameters,X0,Zref,k,Px,Pu)
    global xpp
    Tstep = gait_parameters.T; %Time step
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
    limX = [-0.1;0.11]; %Walking
    limY = [-0.02;0.14]; %Walking 0.02-0.08
%     limX = [-0.1;0.1]; %Standing one Foot
%     limY = [-0.1;0.02]; %Standing one Foot
    Aineq = [Pu;-Pu];
    bineqX = [limX(2)*ones(N,1) - Px*xk;-limX(1)*ones(N,1) + Px*xk];
    bineqY = [limY(2)*ones(N,1) - Px*yk;-limY(1)*ones(N,1) + Px*yk];
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