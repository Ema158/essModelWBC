function Jhips = hipsJacobian(robot)
%% Hips yaw,pitch,roll
Hips = robot.T(:,:,7)*robot.torso_f;
phi=atan2(Hips(2,1),Hips(1,1));
theta=atan2(-Hips(3,1),cos(phi)*Hips(1,1)+sin(phi)*Hips(2,1));
J_T = zeros(3,robot.joints);
for i = 2:7
    J_T(:,i-1)=robot.T(1:3,3,i); % crea la matriz J_torso,w = [0a2, 0a3, 0a4, 0a5, 0a6, 0a7 0 ... 0] (3x22)
end
Jhips=OmeRPY(phi,theta)*J_T;
end