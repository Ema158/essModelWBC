function qD = InvKinematicNoWBC(Qp,robot)
%Inverse Kinematic from Q parameter variables 

J_G=robot.J_CoM; % Jacobiana del CoM del robot
J = [J_state_vNoWBC(robot);J_G(1:2,:)]; 
qD = J\Qp;

end

