function J = freeFootBasicJacobian(robot)  
%Computation of the jacobian of h function for virtual constraint
J = zeros(6,robot.joints);
%% Foot position
J(1:3,:)=robot.J_Ankle;
for i = 2:13
    J(4:6,i-1)=robot.T(1:3,3,i); % crea la matriz J_foot,w = [0a2, 0a3, 0a4, 0a5, ..., 0a13, 0 ... 0] (3x22)
end
end

