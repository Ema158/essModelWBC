function robot = genebot()
%%Generation of the robot datas

%% Number of joints
joints = 24;

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
q(2)=0.35; %0.1
q(3)=-0.7; %-0.2
q(4)=0.35; %0.1
q(5)=0;
q(6)=0;
q(7)=0;
q(8)=0;
q(9)=-0.35; %-0.1
q(10)=0.7; %-0.2
q(11)=-0.35; %-0.1
q(12)=0;
%
q(13)=1.6;
q(14)=0;
q(15)=1.6;
q(16)=0.2;
q(17) = 0.0;

q(18)=1.6;
q(19)=0;
q(20)=-1.6;
q(21)=-0.2;
q(22) = 0.0;

q(23)=0;
q(24)=0;

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
        11,12,0,13,14,15,16,17,18,19,20,...
        21,22,23,24,0];
end

