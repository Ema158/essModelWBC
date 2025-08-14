function Func = CycleEssModelZMPvarTwoSteps_LIP(R)

% This code is based in "CycleEssentialModelNoImpact".
% It is practically the same just the impact and the structure "robot" were added =)

% ==============================================================================================
global contA % To count the number of cycles performed
Hour = datestr(now,13); % Now ->Read the current hour and date, 13 -> store just the hour, -1 -> default...
fprintf([Hour ' -> Cycle k = %d (of 1200 maximum) for the EssentialModel \n'],contA);
% ==============================================================================================
global gait_parameters
global gait_parameters_step1 gait_parameters_step2
global scale
DxProp = R(1)/scale; % Proposed displacement in X
DyProp = R(2)/scale; % Proposed displacement in Y
xpfProp = R(3); % Proposed final velocity in X
ypfProp = R(4); % Proposed final velocity in Y

fprintf('Proposed values [Dx, Dy, xpf, ypf] = [%f,%f,%f,%f]\n',DxProp,DyProp,xpfProp,ypfProp)
fprintf('-----------------------------------------------------\n')

T = gait_parameters_step1.T;
S = gait_parameters_step1.S;
D = gait_parameters_step1.D;

xfProp = S/2 + DxProp;
yfProp = D/2 + DyProp;



%% STRIDE (2 STEPS) of the robot
% First step
% ------------------
disp('FIRST STEP')
% gait_parameters = gait_parameters_step2;
gait_parameters_PreviousStep = gait_parameters_step2;
gait_parameters_CurrentStep = gait_parameters_step1;
X_final = [xfProp;yfProp;xpfProp;ypfProp]; % previous step
% [t_step1,X0_step1,Xt_step1] = robot_step_EssModel_t(X_final); % "robot" and "gait_parameters" structures are needed inside
[t_step1,X0_step1,Xt_step1] = robot_TwoDiffSteps_EssModel_LIP(X_final,gait_parameters_CurrentStep,gait_parameters_PreviousStep); % "robot" structures are needed inside
% % Initial states (current step) after impact
% x0_step1 = X0_step1(1);
% y0_step1 = X0_step1(2);
% xp0_step1 = X0_step1(3);
% yp0_step1 = X0_step1(4);
% Final states (current step) after impact
xf_step1 = Xt_step1(end,1);
yf_step1 = Xt_step1(end,2);
xpf_step1 = Xt_step1(end,3);
ypf_step1 = Xt_step1(end,4);
% fprintf('Final states Step {k-1} = [%f,%f,%f,%f]\n',xfProp,yfProp,xpfProp,ypfProp)
% fprintf('Initial states Step {k} = [%f,%f,%f,%f]\n',x0_step1,y0_step1,xp0_step1,yp0_step1)
% fprintf('Final states Step {k} = [%f,%f,%f,%f]\n',xf_step1,yf_step1,xpf_step1,ypf_step1)
gait_parameters_step1 = gait_parameters;

disp('SECOND STEP')
% gait_parameters = gait_parameters_step1;
gait_parameters_PreviousStep = gait_parameters_step1;
gait_parameters_CurrentStep = gait_parameters_step2;
X_final = [xf_step1;yf_step1;xpf_step1;ypf_step1]; % previous step
% [t_step2,X0_step2,Xt_step2] = robot_step_EssModel_t(X_final); % "robot" and "gait_parameters" structures are needed inside
[t_step2,X0_step2,Xt_step2] = robot_TwoDiffSteps_EssModel_LIP(X_final,gait_parameters_CurrentStep,gait_parameters_PreviousStep); % "robot" structures are needed inside
% % Initial states (current step) after impact
% x0_step2 = X0_step2(1);
% y0_step2 = X0_step2(2);
% xp0_step2 = X0_step2(3);
% yp0_step2 = X0_step2(4);
% % Final states (current step) after impact
% xf_step2 = Xt_step2(end,1);
% yf_step2 = Xt_step2(end,2);
% xpf_step2 = Xt_step2(end,3);
% ypf_step2 = Xt_step2(end,4);
% fprintf('Initial states Step {k+1} = [%f,%f,%f,%f]\n',x0_step2,y0_step2,xp0_step2,yp0_step2)
% fprintf('Final states Step {k+1} = [%f,%f,%f,%f]\n',xf_step2,yf_step2,xpf_step2,ypf_step2)
gait_parameters_step2 = gait_parameters;



global noLanding errorLanding
if (isempty(noLanding) || noLanding==0)    % if there was impact    
    % Xt -> It is the solution, i.e. X(t) = [x(t),y(t),xp(t),yp(t)], each COLUMN is one state
    xf = Xt_step2(end,1);
    yf = Xt_step2(end,2);
    xpf = Xt_step2(end,3);
    ypf = Xt_step2(end,4);
    Tk = t_step2(end); % Elapsed time to produce the impact
    
    % Function we want to find its roots
    %fac = scale;  % The factor is to give more enfasis to the selected error
%     Func = [xfProp - xf, yfProp - yf, xpfProp - xpf, ypfProp - ypf, fac*(T - Tk)];
    Func = [xfProp - xf, yfProp - yf, xpfProp - xpf, ypfProp - ypf];
    
    fprintf('Desired time step T = %f. Real time Step at cycle %d, Tk = %f\n',T,contA,Tk)
    fprintf('Proposed final values for the CoM states are: \n  [xf(k-1), yf(k-1), xpf(k-1), ypf(k-1)] = [%f,%f,%f,%f]\n',xfProp,yfProp,xpfProp,ypfProp)
    fprintf('The final values for the CoM states at 1st Step are: \n      [x(T)(k+1), y(T)(k), xp(T)(k), yp(T)(k)] = [%f,%f,%f,%f]\n',xf_step1,yf_step1,xpf_step1,ypf_step1)
%     fprintf('After impact the values for the CoM states are: \n[x0(k+1), y0(k+1), xp0(k+1), yp0(k+1)] = [%f,%f,%f,%f]\n',x0, y0, xp0, yp0)
    fprintf('The final values for the CoM states at 2nd Step are: \n[x(T)(k+1), y(T)(k+1), xp(T)(k+1), yp(T)(k+1)] = [%f,%f,%f,%f]\n',xf,yf,xpf,ypf)
    fprintf('Function "[xf(k) - xf(k+1),yf(k) - yf(k+1), xpf(k) - xpf(k+1),ypf(k) - ypf(k+1)]"\n         = [%e,%e,%e,%e]\n',Func)
    errorLanding(contA) = 0;    
else % if there was no impact
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
    errorLanding(contA) = 1;
end
disp('---------------------------------------------------------------------------------------------------------')
disp('')


% Storing variables
% ----------------
global Rtotal FixPoint
% "errorLanding" is stored above
FixPoint(:,contA) = Func';
Rtotal(:,contA) = R';
% ----------------

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

