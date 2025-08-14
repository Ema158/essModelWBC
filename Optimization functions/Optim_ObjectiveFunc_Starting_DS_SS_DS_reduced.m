function J = Optim_ObjectiveFunc_Starting_DS_SS_DS_reduced(R)
% This code is based on "Optim_ObjectiveFunc_Starting_DS_SS_DS" but instead of 9 parameters to optimize, there are only 4
% 1-> ZMP in X for initial, intermediate and final in DS AND initial of SS
% 2-> ZMP in Y for final in DS initial of SS
% 3-> ZMP in X for final of SS and initial of DS_final
% 4-> ZMP in Y for final of SS and initial of DS_final
% Note: The evolution of the ZMP for the 3 phases are straight lines. Moreover for DS is a vertical line. In fact:
%       Initial ZMP in Y for DS is fixed
%       The middle point for DS is just considered in Y and is fixed
%       Final ZMP in X for DS_final is fixed   
%       No middle points are taken into account for SS and DS_final

global gait_parameters_DS gait_parameters_SS gait_parameters_DS_final
global DesFixedPoint
% ==============================================================================================
global contA % To count the number of cycles performed
Hour = datestr(now,13); % Now ->Read the current hour and date, 13 -> store just the hour, -1 -> default...
fprintf('\n-------------- OBJECTIVE FUNCTION FILE -------------------\n')
fprintf([Hour ' -> Cycle k = %d (of 700 maximum) for the EssentialModel \n'],contA);
% ==============================================================================================
disp('Performing one step of the robot');
% -----------------------------------------------   

ZMPx_1 = R(1); % Proposed ZMP in X for initial, intermediate and final in DS AND initial of SS
ZMPy_1 = R(2); % Proposed ZMP in Y for final in DS initial of SS
ZMPx_2 = R(3); % Proposed ZMP in X for final of SS and initial of DS_final
ZMPy_2 = R(4); % Proposed ZMP in Y for final of SS and initial of DS_final

fprintf('Proposed ZMP for initial SS:  \nZMPx = %f, \nZMPy = %f.\n',ZMPx_1,ZMPy_1)
fprintf('Proposed ZMP for final SS:  \nZMPx = %f, \nZMPy = %f.\n',ZMPx_2,ZMPy_2)
fprintf('-----------------------------------------------------\n')

%% Desired ZMP
% ---------------------------------------------------------------------
% Updating parameters for ZMP in the initial DS phase
T = gait_parameters_DS.T;
T1 = gait_parameters_DS.Tini;
T2 = gait_parameters_DS.Tend;
ZMPy_Ini = gait_parameters_DS.ZMPyIni;  % Fixed value
ZMPy_Mid = gait_parameters_DS.ZMPyMid;  % Fixed value
% Time at which the ZMP will stop its motion (it should be <= T)
Pos = [T1 ZMPx_1;
       T2 ZMPx_1];
Vel = [];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPy_Ini;
      T/2 ZMPy_Mid;
      T2  ZMPy_1];
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
gait_parameters_DS.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
gait_parameters_DS.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
gait_parameters_DS.ZMPxIni = ZMPx_1;   % Initial desired position in X
gait_parameters_DS.ZMPxEnd = ZMPx_1;   % Final desired position in X
gait_parameters_DS.ZMPyEnd = ZMPy_1;   % Final desired position in Y

% ---------------------------------------------------------------------
% Updating parameters for ZMP in the initial SS phase
T = gait_parameters_SS.T;
T1 = gait_parameters_SS.Tini;
T2 = gait_parameters_SS.Tend;
% Time at which the ZMP will stop its motion (it should be <= T)
Pos = [T1 ZMPx_1;
       T2 ZMPx_2];
Vel = [];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPy_1;
       T2 ZMPy_2];
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
gait_parameters_SS.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
gait_parameters_SS.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
gait_parameters_SS.ZMPxIni = ZMPx_1;   % Initial desired position in X
gait_parameters_SS.ZMPxEnd = ZMPx_2;   % Final desired position in X
gait_parameters_SS.ZMPyIni = ZMPy_1;   % Initial desired position in Y
gait_parameters_SS.ZMPyEnd = ZMPy_2;   % Final desired position in Y

% ---------------------------------------------------------------------
% Updating parameters for ZMP in the final DS phase
T = gait_parameters_DS_final.T;
T1 = gait_parameters_DS_final.Tini;
T2 = gait_parameters_DS_final.Tend;
ZMPx_End_DSfinal = gait_parameters_DS_final.ZMPxEnd;  % this value correspond to the initial ZMP in X of the cyclic motion
ZMPy_End_DSfinal = gait_parameters_DS_final.ZMPyEnd;  % this value correspond to the initial ZMP in Y of the cyclic motion
ZMPy_Mid_DSfinal = gait_parameters_DS_final.ZMPyMid;
% Time at which the ZMP will stop its motion (it should be <= T)
Pos = [T1 ZMPx_2;
       T2 ZMPx_End_DSfinal];
Vel = [];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPy_2;
       T/2 ZMPy_Mid_DSfinal;
      T2 ZMPy_End_DSfinal];
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
gait_parameters_DS_final.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
gait_parameters_DS_final.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
gait_parameters_DS_final.ZMPxIni = ZMPx_2;   % Initial desired position in X
gait_parameters_DS_final.ZMPyIni = ZMPy_2;   % Initial desired position in Y


%% Robot initial step DS and SS (Starting from REST)
[t,Xt,t_SS,Xt_SS,t_DS,Xt_DS,t_DS_final,Xt_DS_final,gait_parameters_SS,gait_parameters_DS,gait_parameters_DS_final] = ...
    robot_step_EssModel_Start_DS_SS_DS_t(gait_parameters_SS,gait_parameters_DS,gait_parameters_DS_final);
% Initial states (current step) after impact
x0 = Xt(1,1);
y0 = Xt(1,2);
xp0 = Xt(1,3);
yp0 = Xt(1,4);
% Final states (current step) after impact
xf = Xt(end,1);
yf = Xt(end,2);
xpf = Xt(end,3);
ypf = Xt(end,4);
xf_fix = DesFixedPoint(1);
yf_fix = DesFixedPoint(2);
xpf_fix = DesFixedPoint(3);
ypf_fix = DesFixedPoint(4);
fprintf('Desired cyclic motion at the end DS phase = [%f,%f,%f,%f]\n',xf_fix,yf_fix,xpf_fix,ypf_fix)
fprintf('Initial states Step {k} = [%f,%f,%f,%f]\n',x0,y0,xp0,yp0)
fprintf('Final states Step {k} = [%f,%f,%f,%f]\n',xf,yf,xpf,ypf)

%% ERRORS (for skip the rest of the function)
% -------------------------------------
global contD OutOfWorkSpace errorWorkspace
if OutOfWorkSpace
    contD = []; % Every time the robot is out of the workspace and "PEvents" is called, 'contD' is used to stop de integration
    OutOfWorkSpace = []; % Reset workspace flag
    errorMessage = 'OUT OF WORKSPACE -> ';
    errorWorkspace(contA) = 1;
else
    errorWorkspace(contA) = 0;
end
% -------------------------------------
global noLanding errorLanding % is defined in "PEvents_HDZtime."
if (isempty(noLanding) || noLanding==0)    % if there was an impact...
    errorLanding(contA) = 0;
else   % if there was NO impact
    errorLanding(contA) = 1;        
    noLanding = 0; % Restart flag
    errorMessage = 'NO LANDING -> ';     
end
ERROR = errorLanding(contA) || errorWorkspace(contA);
% ================================================================================

% Some of these global functions are used inside the IF-ELSE sentence
if ~ERROR    % IF THERE IS NO ERROR... the code continues....
    %% Sampling
    errorMessage = '';    
    
    %% Objective function    
    a = 100;
    b = 100;
    %b=1;
    % J = a*((xf_fix - xf)^2 + (yf_fix - yf)^2) +  b*((xpf_fix - xpf)^2 + (ypf_fix - ypf)^2) ;
    J = (a*(xf_fix - xf))^2 + (a*(yf_fix - yf))^2 +  (b*(xpf_fix - xpf))^2 + (b*(ypf_fix - ypf))^2 ;
       
else
    disp([errorMessage,' Integration stopped because the robot configuration is unaccesible (Check PEvents_HDZtime.m)']);
    disp('--------------------------------------------------------------------------------------------');        
    J = 1e4; % Big value for the cost function
    disp('NO COMPUTATION OF TORQUES was performed. A high value for cost function was defined....');    
    disp('--------------------------------------------------------------------------------------------');    
end

% FUNCTION TO MINIMIZE:
% ----------------------------------------------
% J
disp('-------------------------------------')
fprintf([errorMessage,'Objective function J = %f\n'],J);
disp('-------------------------------------')
disp('')

%% Storing variables
% ----------------------------------
global ObjecFunc Rtotal
ObjecFunc(contA) = J;
Rtotal(:,contA)  = R;


%% To display information in the command display
% ----------------------------------------------------------------
contA = contA + 1;
global contB % number of iteration inside the solver
if ~isempty(contB)
    contB = 1;
end
    
global contC 
if ~isempty(contC)  % If contC is empty means it wasn't initialized (in other codes) thus it is not required
                    % to plot the evolution of the CoM in PEvents
    contC = 1;  % If is not empty, then each cycle is re-initialized and the variables must be cleaned
    global CoMx CoMy
    CoMx = [];
    CoMy = [];        
end
% -----------------------------------------------------------------

