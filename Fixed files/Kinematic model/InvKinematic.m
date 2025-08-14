function qD = InvKinematic(Qp,robot)
%Inverse Kinematic from Q parameter variables 

J_G=robot.J_CoM; % Jacobiana del CoM del robot
aux = zeros(8,24);
aux(1:4,13:16) = eye(4);
aux(5:8,18:21) = eye(4);
hipsJ = hipsJacobian(robot);
J = [J_state_v(robot);J_G(1:2,:);aux;hipsJ(1:2,:)]; 
qD = J\Qp;

end

