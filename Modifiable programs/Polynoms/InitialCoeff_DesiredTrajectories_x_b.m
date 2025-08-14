
function PolyCoeff = InitialCoeff_DesiredTrajectories_x_b(gait_parameters)

% In this code the coefficients of of the polynomials that define the trajectory for step of the robot are computed
% based on the current state of the robot (after impact)

z_i = gait_parameters.z_i;
Step_length = gait_parameters.Step_length;
x0cyc = gait_parameters.x0cyc;
xfcyc = gait_parameters.xfcyc;
xpfcyc = gait_parameters.xpfcyc;

H_ffoot = gait_parameters.H_ffoot;
x_ffoot_i = gait_parameters.x_ffoot_i;
y_ffoot_i = gait_parameters.y_ffoot_i;
z_ffoot_i = gait_parameters.z_ffoot_i;
wide_error = gait_parameters.wide_error;
z_ffoot_f = gait_parameters.z_ffoot_f;
a_z = gait_parameters.a_z;  % Maximum amplitude oscillation of the CoM
v_foot_f = gait_parameters.v_foot_f;  % Final landing velocity of the free foot;

Dx = gait_parameters.Dx;
xmid = Dx;  %The intermediate value of the CoM (in the middle between xf and x0)

% Desired vertical displacement of the CoM
PosD = [x0cyc, z_i;
        xmid,  z_i+a_z;
        xfcyc, z_i];
VelD = [x0cyc, 0;
        xmid, 0;
        xfcyc, 0];    
PolyCoeff.hd1 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
% Desired horizontal displacement in X of the free foot
PosD = [x0cyc, x_ffoot_i; 
        xfcyc, x_ffoot_i+Step_length];
VelD = [x0cyc, 0;
        xfcyc, 0];    
PolyCoeff.hd2 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
% Desired horizontal displacement in Y of the free foot
PosD = [x0cyc, y_ffoot_i; 
        xfcyc, y_ffoot_i+wide_error];
VelD = [x0cyc, 0;
        xfcyc, 0];    
PolyCoeff.hd3 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd
% Desired vertical displacement of the free foot
PosD = [x0cyc, z_ffoot_i; % 
         xmid, H_ffoot;
        xfcyc, z_ffoot_f]; % 0
VelD = [x0cyc, 0;
         xmid, 0;
        xfcyc, v_foot_f/xpfcyc];    
PolyCoeff.hd4 = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd

% For the rest controlled variables we just care the final desired values
% Desired values for position of the controlled variables "hd" at time T
% -----------------------------------------------------------------------------
hdDesT = zeros(20,1);
%Left arm
hdDesT(11) = 1.57; % 
hdDesT(12) = -0.2;  %
hdDesT(13) = 1.57;  % 
hdDesT(14) = 1.22;
%Right arm
hdDesT(15) = 1.57; %
hdDesT(16) = 0.2; %
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
    PosD = [x0cyc, hdDesT(i);
            xfcyc, hdDesT(i)];
    VelD = [x0cyc, hpdDesT(i);
            xfcyc, hpdDesT(i)];
    PolyCoeff.(['hd', int2str(i)]) = findPolyCoeff(PosD,VelD,[]); % posd,veld,accd    
end
