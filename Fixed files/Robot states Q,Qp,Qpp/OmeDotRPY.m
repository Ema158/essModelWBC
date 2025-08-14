function OmeDot = OmeDotRPY(phi,theta,phip,thetap)
%Computation of the transfert matrix for Jacobian computation in Roll,
%Pitch, Yaw representation
% Given
% Ome = [ cos(phi)/cos(theta)    sin(phi)/cos(theta)   0;
%          -sin(phi)               cos(phi)            0;
%        cos(phi)*tan(theta)    sin(phi)*tan(theta)   1];

% Using Maple, the temporal derivative of "Ome" is given by
OmeDot = zeros(3,3);   
OmeDot(1,1) = (cos(phi)*sin(theta)*thetap-sin(phi)*phip*cos(theta))/cos(theta)^2;
OmeDot(1,2) = (sin(phi)*sin(theta)*thetap+cos(phi)*phip*cos(theta))/cos(theta)^2;
OmeDot(2,1) = -cos(phi)*phip;
OmeDot(2,2) = -sin(phi)*phip;
OmeDot(3,1) = (-sin(phi)*phip*sin(theta)*cos(theta)+cos(phi)*thetap)/cos(theta)^2;
OmeDot(3,2) = (cos(phi)*phip*sin(theta)*cos(theta)+sin(phi)*thetap)/cos(theta)^2;

end

