function [Zref,tRef] = ZMPReferenceV3OneStepStopGaitZMPVariableX(N,Si,Sf,Di,Df)
    dispx = 0.04;
    NSS = round(0.8*N);
    NDS = round(0.2*N);
    Zref = zeros(2,2*N);
    Zref(1,1:NSS) = linspace(Si,Si+dispx,NSS);
    Zref(2,1:NSS) = Di*ones(1,NSS); 
    
    Zref(1,NSS+1:(N)) = linspace(Si+dispx,Sf,NDS);
    Zref(2,NSS+1:(N)) = linspace(Di,Df,NDS);
    
    Zref(1,(N+1):N+NSS) = Sf*ones(1,NSS);
    Zref(2,(N+1):N+NSS) = Df*ones(1,NSS); 
    
    Zref(1,(N+1+NSS):2*N) = Sf*ones(1,NDS);
    Zref(2,(N+1+NSS):2*N) = Df*ones(1,NDS); 
    
    tRef = 0:0.01:0.01*(size(Zref,2)-1);
end