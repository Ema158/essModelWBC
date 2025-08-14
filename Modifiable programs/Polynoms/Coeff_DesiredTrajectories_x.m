
function PolyCoeff = Coeff_DesiredTrajectories_x(robot,gait_parameters)

% In this code the coefficients of of the polynomials that define the trajectory for step of the robot are computed
% based on the current state of the robot (after impact)

% h(12) = q(14) = deg2rad(0);           % Frame 16 % "Yaw" neck +
% h(13) = q(15) = deg2rad(0);           % Frame 17 % Pitch neck +
% h(14) = q(16) = deg2rad(0);           % Frame 18 % Pitch head +
% h(15) = q(17) = deg2rad(0);           % Frame 19 % Roll head +
% h(16) = q(18) = 1.7 +  deg2rad(0);    % Frame 21 % "Pitch" Right shoulder +
% h(17) = q(19) = 0.2 + deg2rad(0);     % Frame 22 % Yaw Right shoulder +
% h(18) = q(20) = deg2rad(0);           % Frame 23 % Roll Right elbow +
% h(19) = q(21) = 0.05 + deg2rad(0);    % Frame 24 % Yaw Right elbow +
% h(20) = q(22) = 1.5 + deg2rad(0);     % Frame 25 % Roll Right wrist +
% h(21) = q(23) = deg2rad(0);           % Frame 26 % Yaw Right wrist +
% h(22) = q(24) = deg2rad(0);           % Frame 27 % Pitch Right wrist +
% h(23) = q(25) = 1.7 + deg2rad(0);     % Frame 29 % "Pitch" Left shoulder +
% h(24) = q(26) = -0.2 + deg2rad(0);    % Frame 30 % Yaw Left shoulder +
% h(25) = q(27) = deg2rad(0);           % Frame 31 % Roll Left elbow +
% h(26) = q(28) = -0.05 + deg2rad(0);   % Frame 32 % Yaw Left elbow +
% h(27) = q(29) = -1.5 + deg2rad(0);    % Frame 33 % Roll Left wrist +
% h(28) = q(30) = deg2rad(0);           % Frame 34 % Yaw Left wrist +
% h(29) = q(31) = deg2rad(0);           % Frame 35 % Pitch Left wrist +

z_i = gait_parameters.z_i;
Step_length = gait_parameters.Step_length;
x0cyc = gait_parameters.x0cyc;
xfcyc = gait_parameters.xfcyc;
xpfcyc = gait_parameters.xpfcyc;
xp0cyc = gait_parameters.qfp0(1);

H_ffoot = gait_parameters.H_ffoot;
x_ffoot_i = gait_parameters.x_ffoot_i;
y_ffoot_i = gait_parameters.y_ffoot_i;
wide_error = gait_parameters.wide_error;
z_ffoot_f = gait_parameters.z_ffoot_f;
a_z = gait_parameters.a_z;  % Maximum amplitude oscillation of the CoM
v_foot_f = gait_parameters.v_foot_f;  % Final landing velocity of the free foot;

Dx = gait_parameters.Dx;
xmid = Dx;  %The intermediate value of the CoM (in the middle between xf and x0)

[Qplus, QpPlus] = current_states(robot);

% Desired vertical displacement of the CoM
PosD = [x0cyc, Qplus(1);
        xmid,  z_i+a_z;
        xfcyc, z_i];    
VelD = [x0cyc, QpPlus(1)/xp0cyc;
        xmid, 0;
        xfcyc, 0];    
PolyCoeff.hd1 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
% Desired horizontal displacement in X of the free foot
PosD = [x0cyc, Qplus(2); % x_ffoot_i
        xfcyc, x_ffoot_i+Step_length];
VelD = [x0cyc, QpPlus(2)/xp0cyc;
        xfcyc, 0];    
PolyCoeff.hd2 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
% Desired horizontal displacement in Y of the free foot
PosD = [x0cyc, Qplus(3); % y_ffoot_i
        xfcyc, y_ffoot_i+wide_error];
VelD = [x0cyc, QpPlus(3)/xp0cyc;
        xfcyc, 0];    
PolyCoeff.hd3 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
% Desired vertical displacement of the free foot
PosD = [x0cyc, Qplus(4); % z_ffoot_i = 0;
        xmid, H_ffoot;
        xfcyc, z_ffoot_f]; % 0
VelD = [x0cyc, QpPlus(4)/xp0cyc;
        xmid, 0;
        xfcyc, v_foot_f/xpfcyc];    
PolyCoeff.hd4 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd

% For the rest controlled variables we just care the final desired values
% Desired values for position of the controlled variables "hd" at time T
% -----------------------------------------------------------------------------
hdDesT = zeros(29,1);
hdDesT(11) = pi/2; % Torso yaw angle
% Straight fix upper body 
% ----------------------------------
% hdDesT(16)=1.7;
% hdDesT(23)=1.7;
% hdDesT(17) = 0.2;
% hdDesT(24)=-0.2;
% hdDesT(19)=0.05;
% hdDesT(26)=-0.05;

% % Crossed arms fix upper body 
% ----------------------------------
% % right arm
% hdDesT(16) = 0.41;  % q18
% hdDesT(17) = 0.19;
% hdDesT(18) = 0.194;
% hdDesT(19) = 1.523;
% hdDesT(20) = 0;
% hdDesT(21) = 0;     
% hdDesT(22) = -0.415; % q24
% % left arm
% hdDesT(23) = 0.41; % q25
% hdDesT(24) = -0.085;
% hdDesT(25) = -0.565;
% hdDesT(26) = -1.5;
% hdDesT(27) = -0.165;
% hdDesT(28) = 0;
% hdDesT(29) = 0.32;    % q31

% % Arms behind its head
% % ----------------------------------
% % right arm
% hdDesT(16) = -1.34;  % q18
% hdDesT(17) = 0.17;
% hdDesT(18) = 0.3;
% hdDesT(19) = 1.52;
% hdDesT(20) = 0;
% hdDesT(21) = 0.4;     
% hdDesT(22) = 0; % q24
% % left arm
% hdDesT(23) = -1.34; % q25
% hdDesT(24) = -0.17;
% hdDesT(25) = -0.3;
% hdDesT(26) = -1.52;
% hdDesT(27) = 0;
% hdDesT(28) = -0.4;
% hdDesT(29) = 0;    % q31

% Arms behind its head 2
% ----------------------------------
% For the rest controlled variables we just care the final desired values
% Desired values for position of the controlled variables "hd" at time T
% -----------------------------------------------------------------------------
hdDesT = zeros(20,1);
%Left arm
hdDesT(11) = 1.57; % Torso yaw angle
hdDesT(12) = -0.2;  % q13
hdDesT(13) = 1.57;  % q18
hdDesT(14) = 1.22;
%Right arm
hdDesT(15) = 1.57;
hdDesT(16) = 0.2;
hdDesT(17) = -1.57;
hdDesT(18) = -1.22;
%
hdDesT(20) = 0; % q24
hdDesT(20) = 0; % q24

% Note the first 4 values of hd are not used in the next loop (that's because they are zero)
% Desired values for velocity of the controlled variables "hd" at time T
% -----------------------------------------------------------------------------
hpdDesT = zeros(20,1);
% Note the first 4 values of hpd are not used in the next loop (that's why these elemements in "hpdDesT" are zero)

for i=5:20
    PosD = [x0cyc, Qplus(i);
           xfcyc, hdDesT(i)];
    VelD = [x0cyc, QpPlus(i)/xp0cyc;
            xfcyc, hpdDesT(i)/xpfcyc];
    PolyCoeff.(['hd', int2str(i)]) = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
end
