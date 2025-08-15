function Zref = ZMPReference(Nsteps,N,S,D)
    Zref = zeros(2,(Nsteps+1)*N);
    Zref(1,1:N) = zeros(1,N);
    Zref(2,1:N) = (D/2)*ones(1,N); %The first step there is no movement
    Zref(1,N+1:2*N) = zeros(1,N);
    Zref(2,N+1:2*N) = zeros(1,N); %The first step there is no movement
    for i=1:(Nsteps+1)
        if mod(i,2)==0
            Zref(1,(i+1)*N+1:(i+2)*N) = (i)*S*ones(1,N);
            Zref(2,(i+1)*N+1:(i+2)*N) = zeros(1,N);
        else
            Zref(1,(i+1)*N+1:(i+2)*N) = (i)*S*ones(1,N);
            Zref(2,(i+1)*N+1:(i+2)*N) = (D)*ones(1,N);
        end
    end
    %
    Zref(1,(Nsteps+3)*N+1:(Nsteps+5)*N) = (Nsteps+1)*S*ones(1,2*N);
    Zref(2,(Nsteps+3)*N+1:(Nsteps+5)*N) = (D/2)*ones(1,2*N);
end