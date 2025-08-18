function [Zref,tRef] = ZMPReferenceEquilibriumV2(muestrasTotal,N)
    Zref = zeros(2,muestrasTotal+N);
%     Zref(1,:) = 0.04*ones(1,muestrasTotal+N);
%     Zref(2,:) = 0.05*ones(1,muestrasTotal+N); % Push Recovery
    tRef = 0:0.01:0.01*(size(Zref,2)-1);
end