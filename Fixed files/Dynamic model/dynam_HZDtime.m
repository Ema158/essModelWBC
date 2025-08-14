% -------------------------------------------------------
% Utiliza "Desired_qfpp_Pos_Vel" para obtener qfpp
% -------------------------------------------------------

function [ XD ] = dynam_HZDtime(t,X)
%%Simple support dynamic model (zero dynamics) for the robot model
%   State variable (x, y, xp, yp)
global robot gait_parameters
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

global OptionContVar
% Desired ZMP position in X
% -----------------------------------------------------------
if isfield(gait_parameters,'ZMPxCoeff') ||  isfield(gait_parameters,'ZMPxLinear')
    ZMPxCoeff = gait_parameters.ZMPxCoeff;
    ZMPxIni = gait_parameters.ZMPxIni;
    ZMPxEnd = gait_parameters.ZMPxEnd;
    T1 = gait_parameters.Tini;   % T1 is used to start the trayectory
    T2 = gait_parameters.Tend;   % T2 is used to finish the trayectory    
    switch OptionContVar
        case {1}
            if t<T1
                ZMPdX = ZMPxIni;
            elseif t<T2
                if ~isempty(ZMPxCoeff)
                    ZMPdX = polyval(ZMPxCoeff,t);
                else
                    ZMPxDesiredPoints = gait_parameters.ZMPxDesiredPoints;
                    ZMPdX = interp1q(ZMPxDesiredPoints(:,1),ZMPxDesiredPoints(:,2),t);
                end
            else
                ZMPdX = ZMPxEnd;
            end
        case {2}
            if ~isempty(ZMPxCoeff)
                ZMPdX = polyval(ZMPxCoeff,x);
            else
                ZMPxDesiredPoints = gait_parameters.ZMPxDesiredPoints;
                ZMPdX = interp1q(ZMPxDesiredPoints(:,1),ZMPxDesiredPoints(:,2),x);
            end
    end
else
    ZMPdX = 0;
end

% Desired ZMP position in Y
% -----------------------------------------------------------
if isfield(gait_parameters,'ZMPyCoeff') ||  isfield(gait_parameters,'ZMPyLinear')
    ZMPyCoeff = gait_parameters.ZMPyCoeff;
    ZMPyIni = gait_parameters.ZMPyIni;
    ZMPyEnd = gait_parameters.ZMPyEnd;
    T1 = gait_parameters.Tini;   % T1 is used to start the trayectory
    T2 = gait_parameters.Tend;   % T2 is used to finish the trayectory    
    switch OptionContVar
        case {1}
            if t<T1
                ZMPdY = ZMPyIni;
            elseif t<T2
                if ~isempty(ZMPyCoeff)
                    ZMPdY = polyval(ZMPyCoeff,t);
                else
                    ZMPyDesiredPoints = gait_parameters.ZMPyDesiredPoints;
                    ZMPdY = interp1q(ZMPyDesiredPoints(:,1),ZMPyDesiredPoints(:,2),t);
                end
            else
                ZMPdY = ZMPyEnd;
            end
        case {2}
            if ~isempty(ZMPyCoeff)
                ZMPdY = polyval(ZMPyCoeff,x);
            else
                ZMPyDesiredPoints = gait_parameters.ZMPyDesiredPoints;
                ZMPdY = interp1q(ZMPyDesiredPoints(:,1),ZMPyDesiredPoints(:,2),x);
            end
    end
else
    ZMPdY = 0;
end
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
%     [qfpp, ~, ~, ~, ~, ~, ~] = Desired_qfpp_HZDtime(ZMPd,robot,[qf;qfp],gait_parameters,t);
    [qfpp, ~, ~, ~, ~, ~, ~] = Desired_qfpp_HZDtimeQP(ZMPd,robot,[qf;qfp],gait_parameters,t);
else
    qfpp = zeros(12,1);
    fprintf('Iteration %d. CoM OUT of WORKSPACE!. Essential model NOT computed.  \n',contB);
end

% Output
XD = [qfp; qfpp];
% Counter is increased in order to know the number of iteration performed
contB = contB + 1;
end