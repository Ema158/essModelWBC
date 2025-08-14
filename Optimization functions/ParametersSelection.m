function [param, LowerBoundsParam, UpperBoundsParam] = ParametersSelection()
global optimParam
% "optimParam" is a vector to chose which parameters we want to optimize
% Gait parameters
% ----------------
% optimParam(1) -> z0
% optimParam(2) -> a_z
% optimParam(3) -> T
% optimParam(4) -> S
% optimParam(5) -> D
% optimParam(6) -> H_ffoot
% optimParam(7) -> ZMPxIni
% optimParam(8) -> ZMPxEnd
% optimParam(9) -> ZMPyIni
% optimParam(10) -> ZMPyEnd 
% Upper body parameters
% ----------------
% optimParam(11) -> Hip_Yaw: Used for Hip yaw ini/end (0R7)
% optimParam(12) -> Hip_Pitch_i : Used for hip pitch ini (0R7)
% optimParam(13) -> Hip_Pitch_f : Used for hip pitch orientation at t=T/2 (0R7)
% optimParam(14) -> Hip_Roll : Used for hip roll ini/end (0R7)
% optimParam(15) -> Yaw_torso_neck_i : Used for Torso ini/end and Neck ini/end (q13 and q14)
% optimParam(16) -> Shoulder_Pitch_i : Used for RShoulder ini and LShoulder end (q18 and q25)
% optimParam(17) -> Shoulder_Pitch_f : Used for RShoulder end and LShoulder ini (q18 and q25)
% optimParam(18) -> Shoulder_Yaw_i : Used for RShoulder ini and LShoulder end (q19 and q20)
% optimParam(19) -> Shoulder_Yaw_f : Used for RShoulder end and LShoulder in
% optimParam(20) -> Elbow_Roll_i : Used for RElbow ini and LElbow end (q20 and q27)
% optimParam(21) -> Elbow_Roll_f : Used for RElbow end and LElbow ini (q20 and q27)
% optimParam(22) -> Elbow_Yaw_i : Used for RElbow ini and LElbow end (q21 and q28)
% optimParam(23) -> Elbow_Yaw_f : Used for RElbow end and LElbow ini (q21 and q28)


% ---------------------------------------
global gait_parameters
param = [];
BoundsParam = [];
% Gait parameters
% =========================================================================
if optimParam(1)
    z0 = gait_parameters.z_i;       % Initial hight of the CoM
    Lim_z0 = [0.22; 0.27];
    param = [param z0];
    BoundsParam = [BoundsParam Lim_z0];
end

if optimParam(2)
    a_z = gait_parameters.a_z;       % Maximum amplitude oscillation of the CoM
    Lim_a_z = [-0.05; 0.05];
    param = [param a_z];
    BoundsParam = [BoundsParam Lim_a_z];
end

if optimParam(3)
    T = gait_parameters.T;           % Period of the step
    Lim_T = [0.2; 0.8];
    param = [param T];
    BoundsParam = [BoundsParam Lim_T];
end

if optimParam(4)
    S = gait_parameters.S/2;   % Distance traveled in X by the free foot to reach the final position in X
    Lim_S = [0.02; 0.06];
    param = [param S];
    BoundsParam = [BoundsParam Lim_S];
end

if optimParam(5)
    D = gait_parameters.y_ffoot_i;     % Initial step position in Y
    Lim_D = [0.1; 0.25];
    param = [param D];
    BoundsParam = [BoundsParam Lim_D];
end

if optimParam(6)
    H_ffoot = gait_parameters.H_ffoot;   % Foot maximum hight
    Lim_H_ffoot = [0.01; 0.1];
    param = [param H_ffoot];
    BoundsParam = [BoundsParam Lim_H_ffoot];
end

if optimParam(7)
    ZMPxIni = gait_parameters.ZMPxIni;    % Local position of the desired ZMP in X for each step
    lim_ZMPx = [-0.02; 0.1];             % ZMP limits for initial and final position in X
    param = [param ZMPxIni];
    BoundsParam = [BoundsParam lim_ZMPx];
end

if optimParam(8)
    ZMPxEnd = gait_parameters.ZMPxEnd;
    lim_ZMPx = [-0.02; 0.1]; % ZMP limits for initial and final position in X
    param = [param ZMPxEnd];
    BoundsParam = [BoundsParam lim_ZMPx];
end

if optimParam(9)
    ZMPyIni = gait_parameters.ZMPyIni;      % Local position of the desired ZMP in Y for each step
    lim_ZMPy = [-0.15; 0.15]; % ZMP limits for initial and final position in Y
    param = [param ZMPyIni];
    BoundsParam = [BoundsParam lim_ZMPy];
end

if optimParam(10)
    ZMPyEnd = gait_parameters.ZMPyEnd;
    lim_ZMPy = [-0.15; 0.15]; % ZMP limits for initial and final position in Y
    param = [param ZMPyEnd];
    BoundsParam = [BoundsParam lim_ZMPy];
end

% Upper body
% =========================================================================
if optimParam(11)
    Hip_Yaw = gait_parameters.Hip_Yaw_i;   % Initial orientation of the hip around Z 
    Lim_Hip_Yaw = [0; 0.4];
    param = [param Hip_Yaw];
    BoundsParam = [BoundsParam Lim_Hip_Yaw];
end

if optimParam(12)
    Pitch_torso_i = gait_parameters.Pitch_torso_i;       % Initial orientation of the torso (hip) around Y
    Lim_Pitch_torso_i = [-0.15; 0.3];
    param = [param Pitch_torso_i];
    BoundsParam = [BoundsParam Lim_Pitch_torso_i];
end

if optimParam(13)
    Pitch_torso_f = gait_parameters.Pitch_torso_f;     %  Orientation of the torso around Y at t = T/2
    Lim_Pitch_torso_f = [-0.15; 0.3];
    param = [param Pitch_torso_f];
    BoundsParam = [BoundsParam Lim_Pitch_torso_f];
end

if optimParam(14)
    Hip_Roll = gait_parameters.Hip_Roll_i;   % Initial orientation of the hip around X
    Lim_Hip_Roll = [-0.15; 0];
    param = [param Hip_Roll];
    BoundsParam = [BoundsParam Lim_Hip_Roll];
end

if optimParam(15)
    Yaw_torso_neck = gait_parameters.Yaw_torso_i;       % Initial orientation of the torso around Z
    Lim_Yaw_torso_neck = [-0.25; 0];
    param = [param Yaw_torso_neck];
    BoundsParam = [BoundsParam Lim_Yaw_torso_neck];
end

if optimParam(16)
    Shoulder_Pitch_i = gait_parameters.RShoulder_Pitch_i; % Initial orientation of the right shoulder around Y
    Lim_Shoulder_Pitch = [1.4; 2.14];
    param = [param Shoulder_Pitch_i];
    BoundsParam = [BoundsParam Lim_Shoulder_Pitch];
end

if optimParam(17)
    Shoulder_Pitch_f = gait_parameters.RShoulder_Pitch_f; % Final orientation of the right shoulder around Y
    Lim_Shoulder_Pitch = [1.4; 2.14];
    param = [param Shoulder_Pitch_f];
    BoundsParam = [BoundsParam Lim_Shoulder_Pitch];
end

if optimParam(18)
    Shoulder_Yaw_i = gait_parameters.RShoulder_Yaw_i; % Initial orientation of the right shoulder around Z
    Lim_Shoulder_Yaw = [-1; 0.4];
    param = [param Shoulder_Yaw_i];
    BoundsParam = [BoundsParam Lim_Shoulder_Yaw];
end

if optimParam(19)
    Shoulder_Yaw_f = gait_parameters.RShoulder_Yaw_f; % Final orientation of the right shoulder around Z
    Lim_Shoulder_Yaw = [-1; 0.4];  
    param = [param Shoulder_Yaw_f];
    BoundsParam = [BoundsParam Lim_Shoulder_Yaw];
end

if optimParam(20)
    Elbow_Roll_i = gait_parameters.RElbow_Roll_i; % Initial orientation of the right elbow around X
    Lim_Elbow_Roll = [-1.9; 2.21];
    param = [param Elbow_Roll_i];
    BoundsParam = [BoundsParam Lim_Elbow_Roll];
end

if optimParam(21)
    Elbow_Roll_f = gait_parameters.RElbow_Roll_f; % Final orientation of the right elbow around X
    Lim_Elbow_Roll = [-1.9; 2.21];
    param = [param Elbow_Roll_f];
    BoundsParam = [BoundsParam Lim_Elbow_Roll];
end

if optimParam(22)
    Elbow_Yaw_i = gait_parameters.RElbow_Yaw_i; % Initial orientation of the right elbow around Y
    Lim_Elbow_Yaw = [0; 1.52];
    param = [param Elbow_Yaw_i];
    BoundsParam = [BoundsParam Lim_Elbow_Yaw];
end

if optimParam(23)
    Elbow_Yaw_f = gait_parameters.RElbow_Yaw_f; % Final orientation of the right elbow around Y
    Lim_Elbow_Yaw = [0; 1.52];
    param = [param Elbow_Yaw_f];
    BoundsParam = [BoundsParam Lim_Elbow_Yaw];
end

% Limits for the Gait parameters
if isempty(BoundsParam)
    LowerBoundsParam = [];
    UpperBoundsParam = [];
else
    LowerBoundsParam = BoundsParam(1,:);
    UpperBoundsParam = BoundsParam(2,:);
end

end