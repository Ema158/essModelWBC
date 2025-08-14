function J = Optim_ObjectiveFunctionGeneral(R)

global robot gait_parameters

% ==============================================================================================
global contA % To count the number of cycles performed
Hour = datestr(now,13); % Now ->Read the current hour and date, 13 -> store just the hour, -1 -> default...
fprintf('\n-------------- OBJECTIVE FUNCTION FILE -------------------\n')
fprintf([Hour ' -> Cycle k = %d (of 700 maximum) for the EssentialModel \n'],contA);
% ==============================================================================================
disp('Performing one step of the robot');
% -----------------------------------------------   

global scale
Dx = R(1)/scale; % Proposed displacement in X
Dy = R(2)/scale; % Proposed displacement in Y
xpf = R(3); % Proposed final velocity in X
ypf = R(4); % Proposed final velocity in Y

global optimParam
i = 5; % Starts in 5 since the first 4 parameters are always the same i.e. Dx, Dy, xfp, yfp.
paramMessage = '';
if optimParam(1)
    gait_parameters.z_i = R(i);  %z0
    paramMessage = [paramMessage 'z0, '];
    i = i + 1;
end
if optimParam(2)
    gait_parameters.a_z = R(i);  
    paramMessage = [paramMessage 'a_z, '];
    i = i + 1;
end
if optimParam(3)    
    gait_parameters.T = R(i);  
    paramMessage = [paramMessage 'T, '];
    i = i + 1;
end
if optimParam(4)
    S = R(i);      
    gait_parameters.Step_length = 2*S;
    gait_parameters.x_ffoot_i = -S;
    paramMessage = [paramMessage 'S, '];
    i = i + 1;
end
if optimParam(5)
    D = R(i);      
    gait_parameters.y_ffoot_i = D;     
    paramMessage = [paramMessage 'D, '];
    i = i + 1;
end
if optimParam(6)
    gait_parameters.H_ffoot = R(i);
    paramMessage = [paramMessage 'H_ffoot, '];
    i = i + 1;
end
if optimParam(7)
    gait_parameters.ZMPxIni = R(i); 
    paramMessage = [paramMessage 'ZMPxIni, '];
    i = i + 1;
end
if optimParam(8)
    gait_parameters.ZMPxEnd = R(i);      
    paramMessage = [paramMessage 'ZMPxEnd, '];
    i = i + 1;
end
if optimParam(9)
    gait_parameters.ZMPyIni = R(i);   
    paramMessage = [paramMessage 'ZMPyIni, '];
    i = i + 1;
end
if optimParam(10)
    gait_parameters.ZMPyEnd = R(i); 
    paramMessage = [paramMessage 'ZMPyEnd, '];
    i = i + 1;
end
if optimParam(11)
    Hip_Yaw = R(i);      
    gait_parameters.Hip_Yaw_i = Hip_Yaw;      
    gait_parameters.Hip_Yaw_f = -Hip_Yaw;      
    paramMessage = [paramMessage 'Hip_Yaw, '];
    i = i + 1;
end
if optimParam(12)
    gait_parameters.Pitch_torso_i = R(i);     
    paramMessage = [paramMessage 'Pitch_torso_i, '];
    i = i + 1;
end
if optimParam(13)
    gait_parameters.Pitch_torso_f = R(i);     
    paramMessage = [paramMessage 'Pitch_torso_f, '];
    i = i + 1;
end
if optimParam(14)
    Hip_Roll = R(i);      
    gait_parameters.Hip_Roll_i = Hip_Roll;      
    gait_parameters.Hip_Roll_f = -Hip_Roll;
    paramMessage = [paramMessage 'Hip_Roll, '];
    i = i + 1;
end
if optimParam(15)
    Yaw_torso_neck = R(i); 
    gait_parameters.Yaw_torso_i = Yaw_torso_neck;
    gait_parameters.Yaw_torso_inc = -2*Yaw_torso_neck;    
    gait_parameters.Neck_Yaw_i = -Yaw_torso_neck;
    gait_parameters.Neck_Yaw_f = Yaw_torso_neck;
    paramMessage = [paramMessage 'Yaw_torso_neck, '];
    i = i + 1;
end
if optimParam(16)
    Shoulder_Pitch_i = R(i);   
    gait_parameters.RShoulder_Pitch_i = Shoulder_Pitch_i;
    gait_parameters.LShoulder_Pitch_f = Shoulder_Pitch_i;
    paramMessage = [paramMessage 'Shoulder_Pitch_i, '];
    i = i + 1;
end
if optimParam(17)
    Shoulder_Pitch_f = R(i); 
    gait_parameters.RShoulder_Pitch_f = Shoulder_Pitch_f;
    gait_parameters.LShoulder_Pitch_i = Shoulder_Pitch_f; 
    paramMessage = [paramMessage 'Shoulder_Pitch_f, '];
    i = i + 1;
end
if optimParam(18)
    Shoulder_Yaw_i = R(i);   
    gait_parameters.RShoulder_Yaw_i = Shoulder_Yaw_i;   
    gait_parameters.LShoulder_Yaw_i = -Shoulder_Yaw_i; 
    paramMessage = [paramMessage 'Shoulder_Yaw_i, '];
    i = i + 1;
end
if optimParam(19)
    Shoulder_Yaw_f = R(i);   
    gait_parameters.RShoulder_Yaw_f = Shoulder_Yaw_f;   
    gait_parameters.LShoulder_Yaw_f = -Shoulder_Yaw_f;   
    paramMessage = [paramMessage 'Shoulder_Yaw_f, '];
    i = i + 1;
end
if optimParam(20)
    Elbow_Roll_i = R(i);
    gait_parameters.RElbow_Roll_i = Elbow_Roll_i; 
    gait_parameters.LElbow_Roll_i = -Elbow_Roll_i;
    paramMessage = [paramMessage 'Elbow_Roll_i, '];
    i = i + 1;
end
if optimParam(21)
    Elbow_Roll_f = R(i);     
    gait_parameters.RElbow_Roll_f = Elbow_Roll_f;     
    gait_parameters.LElbow_Roll_f = -Elbow_Roll_f;
    paramMessage = [paramMessage 'Elbow_Roll_f, '];
    i = i + 1;
end
if optimParam(22)
    Elbow_Yaw_i = R(i);      
    gait_parameters.RElbow_Yaw_i = Elbow_Yaw_i;      
    gait_parameters.LElbow_Yaw_i = -Elbow_Yaw_i;      
    paramMessage = [paramMessage 'Elbow_Yaw_i, '];
    i = i + 1;
end
if optimParam(23)
    Elbow_Yaw_f = R(i);
    gait_parameters.RElbow_Yaw_f = Elbow_Yaw_f;      
    gait_parameters.LElbow_Yaw_f = -Elbow_Yaw_f; 
    paramMessage = [paramMessage 'Elbow_Yaw_f, '];
end


fprintf('Proposed fixed point values [Dx, Dy, xpf, ypf] = [%f,%f,%f,%f]\n',Dx,Dy,xpf,ypf)
if numel(R)>4
    disp(['Proposed parameters: [', paramMessage(1:end-2),'] = [', num2str(R(5:end)),']']);    
else
    disp('No parameters to be optimized');
end
fprintf('-----------------------------------------------------\n')

%% Desired ZMP
% ---------------------------------------------------------------------
% LOCAL Desired EVOLUTION of the ZMP (w.r.t. the Support foot point)
% ZMP trajectory is recomupted if at least one parameter (from 7 to 10) is used as optimized parameter
if sum(optimParam(7:10)) ~=0
    T = gait_parameters.T;
    T1 = gait_parameters.Tini;  % Time at which the ZMP will start to move (it should be >= 0)
    T2 = gait_parameters.Tend;
    ZMPxIni = gait_parameters.ZMPxIni;   % Initial desired position in X
    ZMPyIni = gait_parameters.ZMPyIni;   % Initial desired position in Y
    ZMPxEnd = gait_parameters.ZMPxEnd;   % Final desired position in X
    ZMPyEnd = gait_parameters.ZMPyEnd;   % Final desired position in Y
    % Time at which the ZMP will stop its motion (it should be <= T)
    Pos = [T1 ZMPxIni;
        T2 ZMPxEnd];
    Vel = [T1 0;
        T2 0];
    Acc = [];
    ZMPxCoeff = findPolyCoeff(Pos,Vel,Acc);
    Pos = [T1 ZMPyIni;
        0.5*T 0;
        T2 ZMPyEnd];
    ZMPyCoeff = findPolyCoeff(Pos,Vel,Acc);
    
    gait_parameters.ZMPxCoeff = ZMPxCoeff; % Coefficients for the polynomial trayectory of the ZMP in X
    gait_parameters.ZMPyCoeff = ZMPyCoeff; % Coefficients for the polynomial trayectory of the ZMP in Y
end


%% ONE STEP of the robot
S = gait_parameters.S;
D = gait_parameters.D;
xf = S/2 + Dx;
yf = D/2 + Dy;

X_final = [xf;yf;xpf;ypf]; % previous step
[t,X0,Xt] = robot_step_EssModel_t(X_final); % "robot" and "gait_parameters" structures are needed inside
% Initial states (current step) after impact
x0 = X0(1);
y0 = X0(2);
xp0 = X0(3);
yp0 = X0(4);
% Final states (current step) after impact
xfNew = Xt(end,1);
yfNew = Xt(end,2);
xpfNew = Xt(end,3);
ypfNew = Xt(end,4);
fprintf('Final states Step {k-1} = [%f,%f,%f,%f]\n',xf,yf,xpf,ypf)
fprintf('Initial states Step {k} = [%f,%f,%f,%f]\n',x0,y0,xp0,yp0)
fprintf('Final states Step {k} = [%f,%f,%f,%f]\n',xfNew,yfNew,xpfNew,ypfNew)

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
global NonLinearIneqCons NonLinearEqCons
global FixPoint
if ~ERROR    % IF THERE IS NO ERROR... the code continues....
    %% Sampling
    errorMessage = '';
    samples = 15; % number of asmples
    DateVecOld = datevec(Hour);
    Hour = datestr(now,13);
    disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
    disp([Hour ' -> Sampling of the CoM trajectory. Number of samples: ',num2str(samples)]);
    t_f = t(end); % This should be equal to T, but when the step is not finished it change
    dt = t_f/(samples-1);
    t_S = 0:dt:t_f;
    X_S = interp1(t,Xt,t_S,'linear','extrap');
    
    %% Torque, force and ZMP computation
    % -----------------------------------------------
    DateVecOld = datevec(Hour);
    Hour = datestr(now,13);
    disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
    disp([Hour ' -> Computing evolution of joint positions velocities and acceleration based on the CoM position and velocity']);
    [q_S,qD_S,qDD_S] = joints_fromCoMpos_Vel_HZDtime(robot,X_S,gait_parameters,t_S);
    % ------------------------------------------------
    
    % samples = size(t,1);
    % % Torque, force and ZMP computation
    % -----------------------------------------------
    DateVecOld = datevec(Hour);
    Hour = datestr(now,13);
    disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
    disp([Hour ' -> Computation of torques, forces and ZMP based on "q", "qp" and "qpp" ...']);
    % ------------------------------------------------
    ZMP_S = zeros(2,samples);
    F_S = zeros(3,samples);
    M_S = zeros(3,samples);
    Tau_S = zeros(robot.joints,samples);
    
    for i = 1:samples
        % "Newton_Euler.m" Algorithm
        [F_S(:,i ),M_S(:,i ),Tau_S(:,i )]= Newton_Euler(q_S(:,i),qD_S(:,i),qDD_S(:,i));
        ZMP_S(1,i) = -M_S(2,i)/F_S(3,i);
        ZMP_S(2,i) =  M_S(1,i)/F_S(3,i);
    end
    
    %% CONSTRAINTS
    % NonLinearIneqCons - > Nonlinear inequality constraints
    % NonLinearEqCons - > Nonlinear equality constraints
    
    % Equality constraints
    % -----------------------
    NonLinearEqCons = [xfNew - xf, yfNew - yf, xpfNew - xpf, ypfNew - ypf];
    
    % Inequality constraints
    % -----------------------
    limTau = gait_parameters.limTau;
    limVel = gait_parameters.limVel;
    % limPosMin = gait_parameters.limPosMin;
    % limPosMax = gait_parameters.limPosMax;
    % Now we have the torques we compute the constraints
    consTorquePos = zeros(1,22);
    consVelPos = zeros(1,22);
    consTorqueNeg = zeros(1,22);
    consVelNeg = zeros(1,22);
    for i = 1:22
        %     consVel(i) = max(abs(qD_S(i,:))) - limVel(i);
        %     consTorque(i) = max(abs(Tau_S(i,:))) - limTau(i);
        consVelPos(i) = max(qD_S(i,:)) - limVel(i);
        consTorquePos(i) = max(Tau_S(i,:)) - limTau(i);
        consVelNeg(i) = -min(qD_S(i,:)) - limVel(i);
        consTorqueNeg(i) = -min(Tau_S(i,:)) - limTau(i);
    end
    % These constraints are used in "NonLinearIneqCons" variable
    consVel = [consVelPos consVelNeg];
    consTorque = [consTorquePos consTorqueNeg];        
    
    
    %% Objective function    
    J = 0;
    % JUST TAKING INTO ACCOUNT THE TORQUE PRODUCED BY THE LOWER PART OF THE BODY
    for j =1:12 % triangular integral i.e. (sample_1 + sample_2)/2 * dt + (sample_2 + sample_3)/2 * dt + .... (sample_n-1 + sample_n)/2 * dt +
        %                       or (sample1/2 + sample_2 + sample_3 + ... sample_n-1 + sample_n/2) * dt
        if j == 3
            kTor = 50;  % 1000.. to increase the importance of tau 3        
        elseif  j == 10
            kTor = 1;  % 1000.. to increase the importance of tau 10
        else
            kTor = 1;       
        end
        for i = 1:samples
            if (i==1) || (i==samples)
                J = J + kTor*((Tau_S(j,i)/limTau(j))^2)/2;
            else
                J = J + kTor*(Tau_S(j,i)/limTau(j))^2;
            end
        end
    end
    J = (1/S)*J*dt;        
       
else
    disp([errorMessage,' Integration stopped because the robot configuration is unaccesible (Check PEvents_HDZtime.m)']);
    disp('--------------------------------------------------------------------------------------------');    
    % Assigning BAD Values for the constraints
    consVel = ones(1,22*2);
    consTorque = ones(1,22*2);
    if contA>1
        NonLinearEqCons = 10*FixPoint(:,contA-1)'; % We asigne the same error as the previous step but multiplied by some gain
    else
        NonLinearEqCons =  ones(1,4); % If it is at the first step we assign just ones.
    end
    J = 1e4; % Big value for the cost function
    disp('NO COMPUTATION OF TORQUES was performed. A high value for cost function was defined....');    
    disp('--------------------------------------------------------------------------------------------');    
end
% Nonlinear inequality constraints:
NonLinearIneqCons = [consVel consTorque];

Gain = 1e5; %10,000
%Gain = 1e4; %10,000
Jtorque = J;
JfixPoint = Gain*(NonLinearEqCons*NonLinearEqCons');
% FUNCTION TO MINIMIZE:
% ----------------------------------------------
%J = Jtorque + JfixPoint;% + Gain*(t_f-T)^2; %Para que no se optimicen los torques se comento esto
J = JfixPoint;
disp('-------------------------------------')
fprintf([errorMessage,'Objective function J = %f\n'],J);
disp('-------------------------------------')
disp('')

%% Storing variables
% ----------------------------------
global ObjecFunc torqueObjFunc FixPointObjFunc
global TorqueCons VelocityCons Rtotal
torqueObjFunc(contA) = Jtorque;
FixPointObjFunc(contA) = JfixPoint;
ObjecFunc(contA) = J;
FixPoint(:,contA) = NonLinearEqCons';
TorqueCons(:,contA) = consTorque';
VelocityCons(:,contA) = consVel';
Rtotal(:,contA)  = [R(1)/scale, R(2)/scale, R(3:end)];


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

