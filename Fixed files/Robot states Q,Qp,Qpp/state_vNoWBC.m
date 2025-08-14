% state_v  are the 20 controlled "coordinates" [zp,xp_s,xp_s,xp_s,theta_s, phi_s, psi_s, qp_t^T], the first 11 ones are
% operational coordinates and the last ones are joint coordinates (correspondiing to the robot upper body)
% 
function h = state_vNoWBC(robot)
%Computation of the h function for virtual constraint
h = zeros(22,1);

%% Constraints for the top of the body
h(11:22)=robot.q(13:24);  % 10 last coordinates correspond to:
% q20 , q21 (2 joints) head
% q12 a q15 (4 joints) Right arm
% q16 a q19 (4 joints) Left arm

% The next 11 operational coordinates are defined fot the hip, low torso and free foot
%% CoM position
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

%% Hips yaw,pitch,roll
Hips = robot.T(:,:,7)*robot.torso_f; % The orientation (in pitch, roll and yaw angles) of the hip is obtained from the transformation matrix  0T7
% Frame 7 is the last frame of the support leg hip
% Since frame 7 in zero potition (i.e. q=0 ) has a diferent orientation as frame 0. It must be oriented as frame 0, so that
% the pitch yaw and roll angles have the same meaning for the torso and for the foot.
% That's why a constant matrix "robot.torso_f" was used.
h(10)=atan2(Hips(2,1),Hips(1,1));  % Yaw (phi) rotation around axis "Z"
h(9)=atan2(-Hips(3,1),cos(h(10))*Hips(1,1)+sin(h(10))*Hips(2,1));  % Pitch (theta) rotation around axis "Y"
h(8)=atan2(sin(h(10))*Hips(1,3)-cos(h(10))*Hips(2,3),-sin(h(10))*Hips(1,2)+cos(h(10))*Hips(2,2));% Roll (psi) rotation around axis "X"
h(10) = robot.q(6) + robot.q(7);
%Ya no se usara esta h
% %% Torso yaw
% Torso = robot.T(:,:,15); % The orientation around Z (yaw angle) of the low torso is obtained from the transformation matrix  0T15
% % It seems that this coordinates can be substituted only by "q13".. 
% h(11)=atan2(Torso(2,1),Torso(1,1));  % Yaw (psi) rotation around axis "Z"

end

