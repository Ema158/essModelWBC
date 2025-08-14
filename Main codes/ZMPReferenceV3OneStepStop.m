function [Zref,tRef] = ZMPReferenceV3OneStepStop(N,Si,Sf,Di,Df)
    NSS = round(0.8*N);
    NDS = round(0.2*N);
    Zref = zeros(2,2*N);
    Zref(1,1:N) = Si*ones(1,N);
    Zref(2,1:N) = Di*ones(1,N); 
    
    Zref(1,N+1:(N+NDS)) = linspace(Si,Sf,NDS);
    Zref(2,N+1:(N+NDS)) = linspace(Di,Df/2,NDS);
    
    Zref(1,(N+1+NDS):(N+2*NDS)) = Sf*ones(1,NDS);
    Zref(2,(N+1+NDS):(N+2*NDS)) = Df/2*ones(1,NDS);
    
    Zref(1,(N+1+2*NDS):2*N) = Sf*ones(1,N-2*NDS);
    Zref(2,(N+1+2*NDS):2*N) = Df/2*ones(1,N-2*NDS); 
    
    tRef = 0:0.01:0.01*(size(Zref,2)-1);
end