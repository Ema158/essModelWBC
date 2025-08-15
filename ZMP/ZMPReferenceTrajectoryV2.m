function [Zref,tRef] = ZMPReferenceTrajectoryV2(N,muestrasTotal)
    Zref = zeros(2,muestrasTotal+2*N);
    Zref(2,:) = 0.05*ones(1,muestrasTotal+2*N);
    %
    %
    Zref(1,1:N) = linspace(0,0.02,N);
    Zref(2,1:N) = 0.05*ones(1,N);
    %
    Zref(1,N+1:2*N) = 0.02*ones(1,N);
    Zref(2,N+1:2*N) = linspace(0.05,0.1,N);
    %
    Zref(1,2*N+1:3*N) = linspace(0.02,-0.02,N);
    Zref(2,2*N+1:3*N) = 0.1*ones(1,N);
    %
    Zref(1,3*N+1:4*N) = -0.02*ones(1,N);
    Zref(2,3*N+1:4*N) = linspace(0.1,0.0,N);
    %
    Zref(1,4*N+1:5*N) = linspace(-0.02,0.02,N);
    Zref(2,4*N+1:5*N) = zeros(1,N);
    %
    Zref(1,5*N+1:6*N) = 0.02*ones(1,N);
    Zref(2,5*N+1:6*N) = linspace(0.0,0.05,N);
    %
    Zref(1,6*N+1:7*N) = linspace(0.02,0.00,N);
    Zref(2,6*N+1:7*N) = 0.05*ones(1,N);
    %
%     Zref(1,1:muestrasTotal+2*N) = 0.04*ones(1,muestrasTotal+2*N);
%     Zref(2,1:muestrasTotal+2*N) = 0.05*ones(1,muestrasTotal+2*N);
    %
    tRef = 0:0.005:0.005*(size(Zref,2)-1);
end