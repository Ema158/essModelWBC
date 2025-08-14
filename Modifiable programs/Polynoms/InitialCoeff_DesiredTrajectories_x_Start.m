
function PolyCoeff = InitialCoeff_DesiredTrajectories_x_Start(robot,gait_parameters,x0cyc,xfcyc,xmid)

% In this code the coefficients of the polynomials that define the trajectory for step of the robot are computed

T = gait_parameters.T;
z_i = gait_parameters.z_i;
H_ffoot = gait_parameters.H_ffoot;
x_ffoot_i = gait_parameters.x_ffoot_i;
y_ffoot_i = gait_parameters.y_ffoot_i;
z_ffoot_i = gait_parameters.z_ffoot_i;
Roll_ffoot_i = gait_parameters.Roll_ffoot_i;       % Initial rotation in X of the free foot
Pitch_ffoot_i = gait_parameters.Pitch_ffoot_i;     % Initial rotation in Y of the free foot
Yaw_ffoot_i = gait_parameters.Yaw_ffoot_i;         % Initial rotation in Z of the free foot

z_ffoot_f = gait_parameters.z_ffoot_f;
a_z = gait_parameters.a_z;  % Maximum amplitude oscillation of the CoM
v_foot_f = gait_parameters.v_foot_f;  % Final landing velocity of the free foot;
%///////////////////////////////////////////////////////////
Neck_Yaw_i = gait_parameters.Neck_Yaw_i; %q21
Neck_Yaw_f = gait_parameters.Neck_Yaw_f; %q21
%///////////////////////////////////////////////////////////
Neck_Pitch_i = gait_parameters.Neck_Pitch_i; %q22
Neck_Pitch_f = gait_parameters.Neck_Pitch_f; %q22
%///////////////////////////////////////////////////////////
RShoulder_Pitch_i = gait_parameters.RShoulder_Pitch_i; %q13
RShoulder_Pitch_f = gait_parameters.RShoulder_Pitch_f; %q13
%///////////////////////////////////////////////////////////
LShoulder_Pitch_i = gait_parameters.LShoulder_Pitch_i; %q17
LShoulder_Pitch_f = gait_parameters.LShoulder_Pitch_f; %q17
%///////////////////////////////////////////////////////////
RShoulder_Yaw_i = gait_parameters.RShoulder_Yaw_i; %q14
RShoulder_Yaw_f = gait_parameters.RShoulder_Yaw_f; %q14
%///////////////////////////////////////////////////////////
LShoulder_Yaw_i = gait_parameters.LShoulder_Yaw_i; %q18
LShoulder_Yaw_f = gait_parameters.LShoulder_Yaw_f; %q18
%///////////////////////////////////////////////////////////
RElbow_Roll_i = gait_parameters.RElbow_Roll_i; %q15
RElbow_Roll_f = gait_parameters.RElbow_Roll_f; %q15
%///////////////////////////////////////////////////////////
LElbow_Roll_i = gait_parameters.LElbow_Roll_i; %q19
LElbow_Roll_f = gait_parameters.LElbow_Roll_f; %q19
%///////////////////////////////////////////////////////////
RElbow_Yaw_i = gait_parameters.RElbow_Yaw_i; %q16
RElbow_Yaw_f = gait_parameters.RElbow_Yaw_f; %q16
%///////////////////////////////////////////////////////////
LElbow_Yaw_i = gait_parameters.LElbow_Yaw_i; %q20
LElbow_Yaw_f = gait_parameters.LElbow_Yaw_f; %q20
%///////////////////////////////////////////////////////////
Hip_Roll_i = gait_parameters.Hip_Roll_i;
Hip_Roll_f = gait_parameters.Hip_Roll_f;
Hip_Pitch_i = gait_parameters.Hip_Pitch_i;
Hip_Pitch_f = gait_parameters.Hip_Pitch_f;
Hip_Yaw_i = gait_parameters.Hip_Yaw_i; %No usados en Nao 2.0
Hip_Yaw_f = gait_parameters.Hip_Yaw_f; %No usados en Nao 2.0
%////////////////////////////////////////////////////////////
x_ffoot_f = gait_parameters.x_ffoot_f;
y_ffoot_f = gait_parameters.y_ffoot_f;
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Roll_ffoot_f = gait_parameters.Roll_ffoot_f;
Yaw_ffoot_f = gait_parameters.Yaw_ffoot_f;
Pitch_ffoot_f = gait_parameters.Pitch_ffoot_f;
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% middle time to maximum high of the free foot
T_midFoot = gait_parameters.T_midFoot;
T_midCoMz = gait_parameters.T_midCoMz;
Pitch_ffoot_inc = gait_parameters.Pitch_ffoot_inc;
% INITIAL DESIRED VALUES in position and velocity of the CONTROLLED VARIABLES
% ======================================================================================
% Desired positions at the beginnning of the step (time t=0)
h0_d = zeros(20,1);
h0_d(1) = z_i;
h0_d(2) = x_ffoot_i;
h0_d(3) = y_ffoot_i;
h0_d(4) = z_ffoot_i;
h0_d(5) = Roll_ffoot_i;
h0_d(6) = Pitch_ffoot_i;
h0_d(7) = Yaw_ffoot_i;
h0_d(8) = Hip_Roll_i;
h0_d(9) = Hip_Pitch_i;
% h0_d(10) = Hip_Yaw_i;  % Hip angle in yaw
h0_d(10) = 0;
h0_d(11) = RShoulder_Pitch_i;% q13
h0_d(12) = RShoulder_Yaw_i; % q14
h0_d(13) = RElbow_Roll_i; %q15
h0_d(14) = RElbow_Yaw_i; %q16
h0_d(15) = LShoulder_Pitch_i;% q17
h0_d(16) = LShoulder_Yaw_i; % q18
h0_d(17) = LElbow_Roll_i; %q19
h0_d(18) = LElbow_Yaw_i; %q20
h0_d(19) = Neck_Yaw_i; %q21
h0_d(20) = Neck_Pitch_i; %q22

% Desired velocities at the beginnning of the step (time t=0)
hp0_d = zeros(20,1);
% CHECK if the transition is taken into account or not to consider the values after impact or the initial desired values
transition = gait_parameters.transition;
if transition
    % The initial positions and velocities are based on the current state of the robot after the transition (impact or not)
    [Qplus, QpPlus] = current_states(robot);
    IniPos = Qplus(1:20); 
    IniVel = QpPlus(1:20);
else % The polynomials are computed for ideal initial conditions 
    % (this is useful for compute the final state of the robot for compute the first step)        
    IniPos = h0_d;
    IniVel = hp0_d;
end

% FINAL DESIRED VALUES in position and velocity of the CONTROLLED VARIABLES
% ======================================================================================
% The Desired values for position of the controlled variables "hd" at the beginnning of the step (time t=T) are the 
% same that the ideal ones at the beginning of the step for almost all the variables, except for:
% -----------------------------------------------------------------------------
hT_d = h0_d;
hT_d(1) = z_i;
hT_d(2) = x_ffoot_f;
hT_d(3) = y_ffoot_f;
hT_d(4) = z_ffoot_f;
hT_d(5) = Roll_ffoot_f;
hT_d(6) = Pitch_ffoot_f;
hT_d(7) = Yaw_ffoot_f;
hT_d(8) = Hip_Roll_f;
hT_d(9) = Hip_Pitch_f;
% hT_d(10) = Hip_Yaw_f;  % Hip angle in yaw
hT_d(10) = 0;  % Hip angle in yaw
hT_d(11) = RShoulder_Pitch_f;% q13
hT_d(12) = RShoulder_Yaw_f; % q14
hT_d(13) = RElbow_Roll_f; %q15
hT_d(14) = RElbow_Yaw_f; %q16
hT_d(15) = LShoulder_Pitch_f;% q17
hT_d(16) = LShoulder_Yaw_f; % q18
hT_d(17) = LElbow_Roll_f; %q19
hT_d(18) = LElbow_Yaw_f; %q20
hT_d(19) = Neck_Yaw_f; %q21
hT_d(20) = Neck_Pitch_f; %q22


% Desired values for velocity of the controlled variables "hd" at the end of the step (time t=T)
% -----------------------------------------------------------------------------
hpT_d = zeros(20,1);
hpT_d(4) = v_foot_f;

% The Coefficients of 5th order polynomials for all the controlled variables are computed (except for the first and 
% fourth ones since they are computed after this)
for i=[5,7:20]
    PosD = [x0cyc,IniPos(i);
            xfcyc, hT_d(i)];
    VelD = [x0cyc, IniVel(i);
            xfcyc, hpT_d(i)];
   PolyCoeff.(['hd', int2str(i)]) = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
end

% However since it is desired to create 6 order polinomials for the vertical evolution of the CoM and Free foot,
% (due to an intermediate desired value) the coefficients for these polynomals are computed individually: 
PosD = [x0cyc,IniPos(1);
        xmid, z_i+a_z;      %<-- basically due to this calculation was not included in the loop
        xfcyc, hT_d(1)];
VelD = [x0cyc, IniVel(1);
        xmid, 0;
        xfcyc, 0];    
PolyCoeff.hd1 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
%
PosD = [x0cyc,IniPos(2);
        xfcyc, hT_d(2)];
VelD = [x0cyc, IniVel(2);
        xfcyc, hpT_d(2)];    
PolyCoeff.hd2 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
%
PosD = [x0cyc,IniPos(3);
        xfcyc, hT_d(3)];
VelD = [x0cyc, IniVel(3);
        xfcyc, hpT_d(3)];    
PolyCoeff.hd3 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
% Desired vertical displacement of the free foot
PosD = [x0cyc,IniPos(4); % z_ffoot_i = 0;
        xmid, H_ffoot;      %<-- basically due to this calculation was not included in the loop
        xfcyc, hT_d(4)]; % 
VelD = [x0cyc, IniVel(4);
        xmid, 0;
        xfcyc, hpT_d(4)];    
PolyCoeff.hd4 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd

% Desired angular motion in pitch of the free foot
PosD = [x0cyc,IniPos(6); % z_ffoot_i = 0;
        xmid, Pitch_ffoot_inc;      %<-- basically due to this calculation was not included in the loop
        xfcyc, hT_d(6)]; % 
VelD = [0, IniVel(6);
        T_midFoot, 0;
        T, hpT_d(6)];    
PolyCoeff.hd6 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
