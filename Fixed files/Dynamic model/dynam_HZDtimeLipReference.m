% -------------------------------------------------------
% Utiliza "Desired_qfpp_Pos_Vel" para obtener qfpp
% -------------------------------------------------------

function [ XD ] = dynam_HZDtimeLipReference(t,X)
%%Simple support dynamic model (zero dynamics) for the robot model
%   State variable (x, y, xp, yp)
global robot gait_parameters XrefLip ZMPrefLip tref
% % init;
x = X(1);
y = X(2);
xp = X(13);
yp = X(14);

qf = X(1:12);     % CoM position
qfp = X(13:24);  % CoM velocity

% -----------------------------------------------------------------
% Chosing a variable or constant desired ZMP
% -----------------------------------------------------------------
% Desired ZMP position in X
% [XrefEval,ZMPEval,~] = evaluateXrefPoly(XrefLip,ZMPrefLip,tref,t);
[XrefEval,ZMPEval,~] = evaluateXrefPosVelAccPoly(XrefLip,ZMPrefLip,tref,t);
ZMPd = [ZMPEval(1);ZMPEval(2)];
% XrefEval = [0,0];
% ZMPd = [0;0.05];

% ==============================================================================================
global contB DisplayIterNumber
% Dynamics
%  ---------------------
global OutOfWorkSpace
% if t==0.5
%     ema=1;
% end
if isempty(OutOfWorkSpace)
    [qfpp, ~, ~, ~, ~, ~, ~] = Desired_qfpp_HZDtimeQPLipReference(XrefEval,ZMPd,robot,[qf;qfp],gait_parameters,t);
else
    qfpp = zeros(12,1);
    fprintf('Iteration %d. CoM OUT of WORKSPACE!. Essential model NOT computed.  \n',contB);
end

% Output
XD = [qfp; qfpp];
if ~isempty(DisplayIterNumber) % If there exist a value is because it is desired to show the number of iteration performed
    Hour = datestr(now,13); % Now -> read corrent date and time, 13 -> Store just time, -1 -> default...
    fprintf([Hour ' -> [t,px,py,XppR,YppR,Xpp,Ypp] = [%f,%f,%f,%f,%f,%f,%f]\n'],t,ZMPd(1),ZMPd(2),XrefEval(1),XrefEval(2),qfpp(1),qfpp(2));
end
% Counter is increased in order to know the number of iteration performed
contB = contB + 1;
end