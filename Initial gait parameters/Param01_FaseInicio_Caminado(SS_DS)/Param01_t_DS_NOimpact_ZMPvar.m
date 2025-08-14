function   Nao_param = Param01_t_DS_NOimpact_ZMPvar()
% based on "Param13_t_SS_NOimpact_ZMPvar_HipTorsoArmsNeck"

% Parameters for a walking gait base on TIME:
% - Variable ZMP
% - Motion of the upper body: yaw-trunk, pitch shoulders and neck of ROMEO
% Circular motion for a gait based in "Param02_t_impact_ZMPvar_HipTorsoArmsNeck.m" Change -> Hip_Yaw_i from 0.3 to 0.15

%% Gait parameters 
% ============================
T = 0.1;         % Time step
S = 0.04;         % Step length
D = 0.1;        % Step width
wide_error = 0; % define the final step width position of the free foot for STEP 1
Yaw_ffoot_i = deg2rad(0); % Initial orientation of the free foot w.r.t. the support frame (right foot)
Yaw_ffoot_f = deg2rad(0); % final orientation of the free foot w.r.t. the support frame (right foot)
Yaw_ffoot_inc = Yaw_ffoot_f-Yaw_ffoot_i; % angle displacement of the free foot

a_z = 0;      % Maximum amplitude oscillation of the CoM
H_ffoot = 0;  % Foot maximum hight 
v_foot_f = 0; % Final landing velocity of the free foot;

z0 = 0.26;       % hight of the CoM
g = 9.81;        % acceleration of gravity
% --------------
% Parte superior del cuerpo
% RShoulder_Pitch_i = 1.19;%q13 Q11
% RShoulder_Pitch_f = 1.19;%q13 Q11
RShoulder_Pitch_i = 1.5;%q13 Q11
RShoulder_Pitch_f = 1.5;%q13 Q11
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% LShoulder_Pitch_i = 2.01;%q17 Q15
% LShoulder_Pitch_f = 2.01;%q17 Q15
LShoulder_Pitch_i = 1.7;%q17 Q15
LShoulder_Pitch_f = 1.7;%q17 Q15
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
RShoulder_Yaw_i=-0.35;%q14 Q12
RShoulder_Yaw_f=-0.35;%q14 Q12
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
LShoulder_Yaw_i=0.35;%q18 Q16
LShoulder_Yaw_f=0.35;%q18 Q16
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
RElbow_Roll_i=1.6;%q15 Q13
RElbow_Roll_f=1.6;%q15 Q13
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
LElbow_Roll_i=-1.6;%q19 Q17
LElbow_Roll_f=-1.6;%q19 Q17
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
RElbow_Yaw_i=0.35;%q16 Q14
RElbow_Yaw_f=0.35;%q16 Q14
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
LElbow_Yaw_i=-0.35;%q20 Q18
LElbow_Yaw_f=-0.35;%q20 Q18
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%Tiempos
T_midFoot=T/2;
T_midCoMz=T/2;
%Pitch del pie en t=T_midFoot
Pitch_ffoot_inc=0;
%% Desired ZMP
% =========================================
% Proposed ZMP in initial DS: 
ZMPx0 = 0.01;
ZMPxi = 0;
ZMPxf = S-0.005;
ZMPy0 = 0.011;
% ZMPy0 = 0.011;
ZMPyi =  0.1; %No se usa
ZMPyf = D;
% ---------------------------------------------------------------------
% LOCAL Desired EVOLUTION of the ZMP (w.r.t. the Support foot point)
% For making the evolution of the ZMP symmetric
T1 = 0; % This two times are used to build the trajectory of the ZMP and are used in "dynm_HZD.m" 
T2 = T; % So the trayectory will be fixed from 0 to T1, then the motion will be from T1 to T2 and then fixed from T2 to T 
ZMPxIni = ZMPx0; %  Local position of the desired ZMP in X for each step
ZMPxMid = ZMPxi;
ZMPxEnd = ZMPxf;
ZMPyIni = ZMPy0; % Local position of the desired ZMP in Y for each step
ZMPyMid = ZMPyi;
ZMPyEnd = ZMPyf;
Pos = [T1 ZMPxIni;
       T2 ZMPxEnd];
Vel = [];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPyIni; 
%        T/2 ZMPyMid;
       T2 ZMPyEnd];     
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);

% Uncomment to visualize the desired trajectory of the ZMP
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
% -------------------------------------------------------------------------------------------------

% ZMP
gait_parameters.Tini = T1;           % Time at which the ZMP will start to move (it should be >= 0)
gait_parameters.Tend = T2;           % Time at which the ZMP will stop its motion (it should be <= T)
gait_parameters.ZMPxIni = ZMPxIni;   % Initial desired position in X
gait_parameters.ZMPyIni = ZMPyIni;   % Initial desired position in Y
gait_parameters.ZMPxMid = ZMPxMid;   % Middle desired position in X
gait_parameters.ZMPyMid = ZMPyMid;   % Middle desired position in Y
gait_parameters.ZMPxEnd = ZMPxEnd;   % Final desired position in X
gait_parameters.ZMPyEnd = ZMPyEnd;   % Final desired position in Y
gait_parameters.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
gait_parameters.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
% Parametres for evolution of the free foot
gait_parameters.T = T;               % Period of the step
gait_parameters.g = g;               % gravity acceleration
% CoM
gait_parameters.z_i = z0;            % Initial hight of the CoM
gait_parameters.a_z = a_z;           % Maximum amplitude oscillation of the CoM
gait_parameters.S = S;               % Half step length
gait_parameters.D = D;               % Step width
% Free foot desired position and final landing velocity
gait_parameters.x_ffoot_i = S;      % Initial step position in X
gait_parameters.x_ffoot_f = S;   % Distance traveled in X by the free foot to reach the final position in X
gait_parameters.y_ffoot_i = D;       % Initial step position in Y
gait_parameters.y_ffoot_f = D;      % Distance traveled in Y by the free foot to reach the final position in Y
gait_parameters.z_ffoot_i = 0;       % Initial step position in Z
gait_parameters.z_ffoot_f = 0;       % Final step position in Z
gait_parameters.H_ffoot = H_ffoot;   % Foot maximum hight 
gait_parameters.v_foot_f = v_foot_f; % Final landing velocity of the free foot;
% Free foot desired orientation
gait_parameters.Pitch_ffoot_i = 0;   % Initial rotation in Y of the free foot
gait_parameters.Roll_ffoot_i = 0;    % Initial rotation in X of the free foot
gait_parameters.Yaw_ffoot_i = 0;     % Initial rotation in Z of the free foot
gait_parameters.Pitch_ffoot_f= deg2rad(0);  % Rotation in Y to be performed by the free foot to reach its final orientation in Y
gait_parameters.Roll_ffoot_f = deg2rad(0); % Rotation in X to be performed by the free foot to reach its final orientation in X
gait_parameters.Yaw_ffoot_f = deg2rad(0); % Rotation in Z to be performed by the free foot to reach its final orientation in Z
% Hip yaw
gait_parameters.Hip_Yaw_i = 0;   % Initial orientation of the hip around Z 
gait_parameters.Hip_Yaw_f = 0;  % Final orientation of the hip around Z 
% Hip roll
gait_parameters.Hip_Roll_i = 0;   % Initial orientation of the hip around Z 
gait_parameters.Hip_Roll_f = 0;  % Final orientation of the hip around Z 
% Hip pitch
gait_parameters.Hip_Pitch_i = 0;   % Initial orientation of the hip around Z 
gait_parameters.Hip_Pitch_f = 0;  % Final orientation of the hip around Z 
% % Right shoulder pitch q13
gait_parameters.RShoulder_Pitch_i = RShoulder_Pitch_i; % Initial orientation of the right shoulder around Y 
gait_parameters.RShoulder_Pitch_f = RShoulder_Pitch_f; % Final orientation of the right shoulder around Y 
% % Left shoulder pitch q17
gait_parameters.LShoulder_Pitch_i = LShoulder_Pitch_i; % Initial orientation of the left shoulder around Y 
gait_parameters.LShoulder_Pitch_f = LShoulder_Pitch_f; % Final orientation of the left shoulder around Y 
% % Rigth shoulder yaw q14
gait_parameters.RShoulder_Yaw_i = RShoulder_Yaw_i; 
gait_parameters.RShoulder_Yaw_f = RShoulder_Yaw_f; 
% % Left shoulder yaw q18
gait_parameters.LShoulder_Yaw_i = LShoulder_Yaw_i;  
gait_parameters.LShoulder_Yaw_f = LShoulder_Yaw_f; 
% % Right elbow roll q15
gait_parameters.RElbow_Roll_i = RElbow_Roll_i; % 
gait_parameters.RElbow_Roll_f = RElbow_Roll_f; % 
% % Left elbow roll q19
gait_parameters.LElbow_Roll_i = LElbow_Roll_i; % 
gait_parameters.LElbow_Roll_f = LElbow_Roll_f; % 
% % Right elbow yaw q16
gait_parameters.RElbow_Yaw_i = RElbow_Yaw_i; % 
gait_parameters.RElbow_Yaw_f = RElbow_Yaw_f; % 
% % Left elbow yaw q20
gait_parameters.LElbow_Yaw_i = LElbow_Yaw_i; % 
gait_parameters.LElbow_Yaw_f = LElbow_Yaw_f; % 
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
%% CHOSING CONTROLLED VARIABLE FILES
% -------------------------------------------------------------------------------------------------
% Option to chose the controlled variables "hd", "hpd" and "hppd"
% 1 -> Controlled variables defined by polynomials w.r.t. time, IMPACT can be considered. Files: "hd_Polyn", "hpd_Polyn_t" and "hppd_Polyn_t". 
% 2 -> Controlled variables defined by cycloidal motion w.r.t. time, IMPACT is NOT considered. Files: "hd_CycMotion_t", "hpd_CycMotion_t" and "hppd_CycMotion_t". 
% 3 -> Controlled variables defined by polynomials w.r.t. "x" of the CoM, IMPACT can be considered. Files: "hd_Polyn", "hpd_Polyn_x" and "hppd_Polyn_x". 
OptionContVar = 1;
% -------------------------------------------------------------------------------------------------
%% Cyclic motion (Dx, Dy, xpf, ypf) and optimized parameters
Rcyc =  [5.410431e-03,1.211077e-02,6.691672e-02,1.630315e-01]; %Valores encontrados con el programa M40
% Creating a structure for the parameters
Nao_param.gait_parameters = gait_parameters;
Nao_param.ControlledVariableOption = OptionContVar;
Nao_param.Rcyc = Rcyc;