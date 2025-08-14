
function [t_gait,Xt_gait,t_SS,Xt_SS,t_DS,Xt_DS,t_DS_final,Xt_DS_final,t_gait_SS,Xt_gait_SS,t_gait_DS,Xt_gait_DS,gait_parameters_SS,gait_parameters_DS,gait_parameters_DS_final,gait_parameters_gait_SS_Step1,gait_parameters_gait_DS_Step1,gait_parameters_gait_SS_Step2,gait_parameters_gait_DS_Step2] = robot_step_EssModel_Start_DS_SS_DS_gait_t_TwoSteps_SS_DS(gait_parameters_SS,gait_parameters_DS,gait_parameters_DS_final,gait_parameters_gait_SS_Step1,gait_parameters_gait_DS_Step1,gait_parameters_gait_SS_Step2,gait_parameters_gait_DS_Step2,N);

% ==============================================================================================
% Options
% ----------------------------------------------------------------------------------------------
% NOTE The number of iterations performed by the solver are counted by "contB". This is used to stop the solver if the
% robot doesn't perform a step after a determinated number of iterations (this is done in "PEventsHZDtime")
global contB 
contB =  1;            % To count the number of iterations performed by the PEvents file (recommended)
% global DisplayIterNumber % To show how many iteration have been performed by the solver 
% DisplayIterNumber = []; % To DISPLAY the information of the number of iteration performed by the solver.. Empty-> Not display anything
% ==============================================================================================
global contD OutOfWorkSpace
contD = []; % Every time the robot is out of the workspace and "PEvents" is called, 'contD' is used to stop de integration 
OutOfWorkSpace = []; % Reset workspace flag

global robot gait_parameters
%% DS phase
% ==========================================================
gait_parameters = gait_parameters_DS;
T = gait_parameters.T;
D = gait_parameters.D;
disp('DS phase')
disp('--------------------------')
% Initial states
x0 = 0;
y0 = D/2;
xp0 = 0;
yp0 = 0;
X0_DS = [x0,y0,xp0,yp0];

% Double Support (SS) Phase
options = odeset('Events', @PEvents_HDZtimeDS,'RelTol', 1.e-7, 'AbsTol', 1.e-9);
[t_DS,Xt_DS] = ode45(@dynam_HZDtime,0:1e-3:T,X0_DS,options);

xf_DS = Xt_DS(end,1);
yf_DS = Xt_DS(end,2);
xpf_DS = Xt_DS(end,3);
ypf_DS = Xt_DS(end,4);


%% Single Support (SS) Phase
gait_parameters = gait_parameters_SS;
T = gait_parameters.T;
% Restart iteration counter
contB = 1;
disp('SS phase')
disp('--------------------------')
% Initial states for SS phase
x0 = xf_DS;
y0 = yf_DS;
xp0 = xpf_DS;
yp0 = ypf_DS;
X0_SS = [x0,y0,xp0,yp0];
% In PEventsDS the high of the foot is not checked.. but since the gait is defined by a constant desired time T, that
% condition is not SO important
options = odeset('Events', @PEvents_HDZtimeDS,'RelTol', 1.e-7, 'AbsTol', 1.e-9);
[t_SS,Xt_SS] = ode45(@dynam_HZDtime,0:1e-3:T,X0_SS,options);

xf_SS = Xt_SS(end,1);
yf_SS = Xt_SS(end,2);
xpf_SS = Xt_SS(end,3);
ypf_SS = Xt_SS(end,4);

%% DS final phase
% ==========================================================

gait_parameters = gait_parameters_DS_final;
T = gait_parameters.T;
D = gait_parameters.D;
disp('DS phase (final)')
disp('--------------------------')
% Initial states for SS phase
x0 = xf_SS;
y0 = yf_SS;
xp0 = xpf_SS;
yp0 = ypf_SS;
X0_DS_final = [x0,y0,xp0,yp0];

% Double Support (SS) Phase
options = odeset('Events', @PEvents_HDZtimeDS,'RelTol', 1.e-7, 'AbsTol', 1.e-9);
[t_DS_final,Xt_DS_final] = ode45(@dynam_HZDtime,0:1e-3:T,X0_DS_final,options);


xf_DS_final = Xt_DS_final(end,1);
yf_DS_final = Xt_DS_final(end,2);
xpf_DS_final = Xt_DS_final(end,3);
ypf_DS_final = Xt_DS_final(end,4);


% figure(5)
% robot_draw(robot,0,0)             % Supported on the right foot
% view(3) % to assigne a "standard" view in 3D
% axis equal 
%%  Gait phase
% ================================================================
gait_parameters = gait_parameters_gait_SS_Step1;
T = gait_parameters.T;
D = gait_parameters.D;
S = gait_parameters.S;
g=9.81;
z0 = gait_parameters.z_i;
disp('Gait phase')
disp('--------------------------')
% Initial states for SS phase
xf = xf_DS_final;
yf = yf_DS_final;
xpf = xpf_DS_final;
ypf = ypf_DS_final ;


% Double Support (SS) Phase
SupportFootX = 0;
SupportFootY = 0;
ZMPd = cell(1,N+1);
%% Continue...
% omega = sqrt(g/z0); % the units are:  sqrt((m/s^2)/m) = 1/s
% ZMPxCoeff = gait_parameters.ZMPxCoeff;
% ZMPyCoeff = gait_parameters.ZMPyCoeff;
t_gait = cell(1,N);
Xt_gait = cell(1,N); 
t_gait_SS = cell(1,N);
Xt_gait_SS = cell(1,N); 
t_gait_DS = cell(1,N);
Xt_gait_DS = cell(1,N); 
Ex = cell(1,N); 
Ey = cell(1,N); 
L = cell(1,N);
zt = cell(1,N);
zpt = cell(1,N);
SupportFoot = cell(1,N);
for j=1:N    
    SupportFoot{j} = [SupportFootX,SupportFootY];
    
    if mod(j,2)==1
        gait_parameters = gait_parameters_gait_SS_Step1;
        gait_parameters_PreviousStep = gait_parameters_gait_DS_Step2;
        gait_parameters_SS_CurrentStep = gait_parameters_gait_SS_Step1;
        gait_parameters_DS_CurrentStep = gait_parameters_gait_DS_Step1;
    else
        gait_parameters = gait_parameters_gait_SS_Step2;
        gait_parameters_PreviousStep = gait_parameters_gait_DS_Step1;
        gait_parameters_SS_CurrentStep = gait_parameters_gait_SS_Step2;
        gait_parameters_DS_CurrentStep = gait_parameters_gait_DS_Step2;
    end
    T = gait_parameters.T;
    g = gait_parameters.g;
    z0 = gait_parameters.z_i;
    S = gait_parameters.S;
    D = gait_parameters.D;
    wide_error = gait_parameters.wide_error;
    omega = sqrt(g/z0); % the units are:  sqrt((m/s^2)/m) = 1/s
    ZMPxCoeff = gait_parameters.ZMPxCoeff;
    ZMPyCoeff = gait_parameters.ZMPyCoeff;

    % ====================================================================
    % Computation of one step of the robot: 
    % Previous states before impact -> the Impact and Rellabelling -> Evolution of one step -> states before impact
    % ====================================================================
    X_final = [xf;yf;xpf;ypf]; % previous step
%     [t{j},X0,Xt{j}] = robot_step_EssModel_t(X_final); % "robot" and "gait_parameters" structures are needed inside
    [t_gait{j},X0,Xt_gait{j},t_gait_SS{j},Xt_gait_SS{j},t_gait_DS{j},Xt_gait_DS{j}] = robot_TwoDiffSteps_SS_DS_EssModel_t(X_final,gait_parameters_SS_CurrentStep,gait_parameters_DS_CurrentStep,gait_parameters_PreviousStep); % "robot" structures are needed inside
    % Initial (current step) after impact
    x0 = X0(1); 
    y0 = X0(2);
    xp0 = X0(3);
    yp0 = X0(4);
    % Final states:
    xt = Xt_gait{j}(:,1);   % Solution of position in X of the CoM for step j
    yt = Xt_gait{j}(:,2);   % Solution of position in Y of the CoM for step j
    xpt = Xt_gait{j}(:,3);  % Solution of velocity in X of the CoM for step j
    ypt = Xt_gait{j}(:,4);  % Solution of velocity in Y of the CoM for step j
    % -----------------------------------------------------------------------------------------------------------------
%     if mod(j,2)==1
%         gait_parameters_gait_SS_Step1 = gait_parameters;
%     else
%         gait_parameters_gait_SS_Step2 = gait_parameters;
%     end
    
    % IMPORTANT: IN THIS PART of the CODE IS JUST FOR VISUALIZATION for the trajectory of the Desired ZMP.
    %            The REAL evolution of the ZMP will be obtained by runing code "M20_..." =)
    % Evolution of the ZMP 
    samples = length(t_gait{j});
    ZMPdX = zeros(1,samples);
    ZMPdY = zeros(1,samples);
    samples1 = length(t_gait_SS{j});
    samples2 = length(t_gait_DS{j});
    for i=1:samples1
        ZMPdX(i) = polyval(gait_parameters_SS_CurrentStep.ZMPxCoeff,t_gait_SS{j}(i));
        zt{j}(i) = polyval(gait_parameters_SS_CurrentStep.PolyCoeff.hd1,t_gait_SS{j}(i));
        zpt{j}(i) = polyval(polyder(gait_parameters_SS_CurrentStep.PolyCoeff.hd1),t_gait_SS{j}(i));
        if mod(j,2) % If j is impair (for pair steps the evoluition is the opossite direction)
            ZMPdY(i) = polyval(gait_parameters_SS_CurrentStep.ZMPyCoeff,t_gait_SS{j}(i));
        else % pair step
            ZMPdY(i) = -polyval(gait_parameters_SS_CurrentStep.ZMPyCoeff,t_gait_SS{j}(i));
        end
    end 
    for i=1:samples2
        ZMPdX(samples1 + i) = polyval(gait_parameters_DS_CurrentStep.ZMPxCoeff,t_gait_DS{j}(i));
        zt{j}(samples1 + i) = polyval(gait_parameters_DS_CurrentStep.PolyCoeff.hd1,t_gait_DS{j}(i));
        zpt{j}(samples1 + i) = polyval(polyder(gait_parameters_DS_CurrentStep.PolyCoeff.hd1),t_gait_DS{j}(i));
        if mod(j,2) % If j is impair (for pair steps the evoluition is the opossite direction)
            ZMPdY(samples1 + i) = polyval(gait_parameters_DS_CurrentStep.ZMPyCoeff,t_gait_DS{j}(i));
        else % pair step
            ZMPdY(samples1 + i) = -polyval(gait_parameters_DS_CurrentStep.ZMPyCoeff,t_gait_DS{j}(i));
        end
    end   
    ZMPd{j}(1,:) = SupportFootX + ZMPdX;
    ZMPd{j}(2,:) = SupportFootY + ZMPdY;
    % ========================================================
    
    % Orbital energy % It's always measured in the LOCAL frame (this is just for the LIP but it helps to see if the step is periodic)
    % --------------------------------------------
    Ex{j} = -(g/(2*z0)).*xt.^2 + (1/2).*xpt.^2; % Orbital energy in X
    Ey{j} = -(g/(2*z0)).*yt.^2 + (1/2).*ypt.^2; % Orbital energy in Y
    
    % Synchonization measure (this is just for the LIP but it helps to see if the step is periodic)
    % --------------------------------------------    
    L{j} = xpt.*ypt - omega^2*xt.*yt;
    
    % Final states:
    xf = xt(end);    % Final position in X of the CoM for step j
    yf = yt(end);    % Final position in Y of the CoM for step j
    xpf = xpt(end);  % Final velocity in X of the CoM for step j
    ypf = ypt(end);  % Final velocity in Y of the CoM for step j
    
    % Display information
    % ----------------------------------------------------    
    fprintf('Step %d of %d\n',j,N);   
    fprintf('Initial ZMP position in X: %0.3f\n',ZMPd{j}(1,1));
    fprintf('Initial ZMP position in Y: %0.3f\n',ZMPd{j}(2,1));
    fprintf('Final ZMP position in X: %0.3f\n',ZMPd{j}(1,end));
    fprintf('Final ZMP position in Y: %0.3f\n',ZMPd{j}(2,end));
    fprintf('Initial states: [x0 y0 xp0 yp0] = [%f,%f,%f,%f]\n',x0,y0,xp0,yp0);
    fprintf('Final states: [xf yf xpf ypf] = [%f,%f,%f,%f]\n',xf,yf,xpf,ypf);
    disp('-------------------------------------------');
    % Initial conditions for the Next step
    %-------------------------                    
    SupportFootX = SupportFootX + S;
    if mod(j,2) % If j is impair (for pair steps we add distance D)
        SupportFootY = SupportFootY + D + wide_error;
    else
        SupportFootY = SupportFootY - D - wide_error; % We come back to the original position
    end
    contB = 1; % Reinitializing the counter of the solver
end

%% Reinitialization if needed...
% Computing of the joints velocities and positions at the end of the step
if ~isempty(OutOfWorkSpace) % If the CoM of the robot is always inside the workspace of the robot....    
    disp('Robot configuration is OUT OF WORKSAPCE at the end of the step in "robot_step...m". Robot configuration RE-Initialized')
    robot = genebot();     
end 

global noLanding
if ~(isempty(noLanding) || noLanding==0) % if there was no impact
    disp('Robot configuration is INACCESSIBLE in "robot_step...m". Robot configuration RE-Initialized')
    robot = genebot();  
end

