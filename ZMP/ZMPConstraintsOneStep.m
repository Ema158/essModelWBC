function [ZMax,ZMin] = ZMPConstraintsOneStep(N,Si,Sf,Di,Df)
    offsety = 0.02; %0.02 0.1
%     offsetxFront = 0.0255; %0.0255 0.1
    offsetxBack = 0.1; %0.0255 0.1
    offsetxFront = 0.05; 
%     offsetxBack = 0.1;
    NSS = round(0.8*N);
    NDS = round(0.2*N);
    ZMax = zeros(2,2*N);
    ZMin = zeros(2,2*N);
    ZMax(1,1:NSS) = Si*ones(1,NSS) + offsetxFront*ones(1,NSS);
    ZMin(1,1:NSS) = Si*ones(1,NSS) - offsetxBack*ones(1,NSS);
    ZMax(2,1:NSS) = Di*ones(1,NSS) + offsety*ones(1,NSS);
    ZMin(2,1:NSS) = Di*ones(1,NSS) - offsety*ones(1,NSS);
    
    ZMax(1,NSS+1:N) = Sf + offsetxFront*ones(1,NDS);
    ZMin(1,NSS+1:N) = Si - offsetxBack*ones(1,NDS);
    
    ZMax(2,NSS+1:N) = Df + offsety*ones(1,NDS);
    ZMin(2,NSS+1:N) = Di - offsety*ones(1,NDS);
    
    ZMax(1,N+1:(N+NSS)) = Sf*ones(1,NSS)+ offsetxFront*ones(1,NSS);
    ZMin(1,N+1:(N+NSS)) = Sf*ones(1,NSS)- offsetxBack*ones(1,NSS);
    ZMax(2,N+1:(N+NSS)) = Df*ones(1,NSS)+ offsety*ones(1,NSS); 
    ZMin(2,N+1:(N+NSS)) = Df*ones(1,NSS)- offsety*ones(1,NSS); 
    
    ZMax(1,(N+1+NSS):2*N) = 2*Sf + offsetxFront*ones(1,NDS);
    ZMin(1,(N+1+NSS):2*N) = Sf - offsetxBack*ones(1,NDS); 
    
    ZMax(2,(N+1+NSS):2*N) = Df + offsety*ones(1,NDS);
    ZMin(2,(N+1+NSS):2*N) = Di - offsety*ones(1,NDS);
end