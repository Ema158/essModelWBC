function [ A] = Compute_Inertia_Matrix(robot,str)
%Compute of the inertia matrix of the robot with reduced or complete parameterisation
ant = robot.ant;
act= robot.act;
Im = actuator_inertia;

if strcmp(str,'reduce')
    %Reduced parameters
    A = zeros(robot.joints,robot.joints);
    for i = 1:27
        if robot.PI.masse(i)~=0
            F=i;
            Jw = zeros(3,robot.joints);
            while F~=1
                Jw(:,act(F)) = robot.T(1:3,3,F);
                F = ant(F);
            end
            % For the computing of the part refers to the inertia Tensor of each link, it is necessary to express it w.r.t. frame 0
            % Next it is (more or less =P) explained how it is done:
            inter = robot.PI.CoM{i}; % ^iCoMi Center of mass of link i w.r.t. frame i
            % Parallel theorem application:
            % By taking the LOCAL center of mass i given by ^iCoMi = [x; y; z] matrix Yi can be built which is given by
            % Y = [y^2 + z^2,  -x*y     ,  -x,z    ;
            %        -x*y   , z^2 + x^2 ,  -y*z    ;
            %        -x*z   ,   -y*z    , x^2 + y^2]
            % which will be used to transform the Inertia Tensor expressed of link i w.r.t. the frame i, i.e. ^iI0_i,
            % to the position of the CoMi, i.e. Inertia tensor will be traslated to the CoMi location but with the same orientation
            % Thus, ^iI_i = ^iI0_i - mi*^iY is used, where ^iI0_i is the inertia tensor of link i w.r.t. frame i, and 
            %  ^iI_i is the inertia tensor of link i located in the CoMi with the same ORIENTATION of frame i.
            % Finally ^0I_i = ^0Ri*^iI_i*^iR0 is calculated, i.e. the inercia tensor of link i 
            % located in the CENTER OF MASS i, seen from frame 0, which will be used to compute the INERTIA MATRIX A 
            % (in the second term of the sumatory of A, i.e.  "^0ai^T*^0I_i*^0ai).            
            Y = [inter(2)^2+inter(3)^2,-inter(1)*inter(2),-inter(1)*inter(3);
             -inter(1)*inter(2),inter(3)^2+inter(1)^2,-inter(2)*inter(3);
             -inter(1)*inter(3),-inter(2)*inter(3),inter(1)^2+inter(2)^2];
            R = robot.T(1:3,1:3,i);  % ^0Ri Rotation matrix of frame i w.r.t. frame 0
            A = A+robot.PI.masse(i)*robot.J_CoMs(:,:,i)'*robot.J_CoMs(:,:,i)+ ... % Ai + mi*JCoMi^T*JCoMi + 
            Jw'*R*(robot.PI.I{i}-robot.PI.masse(i)*Y)*R'*Jw;                      % ^0ai^T*^0Ri*(^iI_i)*^iR0^0ai^T
        end
    end
    %Actuator inertias
    for k =1:24
        A(k,k)=A(k,k)+Im(k);
    end
else
    %Full parameterization * This model is useful for the impact calculation * 
    A = zeros(robot.joints+6,robot.joints+6);
    for i = 1:27
        if robot.PI.masse(i)~=0
            F=i;
            Jw = zeros(3,robot.joints);
            while F~=1
                Jw(:,act(F)) = robot.T(1:3,3,F);
                F = ant(F);
            end
            J_CoMv = [eye(3),-cross_matrix(robot.T(1:3,:,i)*[robot.PI.CoM{i};1]-robot.T(1:3,4,1)),robot.J_CoMs(:,:,i)];
            J_CoMw = [zeros(3,3),eye(3),Jw];
            inter = robot.PI.CoM{i};
            Y = [inter(2)^2+inter(3)^2,-inter(1)*inter(2),-inter(1)*inter(3);
             -inter(1)*inter(2),inter(3)^2+inter(1)^2,-inter(2)*inter(3);
             -inter(1)*inter(3),-inter(2)*inter(3),inter(1)^2+inter(2)^2];
            R = robot.T(1:3,1:3,i);
            A = A+robot.PI.masse(i)*(J_CoMv'*J_CoMv)+ ...
            J_CoMw'*R*(robot.PI.I{i}-robot.PI.masse(i)*Y)*R'*J_CoMw;
        end
    end
    for k =1:24
        A(k+6,k+6)=A(k+6,k+6)+Im(k);
    end
end

