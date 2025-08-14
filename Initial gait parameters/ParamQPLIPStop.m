function   Nao_param = ParamQPLIPStop()

% Parameters for a walking gait base on TIME:
% - Variable ZMP
% - Motion of the upper body: yaw-trunk, pitch shoulders and neck of ROMEO
% Gait parameters based on "Param09_t_impact_ZMPvar_HipTorsoArmsNeck"
% But the changes are: 
%     Offset of ZMP in x directiorn of 0.03
%     Hip_Yaw_i = 0.15  instead of Hip_Yaw_i = 0.2;


%% Gait parameters 
% ============================
T = 1;         % Time step 0.5 1.5
Thorizon = 1; %0.5 1
Tmuestreo = 0.01; %Time step for optimization in the LIP model.
S = 0.08;         % Step length 0.05
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametres for evolution of the free foot
gait_parameters.T = T;               % Period of the step
gait_parameters.Tmuestreo = Tmuestreo;
gait_parameters.Thorizon = Thorizon;
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
gait_parameters.z_ffoot_i = 0;       % Initial step position in Z
gait_parameters.z_ffoot_f = 0;       % Final step position in Z
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
gait_parameters.Tini = 0;           % Time at which the ZMP will start to move (it should be >= 0)
gait_parameters.Tend = T;           % Time at which the ZMP will stop its motion (it should be <= T)
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
% Q(3:10,3:10) = 3e-5*eye(8,8); % 
% Q(11,11) = 2e-3; % $Push Recovery
% Q(12,12) = 2e-3; % $Push Recovery 
%
Q(3:10,3:10) = 3e-5*eye(8,8); % 
Q(11,11) = 6e-4; % $Push Recovery
Q(12,12) = 6e-4; % $Push Recovery 
%
gait_parameters.Q = Q;
%Ganancias PD
Kp = 10*eye(12,12); %Bueno push recovery 10
Kd = 6.32*eye(12,12); %Bueno push recovery 7
%
Kz = 1; %Ganancia ZMP
KpCAM = 2*eye(2,2); %Ganancia PD CAM
gait_parameters.Kp = Kp;
gait_parameters.Kd = Kd;
gait_parameters.Kz = Kz;
gait_parameters.KpCAM = KpCAM;
%%%Perturbación
gait_parameters.boolDisturbance = 0;
gait_parameters.magnitudeDisturbance = 0; %Acc
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
        0,0,0,0,0,0,0,0,0,0,0,0,0,0];   %xp,yp,q13p,q14p,q15p,q16p,q17p,q18p,q19p,q20p,CAM                           
% Creating a structure for the parameters
Nao_param.gait_parameters = gait_parameters;
Nao_param.ControlledVariableOption = OptionContVar;
Nao_param.Rcyc = Rcyc;
