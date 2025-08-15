% -------------------------------------------------------
% Utiliza "Desired_qfpp_Pos_Vel" para obtener qfpp
% -------------------------------------------------------

function [ XD ] = dynam_HZD_DS(t,X)
%%Simple support dynamic model (zero dynamics) for the robot model
%   State variable (x, y, xp, yp)
global robot gait_parameters Xref ZMPRef
qf = X(1:12);     % CoM position
qfp = X(13:24);  % CoM velocity
% -----------------------------------------------------------------
ZMPd = [ZMPRef(1);ZMPRef(2)];
% ==============================================================================================
global contB 
% Dynamics
%  ---------------------
global OutOfWorkSpace
if isempty(OutOfWorkSpace)
    qfpp = Desired_qfppDS(Xref,ZMPd,robot,[qf;qfp],gait_parameters,t);
else
    qfpp = zeros(12,1);
    fprintf('Iteration %d. CoM OUT of WORKSPACE!. Essential model NOT computed.  \n',contB);
end

% Output
XD = [qfp; qfpp];
contB = contB + 1;
end