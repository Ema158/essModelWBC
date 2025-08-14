% state_v  are the 20 controlled "coordinates" [zp,xp_s,xp_s,xp_s,theta_s, phi_s, psi_s, qp_t^T], the first 11 ones are
% operational coordinates and the last ones are joint coordinates (correspondiing to the robot upper body)
% 
function h = state_v(robot)
%Computation of the h function for virtual constraint
h = zeros(12,1);

X=robot.CoM;
h(1)=X(3);   % Vertical position of the CoM in "z" axis w.r.t. the inertial frame on the support foot (all the coordinates are measured w.r.t. this frame)
%% Foot position
h(2:3)=robot.T(1:2,4,12); % Position "x" and "y" of the free foot is given by the vector "p" of the transformation matrix 0T12
% where the frame 12 is located on the ANKLE, but since frame 14 (located on the foot tip) has the same orientation we
% can use frame 12 in order to have the location of the free foot on his sole (coordinate z_f) exactly below the ankle
h(4)=robot.T(3,4,14); % Position "z" of the free foot is given by the third element of vector "p" of the transformation matrix 0T14
% Note that in order to have the position of these frames it is NOT NECESSARY to rotate them since their position will still be the same
% (since it is the frame origin). However, in order to compute the frame ORIENTATION (in pitch, roll and yaw) it is
% recommendable to rotate then and let them into the same orientation that the INERTIAL frame

%% Foot yaw, pitch,roll
Foot = robot.T(:,:,14)*robot.foot_f; % The orientation (in pitch, roll and yaw angles) of the free foot is obtained from the transformation matrix  0T14
% Frame 14 is taken as it, since in zero potition (i.e. q=0 ) this frame has the same orientation as frame 0
h(7)=atan2(Foot(2,1),Foot(1,1));  % Yaw (psi) rotación  alrededor del eje Z
h(6)=atan2(-Foot(3,1),cos(h(7))*Foot(1,1)+sin(h(7))*Foot(2,1)); % Pitch (theta) rotación  alrededor del eje Y
h(5)=atan2(sin(h(7))*Foot(1,3)-cos(h(7))*Foot(2,3),-sin(h(7))*Foot(1,2)+cos(h(7))*Foot(2,2)); % Roll (phi) rotación  alrededor del eje X
%
h(8) = robot.q(6) + robot.q(7);
h(11) = robot.q(23);
h(12) = robot.q(24);
h(9) = robot.q(17);
h(10) = robot.q(22);
end

