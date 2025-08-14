function   Nao_param = ParamZMPTrajectoryWBCv2() %\Delta_z = 0.0075

% Parameters for a walking gait base on TIME:
% - Variable ZMP
% - Motion of the upper body: yaw-trunk, pitch shoulders and neck of ROMEO
% Gait parameters based on "Param09_t_impact_ZMPvar_HipTorsoArmsNeck"
% But the changes are: 
%     Offset of ZMP in x directiorn of 0.03
%     Hip_Yaw_i = 0.15  instead of Hip_Yaw_i = 0.2;


%% Gait parameters 
% ============================
T = 5;   %5      % Time step
Thorizon = 0.5;
Tmuestreo = 0.005; %Time step for optimization in the LIP model.
S = 0.00;         % Step length 0.1
D = 0.1;        % Step width
a_z = 0;      % Maximum amplitude oscillation of the CoM
H_ffoot = 0.00;  % Foot maximum hight 
% v_foot_f = -0.1; % Final landing velocity of the free foot;
v_foot_f = 0; % Final landing velocity of the free foot;

z0 = 0.25;       % hight of the CoM 0.27
g = 9.81;        % acceleration of gravity
% --------------
%Tiempos
T_midFoot=T/2;
T_midCoMz=T/2;
%Pitch del pie en t=T_midFoot
Pitch_ffoot_inc=0;
%% Desired ZMP
% ---------------------------------------------------------------------
% LOCAL Desired EVOLUTION of the ZMP (w.r.t. the Support foot point)
% For making the evolution of the ZMP symmetric
T1 = 0; % This two times are used to build the trajectory of the ZMP and are used in "dynm_HZD.m" 
T2 = T; % So the trayectory will be fixed from 0 to T1, then the motion will be from T1 to T2 and then fixed from T2 to T 
ZMPxIni =  0;      % Local position of the desired ZMP in X for each step
ZMPxEnd =  0;
ZMPyIni =  0.049998008663955;      % Local position of the desired ZMP in Y for each step
ZMPyEnd =  0.049998008663955;
Pos = [T1 ZMPxIni;       
       T2 ZMPxEnd];
Vel = [T1 0
       T2 0];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPyIni;
       T2 ZMPyEnd];     
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametres for evolution of the free foot
gait_parameters.T = T;               % Period of the step
gait_parameters.Thorizon = Thorizon;
gait_parameters.Tmuestreo = Tmuestreo;
gait_parameters.g = g;               % gravity acceleration
% CoM
gait_parameters.z_i = z0;            % Initial hight of the CoM
gait_parameters.a_z = a_z;           % Maximum amplitude oscillation of the CoM
gait_parameters.S = S;               % Half step length
gait_parameters.D = D;               % Step width
% Free foot desired position and final landing velocity
gait_parameters.x_ffoot_i = 0;      % Initial step position in X
gait_parameters.x_ffoot_f = 0;   % Distance traveled in X by the free foot to reach the final position in X
gait_parameters.y_ffoot_i = D;       % Initial step position in Y
gait_parameters.y_ffoot_f = D;      % Distance traveled in Y by the free foot to reach the final position in Y
gait_parameters.z_ffoot_i = H_ffoot;       % Initial step position in Z
gait_parameters.z_ffoot_f = H_ffoot;       % Final step position in Z
gait_parameters.H_ffoot = H_ffoot;   % Foot maximum hight 
gait_parameters.v_foot_f = v_foot_f; % Final landing velocity of the free foot;
% Free foot desired orientation
gait_parameters.Pitch_ffoot_i = 0;   % Initial rotation in Y of the free foot
gait_parameters.Roll_ffoot_i = 0;    % Initial rotation in X of the free foot
gait_parameters.Yaw_ffoot_i = deg2rad(0);     % Initial rotation in Z of the free foot
gait_parameters.Pitch_ffoot_f= deg2rad(0);  % Rotation in Y to be performed by the free foot to reach its final orientation in Y
gait_parameters.Roll_ffoot_f = deg2rad(0); % Rotation in X to be performed by the free foot to reach its final orientation in X
gait_parameters.Yaw_ffoot_f = deg2rad(0); % Rotation in Z to be performed by the free foot to reach its final orientation in Z
% ZMP
gait_parameters.Tini = T1;           % Time at which the ZMP will start to move (it should be >= 0)
gait_parameters.Tend = T2;           % Time at which the ZMP will stop its motion (it should be <= T)
gait_parameters.ZMPxIni = ZMPxIni;   % Initial desired position in X
gait_parameters.ZMPyIni = ZMPyIni;   % Initial desired position in Y
gait_parameters.ZMPxEnd = ZMPxEnd;   % Final desired position in X
gait_parameters.ZMPyEnd = ZMPyEnd;   % Final desired position in Y
gait_parameters.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
gait_parameters.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
% % Neck yaw q21
gait_parameters.Neck_Yaw_i = 0; %
gait_parameters.Neck_Yaw_f = 0;  % 
% % Neck pitch q22
gait_parameters.Neck_Pitch_i = 0; % 
gait_parameters.Neck_Pitch_f = 0;  % 
%%Tiempos
gait_parameters.T_midFoot=T_midFoot;
gait_parameters.T_midCoMz=T_midCoMz;
%Pitch del pie en t=T_midFoot
gait_parameters.Pitch_ffoot_inc = Pitch_ffoot_inc;
%Pesos QP WBC
Q = eye(12,12);
%
Q(3:10,3:10) = 0.00003*eye(8,8); % $Push Recovery acc inst +38 0.00003
Q(11,11) = 0.003; % $Push Recovery
Q(12,12) = 0.003; % $Push Recovery 
%
% Q(3:10,3:10) = 0.00003*eye(8,8); % $Push Recovery acc inst +38
% % Q(11,11) = 0.0008; % $Push Recovery
% % Q(12,12) = 0.0008; % $Push Recovery 
% Q(11,11) = 0.0005; % $Push Recovery
% Q(12,12) = 0.0005; % $Push Recovery 
gait_parameters.Q = Q;
%Ganancias PD
Kp = 10*eye(12,12); %Bueno push recovery 10
Kd = 6.32*eye(12,12); %Bueno push recovery 7
%
% Kp = eye(12,12); %Bueno push recovery 10
% Kd = eye(12,12); %Bueno push recovery 7
% Kp(1:2,1:2) = 30*eye(2,2);
% Kp(3:10,3:10) = 220*eye(8,8);
% Kp(11:12,11:12) = 120*eye(2,2);
% Kd(1:2,1:2) = 10.95*eye(2,2);
% Kd(3:10,3:10) = 29.66*eye(8,8);
% Kd(11:12,11:12) = 21.9*eye(2,2);
%
Kz = 0; %Ganancia ZMP
KpCAM = 100*eye(2,2); %Ganancia PD CAM %100
gait_parameters.Kp = Kp;
gait_parameters.Kd = Kd;
gait_parameters.Kz = Kz;
gait_parameters.KpCAM = KpCAM;
%Límites ZMP
limX = [-0.1;0.023]; %Push Recovery
limY = [-0.005;0.105]; % Push Recovery
gait_parameters.limX = limX;
gait_parameters.limY = limY;
%Distrubance
gait_parameters.boolDisturbance = 0;
gait_parameters.magnitudeDisturbance = 0;
%% CHOSING CONTROLLED VARIABLE FILES
% -------------------------------------------------------------------------------------------------
% Option to chose the controlled variables "hd", "hpd" and "hppd"
% 1 -> Controlled variables defined by polynomials w.r.t. time, IMPACT can be considered. Files: "hd_Polyn", "hpd_Polyn_t" and "hppd_Polyn_t". 
% 2 -> Controlled variables defined by cycloidal motion w.r.t. time, IMPACT is NOT considered. Files: "hd_CycMotion_t", "hpd_CycMotion_t" and "hppd_CycMotion_t". 
% 3 -> Controlled variables defined by polynomials w.r.t. "x" of the CoM, IMPACT can be considered. Files: "hd_Polyn", "hpd_Polyn_x" and "hppd_Polyn_x". 
OptionContVar = 1;
% -------------------------------------------------------------------------------------------------
%% Cyclic motion (Dx, Dy, xpf, ypf) and optimized parameters
Rcyc = [0,0,1.8,-0.15,1.6,0.15,1.8,0.15,-1.6,-0.15,0,0,... %x,y,q13,q14,q15,q16,q17,q18,q19,q20,
        0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0];   %xp,yp,q13p,q14p,q15p,q16p,q17p,q18p,q19p,q20p,CAM                        
% Creating a structure for the parameters
Nao_param.gait_parameters = gait_parameters;
Nao_param.ControlledVariableOption = OptionContVar;
Nao_param.Rcyc = Rcyc;
