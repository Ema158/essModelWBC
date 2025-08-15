function [Zref,tRef] = ZMPReferenceZero(Nsteps,N)
    Zref = zeros(2,(Nsteps+2)*N);
%     Zref(1,:) = 0.02*ones(1,(Nsteps+2)*N);
    Zref(2,:) = 0.00*ones(1,(Nsteps+2)*N);
    tRef = 0:0.005:0.005*(size(Zref,2)-1);
end