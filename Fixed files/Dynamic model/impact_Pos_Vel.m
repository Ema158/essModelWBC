function [qfp_plus,robot] = impact_Pos_Vel(robot,v_foot_z_D)
%Impact and Relabelling computation
% v_foot_z_D ->  Desired landing velocity of the free foot in Z direction
%            if v_foot_z_D = 0 NO impact is desired.... if v_foot_z_D = "other value" AN impact is expected
if nargin == 1  % If the function recibe just one argument, we assume an impact is expected.
    v_foot_z_D = 1; %Variable booleana
end

%Computation of landing foot velocity
J = Compute_Jacobian_Matrix(robot);
v_foot = [1 0 0 0 0 0;
          0 -1 0 0 0 0;
          0 0 1 0 0 0;
          0 0 0 -1 0 0;
          0 0 0 0 1 0;
          0 0 0 0 0 -1]*J*[zeros(6,1);robot.qD]; %
      
% Relabelling
% =========================
% IMPORTANT NOTE: it doesn't take into account the top of the body
q = robot.q;
q(1:12)=[q(12);-q(11);-q(10);-q(9);q(8);-q(7);-q(6);q(5);-q(4);-q(3);-q(2);q(1)];  % q+ = E*q- Cambio q6-q7
                  % now the positive twist is from -Y to X instead of X to Y (or viceversa)
q(23)=-q(23); % Neck_yaw
q([13,18])=[q(18),q(13)]; % Swap Shoulders Pitch
% CHECK THIS SWAPING....
q([14,15,16,19,20,21])=[-q(19),-q(20),-q(21),-q(14),-q(15),-q(16)]; 
% NOTE  that all joints of the upper body must be swaped 
%       However since they are hadn't be used before They remain unswaped. Now we're gona do it liltte by little =P
robot=robot_move(robot,q);
%-----------------------------
% The same relabeling for velocity
qD = robot.qD;
qD(23)=-qD(23); % Neck_yaw
qD([13,18])=[qD(18),qD(13)]; % Swap Shoulders Pitch
% CHECK THIS SWAPING....
qD([14,15,16,19,20,21])=[-qD(19),-qD(20),-qD(21),-qD(14),-qD(15),qD(16)]; % creo esta mal
qD(1:12) = [qD(12);-qD(11);-qD(10);-qD(9);qD(8);-qD(7);-qD(6);qD(5);-qD(4);-qD(3);-qD(2);qD(1)]; % qp+ = E*qp-
robot.qD = qD;
% Frome now on, all the computation are measured w.r.t. the NEW frame orientation 

%Impact computation (single impact) (All Equations are written in Damian SIX Master thesis)
% =================================
J = [eye(6), zeros(6,24)];     % Equation 3.16
A = Compute_Inertia_Matrix(robot, 'complet');  % "De" Eq. 2.40
qeD_moins = [v_foot;robot.qD];
qeD_plus = (eye(robot.joints+6) - A\J'/(J/A*J')*J)*qeD_moins; % qp+ = (I_37 - inv(De)*J^T*inv(J*inv(De)*J^T))*E*qp- Eq.3.20
%Support foot velocity after impact (take off)
v_foot2 = robot.J_Ankle*qeD_plus(7:end); % [v; w] = Jankle*qp  
ome_foot2 = [0;0;0];% Velocidad angular del pie de despegue
for i = 2:13
    ome_foot2 = ome_foot2+robot.T(1:3,3,i)*qeD_plus(i+5);
end
%Computation of the four foot corners vertical velocity
corner1 = v_foot2(3)+0.025*ome_foot2(1);%Distancias del marco 1 a las esquinas del pie
corner2 = v_foot2(3)-0.025*ome_foot2(1);
corner3 = v_foot2(3)-0.025*ome_foot2(1)-0.155*ome_foot2(2);
corner4 = v_foot2(3)-0.025*ome_foot2(1)-0.155*ome_foot2(2);
takeoff=corner1>0 && corner2>0 && corner3>0 && corner4>0;

% Now that we already have "qpe^+" we can use it to calculate "Fimp"...
F =linsolve(J',A*(qeD_plus-qeD_moins)); % J^TF = p^+ - p^- where p is the angular momentum (p = D*qp) thus => F = inv(J^T)*De(qpe^+ - qpe^-)

%Zmp on landing foot
zmp_x = -F(5)/F(3) + 0.1;
zmp_y = F(4)/F(3);

%Test for impact (no sliding, zmp, foot takes off)
mu = 0.7; % Friction

% test = takeoff && F(3)>0 && zmp_x>-0.055 &&...
%     zmp_x < 0.100 && zmp_y>-0.025 && zmp_y<0.025 && sqrt(F(1)^2+F(2)^2)<mu*abs(F(3));
% if test ==0
%     warning('Invalid impact');
% end

test1 = takeoff && F(3)>0; 
test2 = zmp_x>-0.055 &&  zmp_x < 0.100 && zmp_y>-0.025 && zmp_y<0.025;
test3 = sqrt(F(1)^2+F(2)^2)<mu*abs(F(3));

if v_foot_z_D == 0 
    if norm(F)<1e-4  %The reaction force should be almost zero (teorically it must be zero)        
        disp('No impact is produced as expected =)')
    else
        warning('An impact was produced but not expected!')
    end
else
    if  test1 ==0
        warning('Invalid impact: Take off of the support foot');
    end
    if  test2 ==0
        warning('Invalid impact: ZMP outside of the support foot hull');
    end
    if  test3 ==0
        warning('Invalid impact: Slipping of the support foot');
    end
end
% The new velocities are...
robot.qD = qeD_plus(7:end); % Since qeD are the velocities of the "extended model"
% Using the part of m*J_CoM inside "De" and multiplied by qp.. we obtain the momentum angular of de CoM
% i.e. sig_plus = A(7:8,7:end)*robot.qD;

% The new velocities of the CoM after impact are:
aux = zeros(8,24);
aux(1:4,13:16) = eye(4);
aux(5:8,18:21) = eye(4);
hipsJ = hipsJacobian(robot);
qfp_plus = [robot.J_CoM(1:2,:);aux;hipsJ(1:2,:)]*robot.qD;

end

