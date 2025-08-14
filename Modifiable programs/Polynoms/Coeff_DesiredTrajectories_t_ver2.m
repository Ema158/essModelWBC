
function PolyCoeff = Coeff_DesiredTrajectories_t_ver2(robot,gait_parameters)

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
%
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
h0_d = zeros(10,1);
h0_d(1) = z_i;
h0_d(2) = x_ffoot_i;
h0_d(3) = y_ffoot_i;
h0_d(4) = z_ffoot_i;
h0_d(5) = Roll_ffoot_i;
h0_d(6) = Pitch_ffoot_i;
h0_d(7) = Yaw_ffoot_i;
h0_d(8) = 0;
h0_d(9) = 0; %Rwrist
h0_d(10) = 0; %Lwrist
h0_d(11) = Neck_Yaw_i; %q21
h0_d(12) = Neck_Pitch_i; %q22

% Desired velocities at the beginnning of the step (time t=0)
hp0_d = zeros(12,1);
% CHECK if the transition is taken into account or not to consider the values after impact or the initial desired values
transition = gait_parameters.transition;
if transition
    % The initial positions and velocities are based on the current state of the robot after the transition (impact or not)
    [Qplus, QpPlus] = current_states(robot);
    IniPos = Qplus(1:12); 
    IniVel = QpPlus(1:12);
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
hT_d(8) = 0;  % Hip angle in yaw
hT_d(9) = 0; %RWrist
hT_d(10) = 0; %LWrist
hT_d(11) = Neck_Yaw_f; %q21
hT_d(12) = Neck_Pitch_f; %q22
% Desired values for velocity of the controlled variables "hd" at the end of the step (time t=T)
% -----------------------------------------------------------------------------
hpT_d = zeros(12,1);
hpT_d(4) = v_foot_f;
% The Coefficients of 5th order polynomials for all the controlled variables are computed (except for the first and 
% fourth ones since they are computed after this)
for i=[2:3,5,7:12]
    PosD = [0,IniPos(i);
            T, hT_d(i)];
    VelD = [0, IniVel(i);
            T, hpT_d(i)];
    %prueba ema
    AccD = [0, 0;
            T, 0];
   PolyCoeff.(['hd', int2str(i)]) = findPolyCoeff(PosD,VelD,AccD); % posd,veld,accd
%    PolyCoeff.(['hd', int2str(i)]) = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
end
% However since it is desired to create 6 order polinomials for the vertical evolution of the CoM and Free foot,
% (due to an intermediate desired value) the coefficients for these polynomals are computed individually: 
PosD = [0,IniPos(1);
        T_midCoMz, z_i+a_z;      %<-- basically due to this calculation was not included in the loop
        T, hT_d(1)];
VelD = [0, IniVel(1);
        T_midCoMz, 0;
        T, hpT_d(1)];  
AccD = [0, 0;
        T, 0];
PolyCoeff.hd1 = findPolyCoeff(PosD,VelD,AccD); % posd,veld,accd
% Desired vertical displacement of the free foot
PosD = [0,IniPos(4); % z_ffoot_i = 0;
        T_midFoot, H_ffoot;      %<-- basically due to this calculation was not included in the loop
        T, hT_d(4)];
VelD = [0,IniVel(4); % z_ffoot_i = 0;
        T_midFoot, 0;      %<-- basically due to this calculation was not included in the loop
        T, hpT_d(4)];   
AccD = [0,0;
        T, 0];
PolyCoeff.hd4 = findPolyCoeff(PosD,VelD,AccD); % posd,veld,accd

% Desired angular motion in pitch of the free foot
PosD = [0,IniPos(6); % z_ffoot_i = 0;
        T_midFoot, Pitch_ffoot_inc;      %<-- basically due to this calculation was not included in the loop
        T, hT_d(6)]; % 
VelD = [0, IniVel(6);
        T_midFoot, 0;
        T, hpT_d(6)];    
AccD = [0,0;
        T,0];
PolyCoeff.hd6 = findPolyCoeff(PosD,VelD,AccD); % posd,veld,accd
