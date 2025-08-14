function   Romeo_param = Param13b_t_SS_NOimpact_ZMPvar()
% based on "Param12_t_impact_ZMPvar_HipTorsoArmsNeck"

% Parameters for a walking gait base on TIME:
% - Variable ZMP
% - Motion of the upper body: yaw-trunk, pitch shoulders and neck of ROMEO
% Circular motion for a gait based in "Param02_t_impact_ZMPvar_HipTorsoArmsNeck.m" Change -> Hip_Yaw_i from 0.3 to 0.15

%% Gait parameters 
% ============================
T = 0.5;         % Time step
S = 0.3;         % Step length
D = 0.15;        % Step width
wide_error = 0; % define the final step width position of the free foot for STEP 1
Yaw_ffoot_i = deg2rad(0); % Initial orientation of the free foot w.r.t. the support frame (right foot)
Yaw_ffoot_f = deg2rad(0); % final orientation of the free foot w.r.t. the support frame (right foot)
Yaw_ffoot_inc = Yaw_ffoot_f-Yaw_ffoot_i; % angle displacement of the free foot

a_z = 0.05;      % Maximum amplitude oscillation of the CoM
H_ffoot = 0.03;  % Foot maximum hight 
v_foot_f = 0;    % Final landing velocity of the free foot;
T_midFoot = 0.4*T; % middle time to maximum high of the free foot 

z0 = 0.65;       % hight of the CoM
g = 9.81;        % acceleration of gravity
% --------------
Hip_Yaw_i = 0.15;
Shoulder_Pitch_i = 1.8;
Shoulder_Pitch_f = 1.6;
Yaw_torso_neck_i = -0.25;

%% Desired ZMP
% ---------------------------------------------------------------------
% LOCAL Desired EVOLUTION of the ZMP (w.r.t. the Support foot point)
% For making the evolution of the ZMP symmetric
T1 = 0; % This two times are used to build the trajectory of the ZMP and are used in "dynm_HZD.m" 
T2 = T; % So the trayectory will be fixed from 0 to T1, then the motion will be from T1 to T2 and then fixed from T2 to T 
ZMPxIni = -0.02;      % Local position of the desired ZMP in X for each step
ZMPxEnd = 0.10;
ZMPyIni = 0.01;      % Local position of the desired ZMP in Y for each step
ZMPyEnd = 0.01;
Pos = [T1 ZMPxIni;       
       T2 ZMPxEnd];
Vel = [T1 0;    
      T2 0];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPyIni;
       0.5*T 0; 
       T2 ZMPyEnd];     
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);

% % For keeping the ZMP half of the time behind the ankle (0,0)
% T1 = 0; % This two times are used to build the trajectory of the ZMP and are used in "dynm_HZD.m" 
% T2 = T; % So the trayectory will be fixed from 0 to T1, then the motion will be from T1 to T2 and then fixed from T2 to T 
% ZMPxIni = -0.02;      % Local position of the desired ZMP in X for each step
% ZMPxEnd = 0.13;
% ZMPyIni = 0.01;      % Local position of the desired ZMP in Y for each step
% ZMPyEnd = 0.01;
% Pos = [T1 ZMPxIni;
%        0.5*T 0;
%        T2 ZMPxEnd];
% Vel = [T1 0;
%     0.5*T 0;
%       T2 0];
% Acc = [T1 0;
%     0.5*T 0;
%       T2 0];
% % Acc = [];
% ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
% Pos = [T1 ZMPyIni;
%        0.5*T 0; 
%        T2 ZMPyEnd];     
% ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);

% % Uncomment to visualize the desired trajectory of the ZMP
% figure
% subplot(3,1,1)
% plot(T1:0.01:T2,polyval(ZMPxCoeff,T1:0.01:T2))
% ylabel('ZMP_x')
% xlabel('t')
% subplot(3,1,2)
% plot(T1:0.01:T2,polyval(ZMPyCoeff,T1:0.01:T2))
% ylabel('ZMP_y')
% xlabel('t')
% subplot(3,1,3)
% plot(polyval(ZMPxCoeff,T1:0.01:T2),polyval(ZMPyCoeff,T1:0.01:T2))
% ylabel('ZMP_y')
% xlabel('ZMP_x')
% % -------------------------------------------------------------------------------------------------

% Parametres for evolution of the free foot
gait_parameters.T = T;               % Period of the step
gait_parameters.g = g;               % gravity acceleration
% CoM
gait_parameters.z_i = z0;            % Initial hight of the CoM
gait_parameters.a_z = a_z;           % Maximum amplitude oscillation of the CoM
gait_parameters.S = S;               % Half step length
gait_parameters.D = D;               % Step width
% Free foot desired position and final landing velocity
gait_parameters.x_ffoot_i = -S;      % Initial step position in X
gait_parameters.Step_length = 2*S;   % Distance traveled in X by the free foot to reach the final position in X
gait_parameters.y_ffoot_i = D;       % Initial step position in Y
gait_parameters.wide_error = wide_error;      % Distance traveled in Y by the free foot to reach the final position in Y
gait_parameters.z_ffoot_i = 0;       % Initial step position in Z
gait_parameters.z_ffoot_f = 0;       % Final step position in Z
gait_parameters.H_ffoot = H_ffoot;   % Foot maximum hight 
gait_parameters.v_foot_f = v_foot_f; % Final landing velocity of the free foot;
% Free foot desired orientation
gait_parameters.T_midFoot = T_midFoot; % middle time to maximum high of the free foot
gait_parameters.Pitch_ffoot_i = 0;   % Initial rotation in Y of the free foot
gait_parameters.Roll_ffoot_i = 0;    % Initial rotation in X of the free foot
gait_parameters.Yaw_ffoot_i = Yaw_ffoot_i;     % Initial rotation in Z of the free foot
gait_parameters.Roll_ffoot_inc = deg2rad(0); % Rotation in X to be performed by the free foot to reach its final orientation in X
gait_parameters.Pitch_ffoot_inc = deg2rad(45);  % Rotation in Y to be performed by the free foot to reach its final orientation in Y
gait_parameters.Yaw_ffoot_inc = Yaw_ffoot_inc; % Rotation in Z to be performed by the free foot to reach its final orientation in Z
% ZMP
gait_parameters.Tini = T1;           % Time at which the ZMP will start to move (it should be >= 0)
gait_parameters.Tend = T2;           % Time at which the ZMP will stop its motion (it should be <= T)
gait_parameters.ZMPxIni = ZMPxIni;   % Initial desired position in X
gait_parameters.ZMPyIni = ZMPyIni;   % Initial desired position in Y
gait_parameters.ZMPxEnd = ZMPxEnd;   % Final desired position in X
gait_parameters.ZMPyEnd = ZMPyEnd;   % Final desired position in Y
gait_parameters.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
gait_parameters.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
% Upper body
gait_parameters.Pitch_torso_i = 0;       % Initial orientation of the torso around Y
% Hip yaw
gait_parameters.Hip_Yaw_i = Hip_Yaw_i;   % Initial orientation of the hip around Z 
gait_parameters.Hip_Yaw_f = -Hip_Yaw_i;  % Final orientation of the hip around Z 
% % Right shoulder pitch
gait_parameters.RShoulder_Pitch_i = Shoulder_Pitch_i; % Initial orientation of the right shoulder around Y 
gait_parameters.RShoulder_Pitch_f = Shoulder_Pitch_f; % Final orientation of the right shoulder around Y 
% % Left shoulder pitch
gait_parameters.LShoulder_Pitch_i = Shoulder_Pitch_f; % Initial orientation of the left shoulder around Y 
gait_parameters.LShoulder_Pitch_f = Shoulder_Pitch_i; % Final orientation of the left shoulder around Y 
% % Torso yaw
gait_parameters.Yaw_torso_i = Yaw_torso_neck_i;       % Initial orientation of the torso around Z
gait_parameters.Yaw_torso_inc = -2*Yaw_torso_neck_i;  % Desired rotation in Z to be performed by the torso to reach its final orientation in Z
% % Neck yaw
gait_parameters.Neck_Yaw_i = -Yaw_torso_neck_i; % Initial orientation of the neck around Z 
gait_parameters.Neck_Yaw_f = Yaw_torso_neck_i;  % Final orientation of the neck around Z 

%% CHOSING CONTROLLED VARIABLE FILES
% -------------------------------------------------------------------------------------------------
% Option to chose the controlled variables "hd", "hpd" and "hppd"
% 1 -> Controlled variables defined by polynomials w.r.t. time, IMPACT can be considered. Files: "hd_Polyn", "hpd_Polyn_t" and "hppd_Polyn_t". 
% 2 -> Controlled variables defined by cycloidal motion w.r.t. time, IMPACT is NOT considered. Files: "hd_CycMotion_t", "hpd_CycMotion_t" and "hppd_CycMotion_t". 
% 3 -> Controlled variables defined by polynomials w.r.t. "x" of the CoM, IMPACT can be considered. Files: "hd_Polyn", "hpd_Polyn_x" and "hppd_Polyn_x". 
OptionContVar = 1;
% -------------------------------------------------------------------------------------------------
%% Cyclic motion (Dx, Dy, xpf, ypf) and optimized parameters
% Rcyc = [4.385493e-02,-4.301395e-04,5.842375e-01,1.747578e-01]; % Cyclic motion for "InfoROMEO_Param_t_12" 
% Rcyc = [4.385493e-02,-4.301395e-04,4.842375e-01,1.747578e-01]; % TEST
% Rcyc = [6.466433e-02,-1.248832e-03,4.676193e-01,1.982656e-01]; % Cyclic motion for "InfoROMEO_Param_t_13" 
% Rcyc = [6.930939e-02,4.305655e-03,4.418072e-01,1.749343e-01]; % Cyclic motion for "InfoROMEO_Param_t_13a" 
% Rcyc = [6.345867e-02,9.261123e-03,4.393853e-01,1.519635e-01]; % Cyclic motion for "InfoROMEO_Param_t_13b"
% Rcyc = [6.352723e-02,9.258880e-03,4.390680e-01,1.520447e-01]; % Cyclic motion for "InfoROMEO_Param_t_13b" CORRECTED =/? switching all variables in impact_pos_vel.m 
% Rcyc = [6.354375e-02,9.488144e-03,4.390207e-01,1.522858e-01]; % Cyclic motion for "InfoROMEO_Param_t_13b" dicontinuity almost CORRECTED 
Rcyc = [6.354442e-02,9.546898e-03,4.390484e-01,1.523290e-01]; % Cyclic motion for "InfoROMEO_Param_t_13b" dicontinuity CORRECTED 

% Creating a structure for the parameters
Romeo_param.gait_parameters = gait_parameters;
Romeo_param.ControlledVariableOption = OptionContVar;
Romeo_param.Rcyc = Rcyc;
