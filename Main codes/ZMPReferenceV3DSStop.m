function [Zref,tRef] = ZMPReferenceV3DSStop(N,Si,Sf,Di,Df)
    NSS = round(0.8*N);
    NDS = round(0.2*N);
    Zref = zeros(2,2*N);
    Zref(1,1:N) = Si*ones(1,N);
    Zref(2,1:NDS) = linspace(Di,Df,NDS);
    Zref(2,NDS+1:N) = Df*ones(1,NSS);
    Zref(1,N+1:2*N) = Sf*ones(1,N);
    Zref(2,N+1:2*N) = Df*ones(1,N); 
    tRef = 0:0.01:0.01*(size(Zref,2)-1);
end