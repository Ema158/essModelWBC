function Func = Optim_ObjectiveFunc_Transition_SS_DS_fsolve_4param_opt2(R)

global gait_parameters_Starting_DS_final gait_parameters_Transition_SS gait_parameters_Transition_DS
global DesFixedPoint Rcyc
global cond_i
% ==============================================================================================
global contA % To count the number of cycles performed
Hour = datestr(now,13); % Now ->Read the current hour and date, 13 -> store just the hour, -1 -> default...
fprintf('\n-------------- OBJECTIVE FUNCTION FILE -------------------\n')
fprintf([Hour ' -> Cycle k = %d (of 700 maximum) for the EssentialModel \n'],contA);
% ==============================================================================================
disp('Performing one step of the robot');
% -----------------------------------------------   

ZMPx_SS_Ini = R(1); % 
ZMPy_SS_Ini = R(2); % S
ZMPx_SS_End = R(3);
ZMPy_SS_End = R(4);

fprintf('Proposed ZMP for initial SS:  \nZMPxi = %f, \nZMPyi = %f.\n',ZMPx_SS_Ini,ZMPy_SS_Ini )
fprintf('Proposed ZMP for final SS: \nZMPxf = %f, \nZMPyf = %f.\n.', ZMPy_SS_End,ZMPx_SS_End)
fprintf('-----------------------------------------------------\n')

%% Desired ZMP
% ---------------------------------------------------------------------
% Updating parameters for ZMP in the DS_final Starting phase
T_DS_final = gait_parameters_Starting_DS_final.T;
T1 = gait_parameters_Starting_DS_final.Tini;
T2 = gait_parameters_Starting_DS_final.Tend;
ZMPx_Ini = gait_parameters_Starting_DS_final.ZMPxIni;  % Fixed value
ZMPy_Ini = gait_parameters_Starting_DS_final.ZMPyIni;  % Fixed value
S = gait_parameters_Transition_SS.S;
D = gait_parameters_Transition_SS.D;
ZMPx_Fin = S + ZMPx_SS_Ini;
ZMPy_Fin = D + ZMPy_SS_Ini;
% Time at which the ZMP will stop its motion (it should be <= T)
Pos = [T1 ZMPx_Ini;
%        T_SS/2 ZMPx_SS_Mid;
       T2 ZMPx_Fin];
Vel = [];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPy_Ini;
      T2  ZMPy_Fin];
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
gait_parameters_Starting_DS_final.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
gait_parameters_Starting_DS_final.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
gait_parameters_Starting_DS_final.ZMPxIni = ZMPx_Ini;   % Initial desired position in X
% gait_parameters_Starting_DS_final.ZMPxMid = ZMPx_SS_Mid;   % middle desired position in X
gait_parameters_Starting_DS_final.ZMPxEnd = ZMPx_Fin;   % Final desired position in X
gait_parameters_Starting_DS_final.ZMPyIni = ZMPy_Ini;   % Final desired position in X
gait_parameters_Starting_DS_final.ZMPyEnd = ZMPy_Fin;   % Final desired position in Y

% ---------------------------------------------------------------------
% Updating parameters for ZMP in the initial SS phase
T_SS = gait_parameters_Transition_SS.T;
T1 = gait_parameters_Transition_SS.Tini;
T2 = gait_parameters_Transition_SS.Tend;
% ZMPx_Ini = ZMPx_SS_Ini;  % Fixed value
% ZMPy_Ini = ZMPy_SS_Ini;  % Fixed value
% ZMPx_Fin = ZMPx_SS_End;
% ZMPy_Fin = ZMPy_SS_End;
ZMPx_Ini = ZMPx_SS_Ini;  % Fixed value
ZMPy_Ini = ZMPy_SS_Ini;  % Fixed value
ZMPx_Fin = ZMPx_SS_End;
ZMPy_Fin = ZMPy_SS_End;
% Time at which the ZMP will stop its motion (it should be <= T)
Pos = [T1 ZMPx_Ini;
       T2 ZMPx_Fin];
Vel = [];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPy_Ini;
      T2  ZMPy_Fin];
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
gait_parameters_Transition_SS.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
gait_parameters_Transition_SS.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
gait_parameters_Transition_SS.ZMPxIni = ZMPx_Ini;   % Initial desired position in X
gait_parameters_Transition_SS.ZMPxEnd = ZMPx_Fin;   % Final desired position in X
gait_parameters_Transition_SS.ZMPyIni = ZMPy_Ini;   % Final desired position in X
gait_parameters_Transition_SS.ZMPyEnd = ZMPy_Fin;   % Final desired position in Y

% ---------------------------------------------------------------------
% Updating parameters for ZMP in the initial DS phase
T_DS = gait_parameters_Transition_DS.T;
T1 = gait_parameters_Transition_DS.Tini;
T2 = gait_parameters_Transition_DS.Tend;
ZMPx_DS_End = gait_parameters_Transition_DS.ZMPxEnd;
ZMPx_DS_Mid = gait_parameters_Transition_DS.ZMPxMid;
ZMPy_DS_End = gait_parameters_Transition_DS.ZMPyEnd;
% T_SS = gait_parameters_SS_Stopping.T;
% T_DS = gait_parameters_DS.T;
% Time at which the ZMP will stop its motion (it should be <= T)
Pos = [T1 ZMPx_SS_End;
       T2 ZMPx_DS_End];
Vel = [];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [T1 ZMPy_SS_End;
       T2 ZMPy_DS_End];
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
gait_parameters_Transition_DS.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
gait_parameters_Transition_DS.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
gait_parameters_Transition_DS.ZMPxIni = ZMPx_SS_End;   % Initial desired position in X
gait_parameters_Transition_DS.ZMPxMid = ZMPx_DS_Mid;   % Final desired position in X
gait_parameters_Transition_DS.ZMPxEnd = ZMPx_DS_End;   % Final desired position in X
gait_parameters_Transition_DS.ZMPyIni = ZMPy_SS_End;   % Initial desired position in Y
% gait_parameters_Transition_DS.ZMPyMid = ZMPy_DS_Mid;   % Initial desired position in Y
gait_parameters_Transition_DS.ZMPyEnd = ZMPy_DS_End;   % Final desired position in Y

% ---------------------------------------------------------------------
% Dx = Rcyc(1);
% Dy = Rcyc(2);
% xpf = Rcyc(3);
% ypf = Rcyc(4);
% xf = (gait_parameters_previous_DS.S)/2 + Dx;
% yf = (gait_parameters_previous_DS.D)/2 + Dy;
% x0 = -(gait_parameters_previous_DS.S)/2 + Dx;
% y0 = (gait_parameters_previous_DS.D)/2 - Dy;
% xp0 = Rcyc(3);
% yp0 = -Rcyc(4);
x0 = 0.027516820170849;
y0 = 0.031019222025603;
xp0 = 0.037518263214521;
yp0 = 0.114370870333924;
% X_final = [xf;yf;xpf;ypf];
X_final = [x0;y0;xp0;yp0];
%% Robot initial step DS and SS (Starting from REST)
[t,Xt,gait_parameters_Starting_DS_final,gait_parameters_Transition_SS,gait_parameters_Transition_DS] = ...
    robot_step_EssModel_DS_final_Transition(X_final,gait_parameters_Starting_DS_final,gait_parameters_Transition_SS,gait_parameters_Transition_DS);
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
    Func = [xf_fix - xf, yf_fix - yf, xpf_fix - xpf, ypf_fix - ypf]; 
    Tk = t(end); % Elapsed time to produce the impact
% FUNCTION TO MINIMIZE:
% ----------------------------------------------
 fprintf('Desired time step T = %f. Real time Step at cycle %d, Tk = %f\n',T_SS + T_DS,contA,Tk)
    fprintf('Proposed final values for the CoM states are: \n[xf(k), yf(k), xpf(k), ypf(k)] = [%f,%f,%f,%f]\n',xf_fix,yf_fix,xpf_fix,ypf_fix)
%     fprintf('After impact the values for the CoM states are: \n[x0(k+1), y0(k+1), xp0(k+1), yp0(k+1)] = [%f,%f,%f,%f]\n',x0, y0, xp0, yp0)
    fprintf('The final values for the CoM states are: \n[x(T)(k+1), y(T)(k+1), xp(T)(k+1), yp(T)(k+1)] = [%f,%f,%f,%f]\n',xf,yf,xpf,ypf)
%     fprintf('Function "[xf(k) - xf(k+1),yf(k) - yf(k+1), xpf(k) - xpf(k+1),ypf(k) - ypf(k+1), fac*(T - T(k))]"\n         = [%e,%e,%e,%e,%e]\n',Func)
%     fprintf('with fac = %d\n',fac)    
    fprintf('Function "[xf(k) - xf(k+1),yf(k) - yf(k+1), xpf(k) - xpf(k+1),ypf(k) - ypf(k+1)]"\n         = [%e,%e,%e,%e]\n',Func)

else
    disp([errorMessage,' Integration stopped because the robot configuration is unaccesible (Check PEvents_HDZtime.m)']);
    disp('--------------------------------------------------------------------------------------------');        
    Func = [1000, 1000, 1000, 1000]; 
    disp('NO COMPUTATION OF TORQUES was performed. A high value for cost function was defined....');    
    disp('--------------------------------------------------------------------------------------------');    
end

%% Storing variables
% ----------------------------------
% global ObjecFunc Rtotal
% ObjecFunc(contA) = J;
% Rtotal(:,contA)  = R;


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

