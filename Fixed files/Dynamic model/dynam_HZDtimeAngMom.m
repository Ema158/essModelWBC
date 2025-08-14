% -------------------------------------------------------
% Utiliza "Desired_qfpp_Pos_Vel" para obtener qfpp
% -------------------------------------------------------

function [ XD ] = dynam_HZDtimeAngMom(t,X)
%%Simple support dynamic model (zero dynamics) for the robot model
%   State variable (x, y, xp, yp)
global robot gait_parameters zmpTrajX zmpTrajY
% % init;
x=X(1);
y=X(2);
xp =X(3);
yp =X(4);

qf = [x;y];     % CoM position
qfp = [xp;yp];  % CoM velocity

% -----------------------------------------------------------------
% Chosing a variable or constant desired ZMP
% -----------------------------------------------------------------
% Desired ZMP position in X
% -----------------------------------------------------------

[zmpTrajX,zmpTrajY] = optimalZMPPreviousStep(gait_parameters,X,t);
ZMPdX = zmpTrajX(1);
ZMPdY = zmpTrajY(1);
% Desired ZMP position in Y
% -----------------------------------------------------------
% -----------------------------------------------------------
ZMPd = [ZMPdX;ZMPdY];

% ==============================================================================================
global contB DisplayIterNumber
if ~isempty(DisplayIterNumber) % If there exist a value is because it is desired to show the number of iteration performed
    Hour = datestr(now,13); % Now -> read corrent date and time, 13 -> Store just time, -1 -> default...
    fprintf([Hour ' -> Iteration %d of the Zero Dynamics with desired ZMP = [%f,%f]\n'],contB,ZMPdX,ZMPdY);
end
% Dynamics
%  ---------------------
global OutOfWorkSpace
if isempty(OutOfWorkSpace)
    [qfpp, ~, ~, ~, ~, ~, ~] = Desired_qfpp_HZDtime(ZMPd,robot,[qf;qfp],gait_parameters,t);
else
    qfpp =[0;0];
    fprintf('Iteration %d. CoM OUT of WORKSPACE!. Essential model NOT computed.  \n',contB);
end

% Output
XD = [qfp; qfpp];
% Counter is increased in order to know the number of iteration performed
contB = contB + 1;
end