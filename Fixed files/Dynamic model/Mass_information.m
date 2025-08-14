% If you want to fold the code for each section in YOUR MATLAB go to
%    Editor/Debugger (MATLAB Preferences) > Code Folding and enable "Sections" by checking on it
function PI = Mass_information
%% Version of the  18 December 2017
% Information from .urdf of July 2015

%% I.   Masses - Center of Masses - Inertia Tensors
%  ============================================
% 
% The centers of masses positions and the inertial tensors are described
% relatively to the Aldebaran's local coordinate system of the current 
% solid (S) (o, R).
% The inertia tensors are expressed around the mass center. 
% i.e. ^SI0_i where S is a local fixed frame of Aldebaran and I0 is the
% inertia tensor
% 
% All solids (S) and Aldebaran's local coordinate system are described 
% relatively to the zero posture: standing with straight legs and arms 
% pointing forwards).
% 
% Masses are expressed in kg
% Estos valores fueron tomados de la documenacion de aldebaran
%http://doc.aldebaran.com/2-1/family/robots/masses_robot.html
M = zeros(27,1);

% CoM = [X_G ; Y_G ; Z_G]; kg/mÂ²
%
% I= [I_{xx} , I_{xy} , I_{xz} ;
%     I_{yx} , I_{yy} , I_{yz} ;
%     I_{zx} , I_{zy} , I_{zz}]; kg/mÂ²

%% Trunk
% Torso
% ------
M(7)   = 1.0496;

CoM{7} = [ -0.00413 ;
            0.0     ;
            0.04342];

I{7}          = [ 0.0050623407587  , 1.4311580344e-05,  0.000155119082081   ;
                  1.4311580344e-05,  0.0048801358789  , -2.7079340725e-05 ;
                   0.000155119082081  , -2.7079340725e-05,  0.001610300038  ];
			
% Nec
%HeadYaw
%----------
M(25)   = 0.07842;

CoM{25} = [ -1e-05 ;
           0.0     ;
          -0.02742];

I{25}          = [ 7.4992953159e-05  ,  1.5700000189e-09, -1.8339999741e-08 ;
                  1.5700000189e-09,  7.5999952969e-05  , -5.294999994e-08 ;
                 -1.83399997e-08  , -5.294999994e-08,  5.5337300182e-06   ];
		  
% Head
% Headpitch
%---------
M(26)   = 0.60533;

CoM{26} = [-0.00112 ;
            0.0        ;
           0.05258  ];

I{26}          = [ 0.0026312952396  ,  8.788139894e-06  , 4.0984661609e-05 ;
                  8.788139894e-06  , 0.0024911249056  ,  -2.995792056e-05   ;
                  4.0984661609e-05 , -2.99579205e-05  , 0.00098573567811    ];

% Arms
% Right Shoulder
% RShoulderPitch
%-----------
M(15)   = 0.09304;

CoM{15} = [ -0.00165 ;
            0.02663     ;
            0.00014];

I{15}   = [ 8.4284300101e-05  ,  2.0280199351e-06  ,  2.3380000158e-08 ;
           2.0280199351e-06  , 1.4155610188e-05  ,  1.9719999e-08   ;
           2.3380000158e-08  ,  1.9719999855e-08  , 8.6419488071e-05  ];
			
% Left Shoulder
% LShoulderPitch
%-----------
M(20)   = 0.09304;

CoM{20} = [ -0.00165 ;
            -0.02663     ;
            0.00014];

I{20}   = [ 8.4284300101e-05  ,  -2.0280199351e-06  ,  2.3380000158e-08 ;
           -2.0280199351e-06  , 1.4155610188e-05  ,  -1.9719999e-08   ;
           2.3380000158e-08  ,  -1.9719999855e-08  , 8.6419488071e-05  ];
% Right Biceps
% RShoulderRoll
%----------
M(16) = 0.15777;

CoM{16} = [ 0.02455 ;
            -0.00563 ;
            0.0033];

I{16}= [ 0.00011012030882  , 7.6691307186e-05  , -2.6046069252e-05;
        7.6691307186e-05  , 0.00036757651833  , 1.2098280422e-05 ;
         -2.6046069252e-05  , 1.2098280422e-05 , 0.00035461771768];

%Left Biceps
% LShoulderRoll
%----
M(21) = 0.15777;
    
CoM{21} = [ 0.02455 ;
            0.00563 ;
            0.0033];

I{21}= [ 9.3899929198e-05 , -4.7144520067e-05  , -2.6994710424e-05;
        -4.7144520067e-05  , 0.00037151877768  , -2.4597700303e-06 ;
         -2.6994710424e-05  , -2.4597700303e-06 , 0.00034190082806];  
     
% Right Elbow
% RElbowYaw
%----------------
M(17) = 0.06483;

CoM{17} = [-0.02744 ;
                0 ;
            -0.00014];

I{17}= [ 5.5971499933e-06  ,  4.2099999042e-09  ,  4.3189999133e-08 ;
        4.2099999042e-09  ,  7.5433119491e-05 ,  -1.8400000412e-09 ;
        4.3189999133e-08  ,  -1.8400000412e-09 ,  7.6443393482e-05];
		 
% Left Elbow
% LElbowYaw
%--------------
M(22) = 0.06483;

CoM{22} = [-0.02744 ;
                0 ;
            -0.00014];

I{22}= [ 5.5971499933e-06  ,  4.2099999042e-09  ,  4.3189999133e-08 ;
        4.2099999042e-09  ,  7.5433119491e-05 ,  -1.8400000412e-09 ;
        4.3189999133e-08  ,  -1.8400000412e-09 ,  7.6443393482e-05];
		 
% Right ForeArm
% RElbowRoll
%------------
M(18) = 0.07761;

CoM{18} = [0.02556 ;
           -0.00281 ;
           0.00076];

I{18}= [ 2.5390700102e-05 ,  2.3324300855e-06  , -6.0116997247e-07 ;
         2.3324300855e-06  ,  8.9220360678e-05  ,  2.6940000453e-08 ;
        -6.0116997247e-07  ,  2.6940000453e-08  , 8.7248430646e-05];

% Left ForeArm
% LElbowRoll
%-----------
M(23) = 0.07761;

CoM{23} = [ 0.02556 ;
            0.00281 ;
            0.00076];

I{23}= [ 2.5332199584e-05  , -2.3427101041e-06  , 7.4589998178e-08 ;
         -2.3427101041e-06 ,  8.91321979e-05  ,  -2.6549999532e-08 ;
         7.4589998178e-08 ,  -2.6549999532e-08 ,  8.7287262431e-05];
%//////////////////////////////////////////////////////Aqui
% Rigth hand
% M(19) = 0.0; %0
M(19) = 0.18533; %0
    
% CoM{19} = zeros(3,1);
CoM{19} = [0.03434;0.00088;0.00308];
    
% I{19} = zeros(3,3);
I{19} = [7.0549329e-5, 5.71599e-5, -2.247437e-5; 
        5.71599e-6, 0.00035606, 3.17777e-6;
        -2.247437e-5, 3.1777e-6, 0.000351];
% Left Hand
% LWristYaw
%-----------
% M(24) = 0.0; %0
M(24) = 0.18533; %0
    
% CoM{24} = zeros(3,1);
CoM{24} = [0.03434;-0.00088;0.00308];
    
% I{24} = zeros(3,3);
I{24} = [7.0549329e-5, 5.71599e-5, -2.247437e-5; 
        5.71599e-6, 0.00035606, 3.17777e-6;
        -2.247437e-5, 3.1777e-6, 0.000351];
% Legs
% Rigth Pelvis
% RHipYawPitch
M(6) = 0.06981;

CoM{6} = [ -0.00781 ;
             0.01114 ;
             0.02661];

I{6}= [ 8.9971952548e-05 , 5.0021899369e-06  , 1.2735249584e-05 ;
         5.0021899369e-06  , 0.00010552610911 , -2.770080027e-05;
         1.2735249584e-05  , -2.7700800274e-05  , 6.6887238063e-05];    

%Left Pelvis
%LHipYawPitch.
M(8) = 0.06981;

CoM{8} = [ -0.00781 ;
            -0.01114 ;
             0.02661];

I{8}= [ 8.1502330431e-05 , -4.9944901548e-06  , 1.27481698664e-05 ;
         -4.994490154e-06  , 0.00010132555326 ,  2.3454740585e-05;
         1.2748169866e-05  , 2.3454740585e-05  , 6.2623628764e-05];
     
%% Right Hip          
% RHipRoll
%----------------
M(5) = 0.14053;

CoM{5} = [-0.01549 ;
           -0.00029 ;
           -0.00515];

I{5}= [ 2.7586540455e-05  , -1.9190000e-08  , -4.108219855e-06;
        -1.91900007e-08  ,  9.8269956652e-05 , 2.5099999856e-05 ;
        -4.108219855e-06  , 2.5099999856e-09 , 8.8103319285e-05];
	
% Left Hip
% LHipRoll
%--------------
M(9) = 0.14053;

CoM{9} = [-0.01549 ;
            0.00029 ;
           -0.00515];

I{9}= [ 2.7583539122e-05  , -2.2329999183e-08  , -4.0816398723e-06;
        -2.2329999183e-08  ,  9.8270553281e-05 , -4.1899999026e-09 ;
        -4.0816398723e-06  ,  -4.1899999026e-09 , 8.809973223e-05];
	
% Right Thigh
% RHipPitch
%------------
M(4) = 0.38968;

CoM{4} = [ 0.00138 ;
           -0.00221;
           -0.05373];

I{4}= [ 0.0016374820843 ,  -8.3954000729e-07  , 8.5883009888e-05;
        -8.3954000729e-07  , 0.0015922139864  , -3.9176258724e-05;
         8.5883009888e-05 , -3.9176258724e-05  , 0.00030397824594];
	
% Left Thigh
% LHipPitch
%-----------
M(10) = 0.38968;

CoM{10} = [ 0.00138 ;
            0.00221;
           -0.05373];

I{10}= [ 0.001636719564  , 9.2451000455e-07  , 8.5306681285e-05;
         9.2451000455e-07 , 0.001591072767  ,  3.8361598854e-05;
         8.5306681285e-05 , 3.8361598854e-05 , 0.00030374340713];
	
% Right Tibia
% RKneePitch
%------------
M(3) = 0.30142;

CoM{3} = [ 0.00453;
           -0.00225;
           -0.04936];

I{3}= [ 0.0011828296119 , -8.96500012e-07  , 2.7996900826e-05;
        -8.96500012e-07  ,  0.0011282785563 , -3.8476038753e-05;
         2.7996900826e-05  , -3.8476038753e-05  ,0.00019145276747];
	
% Left Tibia
% LKneePitch
%-----------
M(11) = 0.30142;

CoM{11} = [ 0.00453;
            0.00225;
           -0.04936];

I{11}= [ 0.0011820796644 , 6.3362000446e-07  , 3.6496971006e-05;
         6.3362000446e-07  ,  0.0011286522495 , 3.949522943e-05;
         3.6496971006e-05  , 3.949522943e-05  ,0.00019322744629];
	
% Right Ankle
% RAnklePitch
%-------------
M(2) = 0.13416;

CoM{2} = [ 0.00045 ;
           -0.00029;
            0.00685];

I{2}= [ 3.8508129364e-05 , 6.4339999994e-08  , 3.8746597966e-06 ;
         6.4339999994e-08  , 7.4310817581e-05  , -4.5799999349e-09;
         3.8746597966e-06  , -4.5799999349e-09  , 5.491311822e-05];

%Left Ankle
%LAnklePitch
%-----
M(12) = 0.13416;

CoM{12} = [ 0.00045 ;
            0.00029;
            0.00685];

I{12}= [ 3.8509781007e-05 ,-2.6340000403e-08  , 3.8619400584e-06 ;
        -2.6340000403e-08  , 7.4265262811e-05  , 1.8339999741e-08;
         3.8619400584e-06  , 1.8339999741e-08  , 5.4865398852e-05];
     
%Right Foot    
% RAnkleRoll
%---------
M(1) = 0.17184;

CoM{1} = [ 0.02542;
          -0.0033;
          -0.03239];

I{1}= [ 0.00026930202148 , 5.87505001921e-06  , 0.00013913327712 ;
        5.8750501921e-06  , 0.00064347387524  , -1.8849170374e-05 ;
        0.00013913327712 , -1.884917037e-05  , 0.000525034478946];
	
%Left Foot
% LAnkleRoll
%--------
M(13) = 0.17184;

CoM{13} = [ 0.02542;
           0.0033;
          -0.03239];

I{13}= [ 0.00026944180718 , -5.6957201195e-06  , 0.00013937948097 ;
       -5.6957201195e-06  , 0.0006443420817  , 1.8740920495e-05 ;
        0.000139379948097 , 1.8740920495e-05 , 0.00052575673908];
    
 %--------------------- virtual frame in the tip of the left foot

M(14) = 0;
CoM{14} = zeros(3,1);
I{14}= zeros(3,3);

M(27)=0;
CoM{27}=zeros(3,1);
I{27}=zeros(3,3);

%////////////////////////////////////////////////////////////////////////

%% III. Transformation matrices w.r.t frame 0 (Tip of the RFoot)
joints = 24;
q = zeros(joints,1); 
qD = zeros(joints,1);
robot = struct('joints',joints,'q',q,'qD',qD);
T0=DGM(robot);
  
%% IV.  Calculation of I. in M-DH frames

% Base change I_j = inv(P_j) I_j_s P_j

% Transport I_j = I_j_s + M Y_s
% with Y_s = [b^2+c^2,-a*b,-a*c;
%             -a*b,c^2+a^2,-b*c;
%             -a*c,-b*c,a^2+b^2]:
% Knowing CoM = [a;b;c];

% Transport of the CoM 
% d_xg = d_x - d_x_0
% d_yg = d_y - d_y_0
% d_zg = d_z - d_z_0

% % Rotation matrices 
P = cell(1,27);
for i = 1:27
	P{i} = inv(T0(1:3,1:3,i));  % P = jR0
end

% % Translation of the frames
vec_C = cell(1,27);
for i = 1:27
    vec_C{i} = [0;0;0];
end
 % vec_C que creo que son
 % Es un vector de traslacion para que los marcos de los centros de masa
 % coincidan con los marcos DH. Solo son 4 marcos los que no coinciden y
 % necesitan una traslacion:
    vec_C{1}=[0.095;0;-0.046];
    vec_C{3}=[0;0;-0.1];
    vec_C{4}=[0;0;-0.1];
    vec_C{7} = [0;0;-0.0350];     %to translate to the Torso
    
for i = 1 : 27
    C = vec_C{i}; %vec_C contient les vecteurs de translation des repères de références;
    inter = CoM{i};
    tmp=[inter(1)-C(1);inter(2)-C(2);inter(3)-C(3)];
    CoM{i} = P{i}*tmp; % calcul de la position du centre de masse dans les bon repère de référence 

    Y = [tmp(2)^2+tmp(3)^2,-tmp(1)*tmp(2),-tmp(1)*tmp(3);
     -tmp(1)*tmp(2),tmp(3)^2+tmp(1)^2,-tmp(2)*tmp(3);
     -tmp(1)*tmp(3),-tmp(2)*tmp(3),tmp(1)^2+tmp(2)^2];

    I{i} = I{i} + M(i) * (Y);   % application of translation  % SIj = bIb + Mj*Yj  "S" is the Aldebaran frame 
    I{i} = P{i} * I{i} * P{i}'; % application of rotation % jIj = jRb bIj bRj 
end

% % ==============================================================================================
% % The NEXT part of the code is added in order to concentrate the mass of the robot in one point
% % ==============================================================================================
global alphaM % alphaM = [0-1]. Allow to remove gradually the value of all masses and inertias of the robot
% alphaM = 0 -> all masses are 0 -> all mass is concentrated in one point
% alphaM = 1 -> all masses are normal -> all masses are distributed
% If alphaM is empty it means it was not initialized by other codes, therefore it is not required to do this 
if ~isempty(alphaM) 
    if alphaM > 1
        alphaM = 1;
    elseif alphaM < 0
        alphaM = 0;
    end
    
    MassTorso = 0;
    for i = 1:27
        I{i} = alphaM*I{i};
        MassTorso = MassTorso + (1-alphaM)*M(i);
        M(i) = alphaM*M(i);
    end
    
    % % Assignment of the masss to the frame 15 (hip),
    M(7)= M(7) + MassTorso;% Rest of the mass asigned to frame 15
    % If less than 20% of the mass is concentrated in the frame 15 the same CoM position (of frame 15) will be used, but...
    if alphaM < 0.75
        CoM{7} = [0; 0.015; -0.015]; % we change the CoM position of frame 15 if more than 20% of the mass are concentred in this frame...
    end
end
% % ==============================================================================================
PI.masse = M;
%Para pruebas con jacobianos
% for i=1:27
%     CoM{i}=zeros(3,1);
% end
PI.CoM = CoM; % ^jCoM, it is the CoM of link j w.r.t. frame j
PI.I = I; %  ^jIj i.e. is the inertia tensor of link j, located in the origin of frame j

 