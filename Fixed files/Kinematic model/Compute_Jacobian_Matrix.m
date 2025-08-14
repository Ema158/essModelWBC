function [ J] = Compute_Jacobian_Matrix( robot )
%Compute the Jacobian of the foot of the robot (complete parameters)
ant = robot.ant;
act = robot.act;
T = robot.T;
J = zeros(6,robot.joints+6);
% Ya que calcula la matriz jaconiana para calcular la velocidad del pie, se empieza en el MARCO 14, todos las columnas que
% corresponden a los marcos despues del 14 son 0.
F=14;

J(1:6,1:6)=eye(6);
J(1:3,4:6)=-cross_matrix(T(1:3,4,14)-T(1:3,4,1)); % ^0p14,1 = -^0p1,14 = -(^0p14 - ^0p1) % Vector de posición del marco 14 al 1 proyectado
                                                                                % en el marco 0 ??.. pero en FORMA DE MATRIZ ANTISIMETRICA ¿¿PORQUE??

while F~=1
        if act(F)~=0 
            J(1:3,act(F)+6) = robot.crossM(:,:,F)*(T(1:3,4,14)-T(1:3,4,F)); % Jv(:,act(F)+6) = ^0a_F x  ^0pF,14
            J(4:6,act(F)+6) = T(1:3,3,F);  % Jw(:,act(F)+6) = ^0a_F
        end
        F = ant(F);
end

end

