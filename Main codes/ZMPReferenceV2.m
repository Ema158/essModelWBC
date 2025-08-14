function [Zref,tRef] = ZMPReferenceV2(Nsteps,N,S,D)
    Zref = zeros(2,(Nsteps+1)*N);
    NSS = round(0.8*N);
    NDS = round(0.2*N);
    Zref(1,1:N) = zeros(1,N);
    
    Zref(2,1:NSS) = (D/2)*ones(1,NSS); %The first step there is no movement
    Zref(2,NSS+1:N) = linspace(D/2,0,NDS); %The first step there is no movement
    
    Zref(1,N+1:2*N-NDS) = zeros(1,NSS);
    Zref(1,N+1+NSS:2*N) = linspace(0,S,NDS);
    
    Zref(2,N+1:2*N-NDS) = zeros(1,NSS); %The first step there is no movement
    Zref(2,N+1+NSS:2*N) = linspace(0,D,NDS); %The first step there is no movement
    for i=1:(Nsteps+1)
        if mod(i,2)==0
            Zref(1,(i+1)*N+1:(i+2)*N-NDS) = (i)*S*ones(1,NSS);
            Zref(1,(i+1)*N+1+NSS:(i+2)*N) = linspace(i*S,(i+1)*S,NDS);
            
            Zref(2,(i+1)*N+1:(i+2)*N-NDS) = zeros(1,NSS);
            Zref(2,(i+1)*N+1+NSS:(i+2)*N) = linspace(0,D,NDS);
        else
            Zref(1,(i+1)*N+1:(i+2)*N) = (i)*S*ones(1,N);
            Zref(1,(i+1)*N+1+NSS:(i+2)*N) = linspace(i*S,(i+1)*S,NDS);
            
            Zref(2,(i+1)*N+1:(i+2)*N-NDS) = (D)*ones(1,NSS);
            Zref(2,(i+1)*N+1+NSS:(i+2)*N) = linspace(D,0,NDS);
        end
        if i==Nsteps+1
            Zref(1,(i+1)*N+1:(i+2)*N) = (i)*S*ones(1,N);
            if mod(i,2)==0
                Zref(2,(i+1)*N+1:(i+2)*N-NDS) = zeros(1,NSS);
                Zref(2,(i+1)*N+1+NSS:(i+2)*N) = linspace(0,D/2,NDS);
            else
                Zref(2,(i+1)*N+1:(i+2)*N-NDS) = (D)*ones(1,NSS);
                Zref(2,(i+1)*N+1+NSS:(i+2)*N) = linspace(D,D/2,NDS);
            end
        end
    end
    %
    Zref(1,(Nsteps+3)*N+1:(Nsteps+5)*N) = (Nsteps+1)*S*ones(1,2*N);
    Zref(2,(Nsteps+3)*N+1:(Nsteps+5)*N) = (D/2)*ones(1,2*N);
    tRef = 0:0.01:0.01*(size(Zref,2)-1);
end