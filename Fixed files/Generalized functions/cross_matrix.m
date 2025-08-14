function r_cross = cross_matrix(r)
%Generate the cross product matrix for a vector
r_cross=[ 0     -r(3)   r(2); 
         r(3)   0       -r(1); 
         -r(2)  r(1)    0];
