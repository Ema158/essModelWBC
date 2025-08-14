function Ome = OmeRPY(phi,theta)
%Computation of the transfert matrix for Jacobian computation in Roll,
%Pitch, Yaw representation

Ome = [ cos(phi)/cos(theta)    sin(phi)/cos(theta)   0;%Hip Yaw Roll Victor
        -sin(phi)              cos(phi)            0;
       cos(phi)*tan(theta)    sin(phi)*tan(theta)   1];
% Ome = [ -sin(phi)*cot(theta)    cos(phi)*cot(theta)   1;%Euler
%         cos(phi)             sin(phi)         0;
%        sin(phi)/sin(theta)    -cos(phi)*sin(theta)   0];
%    
%Ome = [ cos(phi)*tan(theta)  sin(phi)*tan(theta)    1;%Hip Yaw Roll Khalil
% 
%         -sin(phi)              cos(phi)            0;
%          cos(phi)/cos(theta)   sin(phi)/cos(theta)   0]; 
end

