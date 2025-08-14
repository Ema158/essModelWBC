function [ZMax,ZMin] = ZMPConstraintsDSStop(N,Si,Sf,Di,Df)
    offsety = 0.02; %0.02 0.1
    offsetxFront = 0.05; %0.1 0.0255
    offsetxBack = 0.1;
    NSS = round(0.8*N);
    NDS = round(0.2*N);
    ZMax = zeros(2,2*N);
    ZMin = zeros(2,2*N);
    ZMax(1,1:N) = Si*ones(1,N) + offsetxFront*ones(1,N);
    ZMin(1,1:N) = Si*ones(1,N) - offsetxBack*ones(1,N);
    ZMax(2,1:NDS) = Df*ones(1,NDS) + offsety*ones(1,NDS);
    ZMin(2,1:NDS) = Di*ones(1,NDS) - offsety*ones(1,NDS);
    
    ZMax(2,NDS+1:N) = Df*ones(1,NSS)+ offsety*ones(1,NSS);
    ZMin(2,NDS+1:N) = Di*ones(1,NSS)- offsety*ones(1,NSS); 
    
    ZMax(1,N+1:2*N) = Sf*ones(1,N)+ offsetxFront*ones(1,N);
    ZMin(1,N+1:2*N) = Sf*ones(1,N)- offsetxBack*ones(1,N);
    ZMax(2,N+1:2*N) = Df*ones(1,N)+ offsety*ones(1,N); 
    ZMin(2,N+1:2*N) = Di*ones(1,N)- offsety*ones(1,N); 
   
end