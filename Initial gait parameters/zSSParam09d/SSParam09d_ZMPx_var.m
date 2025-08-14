function   Nao_param = SSParam09d_ZMPx_var()

% Parameters for a walking gait base on TIME:
% - Variable ZMP
% - Motion of the upper body: yaw-trunk, pitch shoulders and neck of ROMEO
% Gait parameters based on "Param09_t_impact_ZMPvar_HipTorsoArmsNeck"
% But the changes are: 
%     Offset of ZMP in x directiorn of 0.03
%     Hip_Yaw_i = 0.15  instead of Hip_Yaw_i = 0.2;


%% Gait parameters 
% ============================
T = 0.55;         % Time step
S = 0.08;         % Step length 0.1
D = 0.1;        % Step width
a_z = 0;      % Maximum amplitude oscillation of the CoM
H_ffoot = 0.02;  % Foot maximum hight 
% v_foot_f = -0.1; % Final landing velocity of the free foot;
v_foot_f = 0; % Final landing velocity of the free foot;

z0 = 0.255;       % hight of the CoM 0.27
g = 9.81;        % acceleration of gravity
% --------------
% Parte superior del cuerpo
RShoulder_Pitch_i = 0.8;%q13 Q11
RShoulder_Pitch_f = 0.2;%q13 Q11
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
LShoulder_Pitch_i = 0.2;%q17 Q15
LShoulder_Pitch_f = 0.8;%q17 Q15
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
RShoulder_Yaw_i = -0.2;%q14 Q12
RShoulder_Yaw_f = -0.2;%q14 Q12
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
LShoulder_Yaw_i = 0.2;%q18 Q16
LShoulder_Yaw_f = 0.2;%q18 Q16
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
RElbow_Roll_i = 0;%q15 Q13
RElbow_Roll_f = 0;%q15 Q13
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
LElbow_Roll_i = 0;%q19 Q17
LElbow_Roll_f = 0;%q19 Q17
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
RElbow_Yaw_i = 0.3;%q16 Q14
RElbow_Yaw_f = 1;%q16 Q14
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
LElbow_Yaw_i = -1;%q20 Q18
LElbow_Yaw_f = -0.3;%q20 Q18
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
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
ZMPxIni =  -0.005;      % Local position of the desired ZMP in X for each step
ZMPxEnd =  0.01;
ZMPyIni =  0;      % Local position of the desired ZMP in Y for each step
ZMPyEnd =  0;
Pos = [T1 ZMPxIni;       
       T2 ZMPxEnd];
Vel = [T1 0
       T2 0];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPyIni;
%        0.5*T 0; 
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
% Rcyc = [-0.004007265564310,0.000099015155436,0.128851719037465,0.226910074199834]; %Transition=true
Rcyc = [0.000204867868196,-0.000243945515342,0.189517989020622,0.244780497082260]; %Transition=false
% Creating a structure for the parameters
Nao_param.gait_parameters = gait_parameters;
Nao_param.ControlledVariableOption = OptionContVar;
Nao_param.Rcyc = Rcyc;
