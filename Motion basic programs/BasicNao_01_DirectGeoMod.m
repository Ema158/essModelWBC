clear all;
close all;
clc;
% ---------------------------------------------------------------------------------------------
currentfolder = pwd; % save current path
cd ..                % go one folder down (go out of the current folder and stay in the previous one)
add_paths;           % add all folders where all files are founded in order to acces to them
cd(currentfolder);   % return to the original path
% ---------------------------------------------------------------------------------------------
% Start of the code

% Drawing of the robot and joint coordinates modification. Direct geometric model
% -----------------------------------------------
% The structure of the robot is generated:
%      joints: 31
%           q: [31x1 double]
%          qD: [31x1 double]
%           T: [4x4x36 double]  0Ti trasnformation matrices
%      Tconst: [4x4x36 double]  constant trasnformation matrices to produce frames aligned to frame 0 at zero position -> OTi = 0Ti*0Tconst_i
%        mass: 40.8000
%          PI: [1x1 struct]            % See "Mass_information.m"
%               masse: [36x1 double]
%                 CoM: {1x36 cell}     % ^jCoMj, it is the CoM of link j w.r.t. frame j
%                   I: {1x36 cell}     % ^jIj i.e. is the inertia tensor of link j, located in the origin of frame j
%         CoM: [3x1 double]            % Global CoM of the robot See "compute_com.m"
%       J_CoM: [3x31 double]           % Jacobian matrix of the CoM of the robot See "compute_com.m" 
%     J_Ankle: [3x31 double]           % Jacobian matrix of the ankle of the robot See "compute_com.m" 
%      crossM: [3x3x36 double]         % Skew-symmetric matrix of vector "a" of transformation matrix Ti = [s n a p, 0 0 0 1] to perform cross products
%      J_CoMs: [3x31x36 double]        % Jacobian matrices for each CoM of the robot See "compute_com.m" 
%      foot_f: [4x4 double]            % Transformation matrix to convert the frame of the free foot (0T14) to the same orientation of the world
%     torso_f: [4x4 double]            % Transformation matrix to convert the frame of the hips "lower torso" (0T7) to the same orientation of the world
%         ant: [0 1 2 3 4 5 6 7 8 9 10 11 12 13 7 15 16 17 18 19 15 21 22 23 24 25 26 27 15 29 30 31 32 33 34 35] % Antecedent frames
%         act: [0 1 2 3 4 5 6 7 8 9 10 11 12 0 13 14 15 16 17 0 18 19 20 21 22 23 24 0 25 26 27 28 29 30 31 0] % Actuated frames (0-> no aactuated)
robot = genebot(); % The robot structure is created
% --------------------------------------------------------

% Now we can draw the robot in the DEFAULT configuration
% Support foot position
x0 = 0; 
y0 = 0;
figure(1)
robot_draw(robot,x0,y0)             % Supported on the right foot
% robot_draw_reverse(robot,x0,y0)     %  Supported on the left foot
% axis equal % In order to see all the axis with the same scale, thus the image of the robot will not be "deformed"
hold on
%plot_frames(robot.T,'c',.05,0); %(TT, COLOR, Size, OPT)
view(3) % to assigne a "standard" view in 3D
axis equal 

% Also, by using HEMERO pachage we can visualize each frame of the robot by using 
% if we don't have this package simply comment this lines
% hold on
% plot_frames(robot.T,'c',.05,0); %(TT, COLOR, Size, OPT)
% view(3) % to assigne a "standard" view in 3D
% axis equal
figure(2)
q=[0,-0.1,0.1,0,0,0,0,0,-0.3,0.2,0,0,1.3,0,pi/2,0.2,2.1,0,pi/2,0.2,0,0];
robot=robot_move(robot,q);
robot_draw(robot,x0,y0) 

hold on
%plot_frames(robot.T(:,:,7),'c',.05,0); %(TT, COLOR, Size, OPT)
% plot_frames(T_aligned(:,:,8),'r',.05,0); %(TT, COLOR, Size, OPT)
view(3) % to assigne a "standard" view in 3D
axis equal 
figure(3)
q=[0,-0.2,0.2,0,0,0,0,0,-0.2,0.2,0,0,1.2,0,pi/2,0.2,1.941,0,pi/2,0.2,0,0];
robot=robot_move(robot,q);
robot_draw(robot,x0,y0) 
hold on
view(3)
axis equal
figure(4)
q=[0.4,-0.2,0.2,0,0,0,0,0.8,-0.2,0.2,0,0,0,0,pi/2,0.2,0,0,pi/2,0.2,0,0];
robot=robot_move(robot,q);
robot_draw(robot,x0,y0) 
hold on
view(3)
axis equal
%/////////////////////////////////////////////
% Checking states of the robot
[Qfig1, Qpfig1] = current_states(robot);

%% ----------------------------------------------------------------------------------------
% Now we are going to plot it in ZERO position
%  - Then we are going to plot another frame in the CoM 7 (attached to the trunk)
%  - In Zero position we are going to rotate all frames in order to leave them aligned with the frame 0 (world)
%  - We are going to store the constant rotation of each matrix in order to use it later =) 
% -----------------------------------------------------------------------------------------
q = zeros(25,1);
% All data from robot structure is updated, i.e.
% transformation matrices, center of masses, jacobian matrices, etc...
robot = robot_move(robot,q); 

figure(2)
robot_draw(robot,x0,y0)    
% By using a modified funtion from HEMERO package
hold on
plot_frames(robot.T,'c',.05,0); %(TT, COLOR, Size, OPT)
view(3) 
axis equal 
% ------------------------------------------------------------------
% Plotting the mass attached to frame 7
hold on
mass7CoM0F7 = robot.T(:,:,7)*[robot.PI.CoM{7};1]; % ^0g{0,CoM7) = 0T7 * ^7g{7,CoM7) % The vector is now mesured from frame 0 w.r.t. frame 0
plot3(mass7CoM0F7(1),mass7CoM0F7(2),mass7CoM0F7(3),'bo')
% Drawing a frame with the same orientation as the world (frame 0) attached to the CoM7
% % Option 1 - Moving frame by taking into account the axis of that frame
% % -------------------------------
% trans = robot.PI.CoM{7}; % 7g{7,CoM7)
% %      frame 0T7  -> Traslated (according to its axes) -> Then is rotated  
% LowTorso = robot.T(:,:,7)*[eye(3),trans;0,0,0,1]*robot.torso_f; % 0Tcom7Rot = 0T7 * 7Tcom7 * com7Tcom7Rot
% plot_frames(LowTorso,'r',.04,0);
% Option 2 - Moving frame by taking into account the axis of that inertial frame (frame 0 at the base)
% -------------------------------
trans2 = robot.T(1:3,1:3,7)*robot.PI.CoM{7}; % 0g(7,Com7) = 0R7 * 7g{7,CoM7)
%      frame 0T7  -> Rotates - >  Then is traslated according to the axes of the fram 0
LowTorso2 = robot.T(:,:,7)*robot.torso_f*[eye(3),trans2;0,0,0,1];% 0Tcom7Rot = 0T7 * 7T7R * 7RTcom7Rot
plot_frames(LowTorso2,'b',.04,0);
view(3) 
axis equal 

% For understanding:
% robot.torso_f =    
%      0     1     0     0     % Since there are no translation we are going to focus only in rotation
%     -1     0     0     0     % i.e. 0R7
%      0     0     1     0
%      0     0     0     1
% Rotation matrix 0R7 convert the orientation of frame 7 into the orientation of frame 0 
%     Z           Z
%  Y  |           |         % It can be build like this
%   \ |           |         % The first row correspond to the X axis of frame 7, which is located in Y of of frame 0 i.e. (0,1,0) 
%    \|___X       |___ Y    % The second row correspond to the Y axis of frame 7, which is located in -X of of frame 0 i.e. (-1,0,0) 
%                  \        % The third row correspond to the Z axis of frame 7, which is located in Z of of frame 0 i.e. (0,0,1) 
%                   \ X
%      7           0

% Now by taking all this into account lets rotate all frames to be aligned with frame 0
Tconst = zeros(4,4,25);
T_xyz = zeros(4,4,25);
for i=1:36
    Tconst(:,:,i) = eye(4);
    R = robot.T(1:3,1:3,i);
    Tconst(1:3,1:3,i) = R';
    T_xyz(:,:,i) = robot.T(:,:,i)*Tconst(:,:,i);
end
    
figure(3)
robot_draw(robot,x0,y0)    
% By using a modified funtion from HEMERO package
hold on
plot_frames(T_xyz,'c',.05,0); %(TT, COLOR, Size, OPT)
plot_frames(LowTorso2,'b',.04,0);
view(3) 
axis equal 

%% -----------------------------------------------------------
% Now let's move the robot "manually"
% ------------------------------------------------------
% La posición inicial (en grados) es:
% q1	=	0       q12	=	0       q23	=	0
% q2	=	0       q13	=	0       q24	=	0
% q3	=	-5.7296	q14	=	0       q25	=	97.4028
% q4	=	0       q15	=	0       q26	=	-11.4592
% q5	=	0       q16	=	0       q27	=	0
% q6	=	0       q17	=	0       q28	=	-2.8648
% q7	=	0       q18	=	97.4028	q29	=	-85.9437
% q8	=	0       q19	=	11.4592	q30	=	0
% q9	=	0       q20	=	0       q31	=	0
% q10	=	5.7296	q21	=	2.8648			
% q11	=	0       q22	=	85.9437			
% NOTA: La posición se tiene que dar en RADIANES (sólo se puso así para tener mejor idea).
% Definición ----------------------
% q1 a q6   (6 joints) Pierna deracha: Tobillo, rodilla, cadera
% q7 a q12  (6 joints) Pierna izquierda: Cadera, rodilla, tobillo
% q13       (1 joint)  Tronco
% q14 , q15 (2 joints) Cuello
% q16 , q17 (2 joints) Ojos
% q18 a q24 (7 joints) Brazo derecho: Hombro, codo, muñeca
% q25 a q31 (7 joints) Brazo izquierdo: Hombro, codo, muñeca

% Pitch - Turn around "y" axis
% Roll - Turn around "x" axis
% Yaw - Turn around "z" axis

% INFORMATION OF JOINT COORDINATES used in MATLAB and by ANNE (it seems that in Choregraph)
% -------------------------------------------------------------------------------------------
% % Joint cordinates used in MATLAB
% q = zeros(31,1); % 31 joints are used
% q(1) = deg2rad(0);            % Frame  2 % Support roll Ankle +
% q(2) = deg2rad(0);            % Frame  3 % Support pitch Ankle +
% q(3) = -0.1 + deg2rad(0);     % Frame  4 % Support pitch knee +
% q(4) = deg2rad(0);            % Frame  5 % Support pitch hip +
% q(5) = deg2rad(0);            % Frame  6 % Support roll hip +
% q(6) = deg2rad(0);            % Frame  7 % Support yaw hip +
% q(7) = deg2rad(0);            % Frame  8 % Non-support yaw hip +
% q(8) = deg2rad(0);            % Frame  9 % Non-support roll hip +
% q(9) = deg2rad(-20);          % Frame 10 % Non-support pitch hip +
% q(10) = 0.1 + deg2rad(0);     % Frame 11 % Non-support pitch knee + 
% q(11) = deg2rad(0);           % Frame 12 % Non-support pitch Ankle +
% q(12) = deg2rad(0);           % Frame 13 % Non-support roll Ankle +
% q(13) = deg2rad(0);           % Frame 15 % Yaw Trunk +
% q(14) = deg2rad(0);           % Frame 16 % "Yaw" neck +
% q(15) = deg2rad(0);           % Frame 17 % Pitch neck +
% q(16) = deg2rad(0);           % Frame 18 % Pitch head +
% q(17) = deg2rad(0);           % Frame 19 % Roll head +
% q(18) = 1.7 +  deg2rad(0);    % Frame 21 % "Pitch" Right shoulder +
% q(19) = 0.2 + deg2rad(0);     % Frame 22 % Yaw Right shoulder +
% q(20) = deg2rad(0);           % Frame 23 % Roll Right elbow +
% q(21) = 0.05 + deg2rad(0);    % Frame 24 % Yaw Right elbow +
% q(22) = 1.5 + deg2rad(0);     % Frame 25 % Roll Right wrist +
% q(23) = deg2rad(0);           % Frame 26 % Yaw Right wrist +
% q(24) = deg2rad(0);           % Frame 27 % Pitch Right wrist +
% q(25) = 1.7 + deg2rad(0);     % Frame 29 % "Pitch" Left shoulder +
% q(26) = -0.2 + deg2rad(0);    % Frame 30 % Yaw Left shoulder +
% q(27) = deg2rad(0);           % Frame 31 % Roll Left elbow +
% q(28) = -0.05 + deg2rad(0);   % Frame 32 % Yaw Left elbow +
% q(29) = -1.5 + deg2rad(0);    % Frame 33 % Roll Left wrist +
% q(30) = deg2rad(0);           % Frame 34 % Yaw Left wrist +
% q(31) = deg2rad(0);           % Frame 35 % Pitch Left wrist +
 

q = zeros(31,1); % Se define el vector (columna) de posiciones 
q(1) = deg2rad(-180+180);
q(2) = deg2rad(-155+180); %
q(3) = -0.1 + deg2rad(-52); %
q(4) = deg2rad(-151+180); 
q(5) = deg2rad(-180+180);
q(6) = deg2rad(0);
q(7) = deg2rad(0);
q(8) = deg2rad(0);
q(9) = deg2rad(0); %
q(10) = 0.1 + deg2rad(0); %
q(11) = deg2rad(0); % 
q(12) = deg2rad(0);
q(13) = deg2rad(15);
q(14) = deg2rad(0);
q(15) = deg2rad(0);
q(16) = deg2rad(0);
q(17) = deg2rad(0);
q(18) = 1.7 +  deg2rad(0);
q(19) = 0.2 + deg2rad(0);
q(20) = deg2rad(0);
q(21) = 0.05 + deg2rad(0);
q(22) = 1.5 + deg2rad(0);
q(23) = deg2rad(0);
q(24) = deg2rad(0);
q(25) = 1.7 + deg2rad(0);
q(26) = -0.2 + deg2rad(0);
q(27) = deg2rad(0);
q(28) = -0.05 + deg2rad(0);
q(29) = -1.5 + deg2rad(0);
q(30) = deg2rad(0);
q(31) = deg2rad(0);

% Update robot structure
robot = robot_move(robot,q); 

figure(4)
robot_draw(robot,x0,y0)    
% By using a modified funtion from HEMERO package
hold on
plot_frames(robot.T,'c',.05,0); %(TT, COLOR, Size, OPT)
view(3) 
axis equal 

% Updating transformation matrices XYZ
for i=1:36
    T_xyz(:,:,i) = robot.T(:,:,i)*Tconst(:,:,i);
end
figure(5)
robot_draw(robot,x0,y0)    
% By using a modified funtion from HEMERO package
hold on
plot_frames(T_xyz,'r',.05,0); %(TT, COLOR, Size, OPT)
% Ploting frame of "LOW TORSO"
% --------------------
trans2 = robot.T(1:3,1:3,7)*robot.PI.CoM{7}; % 0g(7,Com7) = 0R7 * 7g{7,CoM7)
%      frame 0T7  -> Rotates - >  Then is traslated according to the axes of the fram 0
LowTorso2 = robot.T(:,:,7)*robot.torso_f*[eye(3),trans2;0,0,0,1];% 0Tcom7Rot = 0T7 * 7T7R * 7RTcom7Rot
plot_frames(LowTorso2,'b',.04,0);
% --------------------
view(3) 
axis equal 


%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------