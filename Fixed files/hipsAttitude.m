function h = hipsAttitude(robot)
    Hips = robot.T(:,:,7)*robot.torso_f; % The orientation (in pitch, roll and yaw angles) of the hip is obtained from the transformation matrix  0T7
    % Frame 7 is the last frame of the support leg hip
    % Since frame 7 in zero potition (i.e. q=0 ) has a diferent orientation as frame 0. It must be oriented as frame 0, so that
    % the pitch yaw and roll angles have the same meaning for the torso and for the foot.
    % That's why a constant matrix "robot.torso_f" was used.
    h(3)=atan2(Hips(2,1),Hips(1,1));  % Yaw (phi) rotation around axis "Z"
    h(2)=atan2(-Hips(3,1),cos(h(3))*Hips(1,1)+sin(h(3))*Hips(2,1));  % Pitch (theta) rotation around axis "Y"
    h(1)=atan2(sin(h(3))*Hips(1,3)-cos(h(3))*Hips(2,3),-sin(h(3))*Hips(1,2)+cos(h(3))*Hips(2,2));% Roll (psi) rotation around axis "X"
end