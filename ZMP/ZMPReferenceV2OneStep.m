function [Zref,tRef] = ZMPReferenceV2OneStep(N,Si,Sf,Di,Df)
    Zref = zeros(2,2*N);
    Zref(1,1:N) = Si*ones(1,N);
    Zref(2,1:N) = Di*ones(1,N); 
    Zref(1,N+1:2*N) = Sf*ones(1,N);
    Zref(2,N+1:2*N) = Df*ones(1,N); 
    tRef = 0:0.01:0.01*(size(Zref,2)-1);
end