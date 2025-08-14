% Jh (dim20x22) = Jacobiana de h(q), esta NOS SIRVE para calcular las vel. de las operacionales controladas (Qp) DESEADAS [zp,xp_s,xp_s,xp_s,qp_t^T] 
% (donde qp_T =  son las velocidades articulares del torso), a partir de las velocidades de las coordenadas operacionales qp = [qp1... qp21].
% Es decir,  Qp = dh(q)/dq*qp = Qp = JQ*qp.. (aunque aquí le llaman J_h)
function J_h = J_state_vNoWBC(robot)  
%Computation of the jacobian of h function for virtual constraint
J_h = zeros(robot.joints-2,robot.joints);
J_h(11:end,13:end) = eye(12);

%% CoM height
J_G=robot.J_CoM;
J_h(1,:)=J_G(3,:);

%% Foot position
J_h(2:4,:)=robot.J_Ankle;

%% Foot yaw,pitch,roll
Foot = robot.T(:,:,14)*robot.foot_f;
phi=atan2(Foot(2,1),Foot(1,1));
theta=atan2(-Foot(3,1),cos(phi)*Foot(1,1)+sin(phi)*Foot(2,1));
J_L = zeros(3,robot.joints);
for i = 2:13
    J_L(:,i-1)=robot.T(1:3,3,i); % crea la matriz J_foot,w = [0a2, 0a3, 0a4, 0a5, ..., 0a13, 0 ... 0] (3x22)
end
J_h(5:7,:)=OmeRPY(phi,theta)*J_L;

%% Hips yaw,pitch,roll
Hips = robot.T(:,:,7)*robot.torso_f;
phi=atan2(Hips(2,1),Hips(1,1));
theta=atan2(-Hips(3,1),cos(phi)*Hips(1,1)+sin(phi)*Hips(2,1));
J_T = zeros(3,robot.joints);
for i = 2:7
    J_T(:,i-1)=robot.T(1:3,3,i); % crea la matriz J_torso,w = [0a2, 0a3, 0a4, 0a5, 0a6, 0a7 0 ... 0] (3x22)
end
J_h(8:10,:)=OmeRPY(phi,theta)*J_T;
J_h(10,:) = [0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

%% Torso yaw No se usa
% Torso = robot.T(:,:,7);
% phi=atan2(Torso(2,1),Torso(1,1));
% theta=atan2(-Torso(3,1),cos(phi)*Torso(1,1)+sin(phi)*Torso(2,1));
% J_T = zeros(3,robot.joints);
% for i = 2:6
%     J_T(:,i-1)=robot.T(1:3,3,i);  % ....
% end
% J_T(:,13)=robot.T(1:3,3,15);      % crea la matriz J_UpperTorso,w = [0a2, 0a3, 0a4, 0a5, 0a6, 0a7, 0a15 0 ... 0] (3x31)
% Ome = OmeRPY(phi,theta);
% J_h(10,:)=Ome(3,:)*J_T;
end

