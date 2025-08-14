function Func = CycleEssentialModelZMPvar_x(R)

% This code is based in "CycleEssentialModelNoImpact".
% It is practically the same just the impact and the structure "robot" were added =)

% ==============================================================================================
global contA % To count the number of cycles performed
Hour = datestr(now,13); % Now ->Read the current hour and date, 13 -> store just the hour, -1 -> default...
fprintf([Hour ' -> Cycle k = %d (of 1200 maximum) for the EssentialModel \n'],contA);
% ==============================================================================================
global scale
DxProp = R(1)/scale; % Proposed displacement in X
DyProp = R(2)/scale; % Proposed displacement in Y
xpfProp = R(3); % Proposed final velocity in X
ypfProp = R(4); % Proposed final velocity in Y

fprintf('Proposed values [Dx, Dy, xpf, ypf] = [%f,%f,%f,%f]\n',DxProp,DyProp,xpfProp,ypfProp)
fprintf('-----------------------------------------------------\n')
    
global robot gait_parameters

S = gait_parameters.S;
D = gait_parameters.D;
T = gait_parameters.T;

xfProp = S/2 + DxProp;
yfProp = D/2 + DyProp;


%% Computation of the Impact and Rellabelling
% ====================================================================
% By using the final position and velocity of the CoM at time T, we compute the final joint positions and velocities
% of the robot in order to compute the impact
qf_final = [xfProp;yfProp];
qfp_final = [xpfProp;ypfProp];
[q_end,qp_end,~,~,~] = JointsPosVel_from_CoMPosVel_HZDtime(qf_final,qfp_final,robot,gait_parameters,T);
% By using final joints information, the structure of the robot is updated, i.e Jacobians,transformation matrices, etc.
robot = robot_move(robot,q_end);
robot.qD = qp_end;
% ----------------------------------------------------------------

[qfp0,robot] = impact_Pos_Vel(robot,gait_parameters.v_foot_f); %
gait_parameters.qfp0 = qfp0; % Velocity after impact is added to parameters to re-compute the polynomials
% The New robot position and velocity of the joints after impact and
% The New CoM velocity after impact are computed

% Computation of the initial position of the CoM after impact
G = robot.CoM;
x0 = G(1);        % Initial position in X of the CoM for the new step j+1
y0 = G(2);        % Initial position in Y of the CoM for the new step j+1
xp0 = qfp0(1);    % Initial velocity in X of the CoM for the new step j+1
yp0 = qfp0(2);    % Initial velocity in Y of the CoM for the new step j+1
% ====================================================================

% The next parameters needs to be updated, in order to rebuild the trajectory
% gait_parameters.Dx = DxProp;
% gait_parameters.Dy = DyProp;
% gait_parameters.x0cyc = x0;
% gait_parameters.y0cyc = y0;
% gait_parameters.xfcyc = xfProp;
% gait_parameters.yfcyc = yfProp;
% gait_parameters.xpfcyc = xpfProp;
% gait_parameters.ypfcyc = ypfProp;
% % Updating of the coefficients of the polynomials for the ZMP trajectory
% ZMPxIni = gait_parameters.ZMPxIni;
% ZMPyIni = gait_parameters.ZMPyIni;
% ZMPxEnd = gait_parameters.ZMPxEnd;
% ZMPyEnd = gait_parameters.ZMPyEnd;
% Pos = [x0 ZMPxIni;
%     xfProp ZMPxEnd];
% ZMPxCoeff = findPolyCoeff(Pos,[],[]);
% Pos = [x0 ZMPyIni;
%     xfProp ZMPyEnd];
% ZMPyCoeff = findPolyCoeff(Pos,[],[]);
% gait_parameters.ZMPxCoeff = ZMPxCoeff;
% gait_parameters.ZMPyCoeff = ZMPyCoeff;
ZMPxIni =  0;      % Local position of the desired ZMP in X for each step
ZMPxEnd =  0;
ZMPyIni =  0;      % Local position of the desired ZMP in Y for each step
ZMPyEnd =  0;
Pos = [x0 ZMPxIni;       
       qf_final(1) ZMPxEnd];
Vel = [];
Acc = [];
ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
Pos = [x0 ZMPyIni;
%        0.5*T 0; 
       qf_final(1) ZMPyEnd];     
ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
gait_parameters.ZMPxIni = ZMPxIni;   % Initial desired position in X
gait_parameters.ZMPyIni = ZMPyIni;   % Initial desired position in Y
gait_parameters.ZMPxEnd = ZMPxEnd;   % Final desired position in X
gait_parameters.ZMPyEnd = ZMPyEnd;   % Final desired position in Y
gait_parameters.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
gait_parameters.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
gait_parameters.Tini = 0;
gait_parameters.Tend = T;
% -------------------------------------------------------------
% x0cyc = -S/2 + DxProp;
% xfcyc = S/2 + DxProp;
x0cyc = x0;
xfcyc = S/2 + DxProp;
xmid = DxProp;
% COMPUTING POLYNOMIALS
% Computing of Coefficients for the polinomials by taking into account the states after impact
gait_parameters.transition = true;
PolyCoeff = InitialCoeff_DesiredTrajectories_x(robot,gait_parameters,x0cyc,xfcyc,xmid,xp0);
gait_parameters.PolyCoeff = PolyCoeff;

% Just to chck if the all the controlled variables are in the ZERO DYNAMICS MANIFOLD
ZeroDynamics_impactTime_test(x0,y0,qfp0,robot,gait_parameters);
% ---------------------------------------------------------------------------------

%% Evaluating the dynamics of the Essential model
% ====================================================================
% Initial states of the LIP
X0 = [x0, y0, xp0, yp0];
% ---------------------------------------
options = odeset('Events', @PEvents_HDZtime_Internal_State_x,'RelTol', 1.e-7, 'AbsTol', 1.e-9);
[t,Xt] = ode45(@dynam_HZDtime,0:1e-3:1,X0,options);

global noLanding
if (isempty(noLanding) || noLanding==0)    % if there was impact    
    % Xt -> It is the solution, i.e. X(t) = [x(t),y(t),xp(t),yp(t)], each COLUMN is one state
    xf = Xt(end,1);
    yf = Xt(end,2);
    xpf = Xt(end,3);
    ypf = Xt(end,4);
    Tk = t(end); % Elapsed time to produce the impact
    
    % Function we want to find its roots
    %fac = scale;  % The factor is to give more enfasis to the selected error
%     Func = [xfProp - xf, yfProp - yf, xpfProp - xpf, ypfProp - ypf, fac*(T - Tk)];
    Func = [xfProp - xf, yfProp - yf, xpfProp - xpf, ypfProp - ypf];
    
    fprintf('Desired time step T = %f. Real time Step at cycle %d, Tk = %f\n',T,contA,Tk)
    fprintf('Proposed final values for the CoM states are: \n[xf(k), yf(k), xpf(k), ypf(k)] = [%f,%f,%f,%f]\n',xfProp,yfProp,xpfProp,ypfProp)
    fprintf('After impact the values for the CoM states are: \n[x0(k+1), y0(k+1), xp0(k+1), yp0(k+1)] = [%f,%f,%f,%f]\n',x0, y0, xp0, yp0)
    fprintf('The final values for the CoM states are: \n[x(T)(k+1), y(T)(k+1), xp(T)(k+1), yp(T)(k+1)] = [%f,%f,%f,%f]\n',xf,yf,xpf,ypf)
%     fprintf('Function "[xf(k) - xf(k+1),yf(k) - yf(k+1), xpf(k) - xpf(k+1),ypf(k) - ypf(k+1), fac*(T - T(k))]"\n         = [%e,%e,%e,%e,%e]\n',Func)
%     fprintf('with fac = %d\n',fac)    
    fprintf('Function "[xf(k) - xf(k+1),yf(k) - yf(k+1), xpf(k) - xpf(k+1),ypf(k) - ypf(k+1)]"\n         = [%e,%e,%e,%e]\n',Func)
        
else % if there was impact
    fprintf('===============================================================================\n')
    fprintf(' Since there was no landing of the free foot, the states are not considered\n')
    fprintf('===============================================================================\n')
    % Start again...
    Func = ones(1,4);
%     xpf = 6.795860e-01; %
%     ypf = 1.909883e-01;
%     Dx = 2.881107e-03;  %
%     Dy = 4.968986e-04;  %
%     % Initial and final position is computed as (this is not used in here)    
%     xf = S/2 + Dx;
%     yf = D/2 + Dy;
    fprintf('Function = [%e,%e,%e,%e]\n',Func);  
    noLanding = 0; % Restart flag
end
disp('---------------------------------------------------------------------------------------------------------')
disp('')

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

