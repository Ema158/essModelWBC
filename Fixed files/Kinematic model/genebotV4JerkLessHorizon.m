function robot = genebotV4JerkLessHorizon(gait_parameters,N)
%%Generation of the robot datas

%% Number of joints
joints = 22;

%% ZERO joint positions
q = zeros(joints,1); 

%% Joint velocities
qD = zeros(joints,1);

%% Creating the robot structure
robot = struct('joints',joints,'q',q,'qD',qD);

%% CONSTANT transformation matrices to convert make all matrices 0Ti be aligned with the world frame (frame 0) at ZERO position
% ------------------------------------------
robot.q = q;
robot.T = DGM(robot);
Tconst = zeros(4,4,27);
for i=1:26
    Tconst(:,:,i) = eye(4);
    R = robot.T(1:3,1:3,i);
    Tconst(1:3,1:3,i) = R';
end    
robot.Tconst = Tconst;

%% Assigning DEFAULT joint positions
q(1)=0;
q(2)=0.1;
q(3)=-0.2;
q(4)=0.1;
q(5)=0;
q(6)=0;
q(7)=0;
q(8)=0;
q(9)=-0.1;
q(10)=0.2;
q(11)=-0.1;
q(12)=0;
%
q(13)=1.6;
q(14)=0;
q(15)=1.6;
q(16)=0.2;
q(17)=1.6;
q(18)=0;
q(19)=-1.6;
q(20)=-0.2;
q(21)=0;
q(22)=0;

robot.q = q;
robot.T = DGM(robot); % Modelo geométrico directo (calcula las matrices de transformación elementales del robot),
                       % y las asigna a la estructura "robot" en la variable T.                       

%% Robot mass information
PI = Mass_information;
M = PI.masse;
robot.mass = sum(M);
robot.PI = PI;

[robot.CoM,robot.J_CoM,robot.J_Ankle,robot.crossM,robot.J_CoMs] = compute_com(robot,PI);

%% Ankle frame (14) to world frame
robot.foot_f = [  0 0 1 0;
                  0 -1 0 0;
                  1 0 0 0;
                  0 0 0 1];
%% Hip frame (7) to world frame
robot.torso_f=[1     0          0      0; %habia un error en (1,2)
               0    0.7071   -0.7071   0;
               0     0.7071   0.7071   0;
               0        0       0      1];
   
%% Robot antecedent and joint list
robot.ant = [0,... 1
             1,... 2
             2,... 3
             3,... 4
             4,... 5
             5,... 6
             6,... 7
             7,... 8
             8,... 9
             9,... 10
             10,...11
             11,...12
             12,...13
             13,...14
             7,... 15
             15,...16
             16,...17
             17,...18
             18,...19
             7,...20
             20,...21
             21,...22
             22,...23
             23,...24
              7,...25
             25,...%26
             26]; %27
robot.act= [0,1,2,3,4,5,6,7,8,9,10,...
        11,12,0,13,14,15,16,0,17,18,19,...
        20,0,21,22,0];
T = gait_parameters.Tmuestreo;
z = gait_parameters.z_i;
g = gait_parameters.g;
A = [1 T (T^2)/2; 0 1 T; 0 0 1];
B = [(T^3)/6; (T^2)/2; T];
C = [1 0 -z/g];
Px = zeros(N,3);
Pu = zeros(N,N);
for i=1:(N)
   Px(i,:) = C*A^i;
   Pu(i,i) = C*B;
   for j=1:(N-i)
         Pu(i+j,j) = C*A^i*B; 
   end
end
robot.Px = Px;
robot.Pu = Pu;
end

