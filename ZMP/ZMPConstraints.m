function [ZrefMax,ZrefMin,pMaxX,pMaxY,pMinX,pMinY] = ZMPConstraints(Nsteps,N,S,D)
    offsety = 0.02; %0.1 0.02
    offsetx = 0.05; %0.0255 0.1
%     offsetx = 0.0255;
    NDS = round(0.2*N);
    ZrefMax = zeros(2,(Nsteps+1)*N);
    ZrefMin = zeros(2,(Nsteps+1)*N);
    
    ZrefMax(1,1:N) = zeros(1,N) + offsetx*ones(1,N);
    ZrefMax(2,1:N) = (D)*ones(1,N) + offsety*ones(1,N); 
    ZrefMin(1,1:N) = zeros(1,N) - offsetx*ones(1,N);
    ZrefMin(2,1:N) = zeros(1,N) - offsety*ones(1,N);
    
    ZrefMax(1,N+1:2*N-NDS) = zeros(1,N-NDS)+ offsetx*ones(1,N-NDS);
    ZrefMax(2,N+1:2*N-NDS) = zeros(1,N-NDS)+ offsety*ones(1,N-NDS);
    ZrefMax(1,2*N-NDS+1:2*N) = (S)*ones(1,NDS)+ offsetx*ones(1,NDS);
    ZrefMax(2,2*N-NDS+1:2*N) = (D)*ones(1,NDS)+ offsety*ones(1,NDS);
    ZrefMin(1,N+1:2*N) = zeros(1,N)- offsetx*ones(1,N);
    ZrefMin(2,N+1:2*N) = zeros(1,N)- offsety*ones(1,N);
    
    for i=1:(Nsteps+1)
        if mod(i,2)==0
            ZrefMax(1,(i+1)*N+1:(i+2)*N-NDS) = (i)*S*ones(1,N-NDS)+ offsetx*ones(1,N-NDS);
            ZrefMax(2,(i+1)*N+1:(i+2)*N-NDS) = zeros(1,N-NDS)+ offsety*ones(1,N-NDS);
            ZrefMax(1,(i+2)*N-NDS+1:(i+2)*N) = (i)*2*S*ones(1,NDS)+ offsetx*ones(1,NDS);
            ZrefMax(2,(i+2)*N-NDS+1:(i+2)*N) = (D)*ones(1,NDS)+ offsety*ones(1,NDS);
            ZrefMin(1,(i+1)*N+1:(i+2)*N) = (i)*S*ones(1,N)- offsetx*ones(1,N);
            ZrefMin(2,(i+1)*N+1:(i+2)*N) = zeros(1,N)- offsety*ones(1,N);
        else
            ZrefMax(1,(i+1)*N+1:(i+2)*N) = (i)*S*ones(1,N)+ offsetx*ones(1,N);
            ZrefMax(2,(i+1)*N+1:(i+2)*N) = (D)*ones(1,N)+ offsety*ones(1,N);
            ZrefMin(1,(i+1)*N+1:(i+2)*N) = (i)*S*ones(1,N)- offsetx*ones(1,N);
            ZrefMin(2,(i+1)*N+1:(i+2)*N-NDS) = (D)*ones(1,N-NDS)- offsety*ones(1,N-NDS);
            ZrefMin(2,(i+2)*N-NDS+1:(i+2)*N) = zeros(1,NDS)- offsety*ones(1,NDS);
        end
    end
    %
    ZrefMax(1,(Nsteps+3)*N+1:(Nsteps+5)*N) = (Nsteps+1)*S*ones(1,2*N)+ offsetx*ones(1,2*N);
    ZrefMax(2,(Nsteps+3)*N+1:(Nsteps+5)*N) = (D)*ones(1,2*N) + offsety*ones(1,2*N); 
    ZrefMin(1,(Nsteps+3)*N+1:(Nsteps+5)*N) = (Nsteps+1)*S*ones(1,2*N)- offsetx*ones(1,2*N);
    ZrefMin(2,(Nsteps+3)*N+1:(Nsteps+5)*N) = zeros(1,2*N) - offsety*ones(1,2*N);
    pMaxX = offsetx;
    pMaxY = offsety;
    pMinX = -0.02;
    pMinY = -offsety;
end