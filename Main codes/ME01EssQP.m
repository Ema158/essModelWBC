close all;
clear all;
clc
% ---------------------------------------------------------------------------------------------
currentfolder = pwd; % save current path
cd ..                % go one folder down (go out of the current folder and stay in the previous one)
add_paths;           % add all folders where all files are founded in order to acces to them
cd(currentfolder);   % return to the original path
% ---------------------------------------------------------------------------------------------

echo on
% Testing Essential dynamics
% ==============================
% Creation: 20/mar/2018
% Last modification: -/--/--
% --------------------------------------------------------------------------------------------------
% Walking of a Essential model with FIX step lenght S, Fix step width D, fix time step T  and considering IMPACT
% -----------------------------------------------------------------------------------------------------
% This code is based on "M04b_EssentialModelImpactZMPvar_t." 
% The difference is that in here the same file for compute the Coefficients for the polyynmomials to build the desired
% trajectories of the controlled variables is used for the desired values without impact and with impact.
% Also a trajectory for the twist the upper torso is builded.
% No periodic motion was intented to found for the inclusion of the upper body motion since it doesn't affect so much.
% So the same periodic motion founded for time with impact was used
% --------------------------------------------------------------------------------------------------
% 
%
echo off

global gait_parameters
global robot coms
coms=1;

% Parameters
% ---------------------------------------------------------
% Nao_param = ParamEssPeriodic();
Nao_param = ParamQP();
% ---------------------------------------------------------
gait_parameters = Nao_param.gait_parameters;
T = gait_parameters.T;
g = gait_parameters.g;
z0 = gait_parameters.z_i;
S = gait_parameters.S;
D = gait_parameters.y_ffoot_i;

% CHOSING CONTROLLED VARIABLE FILES
% -------------------------------------------------------------------------------------------------
global OptionContVar  % Option to chose the controlled variables "hd", "hpd" and "hppd"
% 1 -> Controlled variables defined by polynomials w.r.t. time, IMPACT is considered. Files: "hd_Polyn", "hpd_Polyn_t" and "hppd_Polyn_t". 
% 2 -> Controlled variables defined by cycloidal motion w.r.t. time, IMPACT is NOT considered. Files: "hd_CycMotion_t", "hpd_CycMotion_t" and "hppd_CycMotion_t". 
% 3 -> Controlled variables defined by polynomials w.r.t. "x" of the CoM, IMPACT is considered. Files: "hd_Polyn", "hpd_Polyn_x" and "hppd_Polyn_x". 
OptionContVar = Nao_param.ControlledVariableOption;
% -------------------------------------------------------------------------------------------------

% GENERAL OPTIONS
% ----------------------------------------------------
DataName = 'InfoNAO_Param_t_10prueba3';
Animation = true;  % Do you want to show the animation?
n = 8; % number of SAMPLES for each step of the animation
LineWidth = 2;  % For plots and animation
FontSize = 14;  % For plots and animation 
produceVideo = true;   % Do you want to produce a video? (if animation if false no video will be produced)
framerate = (n/T)/3; % with n/T the real time duration of the video will be T, the last divition will produce
                    %  a duration of video "factor*T". For example if T=0.5, " (n/T)/3" will produce a video of 1.5 sec 
% ----------------------------------------------------
N = 1; % number of steps
% Initial support for the first step
SupportFootX = 0;
SupportFootY = 0;
ZMPd = cell(1,N+1);

% Final conditions for the step 0
% Cyclic motions:
% -------------------------------------------------------------------------------------------------------------------
Rcyc = Nao_param.Rcyc;

% If NO error in the velocity is desired, chose "Error = 0"
Error = 0.0; % Percentage of error   <-------
if Error ~= 0
    fprintf('Motion started OUTSIDE the periodic motion, with an error in velocity of %.2f %%\n',Error*100)
    disp('-----------------------------------------------------------------------------------')
end
% ----------------------------------
Dx = Rcyc(1);
Dy = Rcyc(2);
Dz = Rcyc(3);
xpf = Rcyc(4)*(1+Error);
ypf = Rcyc(5)*(1+Error);
zpf = Rcyc(6)*(1+Error);
% Initial and final position is computed as 
% x0 = -S/2 + Dx;
% y0 = D/2 - Dy;
xf = S/2 + Dx;
yf = D/2 + Dy;
zf = z0 + Dz;
% Display information
% ----------------------------------------------------
disp('Information for each step');
disp('==========================');
fprintf('Step length S: %d\n',S);
fprintf('Step width D: %d\n',D);
fprintf('Step time T: %d\n',T);
disp('-------------------------------------------');

%% Parameteres and initialization of ROMEO
% ======================================================================================
global alphaM % alphaM = [0-1]. Allow to remove gradually the value of all masses and inertias of the robot
% alphaM = 0 -> all masses are 0 -> all mass is concentrated in one point
% alphaM = 1 -> all masses are normal -> all masses are distributed
alphaM = 1;
if alphaM == 0
    fprintf('All mass concentred in ONE point (as a 3DLIP), i.e. alphaM = %f\n',alphaM)
elseif alphaM == 1
    fprintf('All masses distributed (as it should be), i.e. alphaM = %f\n',alphaM)
else
    fprintf('Masses distributed taking into account alphaM = %f . If alphaM -> 0 all masses will be concentred in ONE point\n',alphaM)
end
% ------------------------------------------------------------------------------------

% Generating the robot structure
robot = genebot();
% Computation of the initial coefficients the polinomial trajectories for the controlled variables. 
% These coefficients are changed inmediately after the transition (really necessary when there is an impact)
gait_parameters.transition = false; 
PolyCoeff = Coeff_DesiredTrajectories_t_ver2(robot,gait_parameters);
gait_parameters.PolyCoeff = PolyCoeff;

% OPTION - For plotting of the evolution of the CoM in "PEvents.m" file (while the solver is working on the dynamics)
% ===========================================================================================================
% % If we do not want to plot anything we can uncomment these lines:
% global contC  
% global Stop   % 1-> If we want to pause the simulationn each time "PEvents" is executed
% contC = 1;    % It is used to create a vector that stores all the point of the CoM each time "PEvents" is executed
% Stop = 0;     % 1-> Each time  "PEvents" is executed the simulation will stop and it will wait until you press a key to continue
% % NOTE If we want that the solver shows who many iterations have been performed we must define "contB"
global DisplayIterNumber  % To show how many iteration have been performed by the solver 
DisplayIterNumber = 1;
% global contA  % To create one figure each time a cycle is carried out (this variable is more useful be inside "Cycle" function)
% contA = 1;
% % ====================================================================

%% Continue...
omega = sqrt(g/z0); % the units are:  sqrt((m/s^2)/m) = 1/s
ZMPxCoeff = gait_parameters.ZMPxCoeff;
ZMPyCoeff = gait_parameters.ZMPyCoeff;
t = cell(1,N);
Xt = cell(1,N); 
Ex = cell(1,N); 
Ey = cell(1,N); 
L = cell(1,N);
zt = cell(1,N);
zpt = cell(1,N);
SupportFoot = cell(1,N);
fprintf('Initial states final states of the CoM: \n[xf yf xpf ypf] = [%f,%f,%f,%f]\n',xf,yf,xpf,ypf);
disp('-------------------------------------------');
for j=1:N    
    SupportFoot{j} = [SupportFootX,SupportFootY];
    
    % ====================================================================
    % Computation of one step of the robot: 
    % Previous states before impact -> the Impact and Rellabelling -> Evolution of one step -> states before impact
    % ====================================================================
    X_final = [xf;yf;zf;xpf;ypf;zpf]; % previous step
    [t{j},X0,Xt{j}] = robot_step_EssModel_t(X_final); % "robot" and "gait_parameters" structures are needed inside
    % Initial (current step) after impact
    x0 = X0(1); 
    y0 = X0(2);
    z0 = X0(3);
    xp0 = X0(4);
    yp0 = X0(5);
    zp0 = X0(6);
    % Final states:
    xt = Xt{j}(:,1);   % Solution of position in X of the CoM for step j
    yt = Xt{j}(:,2);   % Solution of position in Y of the CoM for step j
    zt = Xt{j}(:,3);   % Solution of position in Z of the CoM for step j
    xpt = Xt{j}(:,4);  % Solution of velocity in X of the CoM for step j
    ypt = Xt{j}(:,5);  % Solution of velocity in Y of the CoM for step j
    zpt = Xt{j}(:,6);  % Solution of velocity in Z of the CoM for step j
    % -----------------------------------------------------------------------------------------------------------------
    
    % IMPORTANT: IN THIS PART of the CODE IS JUST FOR VISUALIZATION for the trajectory of the Desired ZMP.
    %            The REAL evolution of the ZMP will be obtained by runing code "M20_..." =)
    % Evolution of the ZMP 
    samples = length(t{j});
    ZMPdX = zeros(1,samples);
    ZMPdY = zeros(1,samples);
    for i=1:samples
        ZMPdX(i) = polyval(ZMPxCoeff,t{j}(i));
        if mod(j,2) % If j is impair (for pair steps the evoluition is the opossite direction)
            ZMPdY(i) = polyval(ZMPyCoeff,t{j}(i));
        else % pair step
            ZMPdY(i) = -polyval(ZMPyCoeff,t{j}(i));
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
    fprintf('Initial states: [x0 y0 z0 xp0 yp0 zp0] = [%f,%f,%f,%f,%f,%f]\n',x0,y0,z0,xp0,yp0,zp0);
    fprintf('Final states: [xf yf zf xpf ypf zpf] = [%f,%f,%f,%f,%f,%f]\n',xf,yf,zf,xpf,ypf,zpf);
    disp('-------------------------------------------');
    % Initial conditions for the Next step
    %-------------------------                    
    SupportFootX = SupportFootX + S;
    if mod(j,2) % If j is impair (for pair steps we add distance D)
        SupportFootY = SupportFootY + D;
    else
        SupportFootY = SupportFootY - D; % We come back to the original position
    end
    contB = 1; % Reinitializing the counter of the solver
end

%% =====================================
% Plots
% =============
% States for all the trajectory
xtAll = [];
ytAll = [];
ztAll = [];
xptAll = [];
yptAll = [];
zptAll = [];
tAll = [];
ExAll = [];
EyAll = [];
LAll = [];

% Sampled states for all the trajectory
xsAll = [];
ysAll = [];
zsAll = [];
xpsAll = [];
ypsAll = [];
zpsAll = [];
tsAll = [];

% To determine the maximum and minimum value of the CoM position to determine the dimension of the animation of the plot
% ------------------------------------------------------------------------------------------------------------
for j=1:N
   maxPosJx(j) = SupportFoot{j}(1) + max(Xt{j}(:,1)); % max position in x for the step "j"
   maxPosJx(j) = max(maxPosJx(j),SupportFoot{j}(1));
   minPosJx(j) = SupportFoot{j}(1) + min(Xt{j}(:,1));
   minPosJx(j) = min(minPosJx(j),SupportFoot{j}(1));
   if mod(j,2) % if j is impair
       maxPosJy(j) = SupportFoot{j}(2) + max(Xt{j}(:,2));
       maxPosJy(j) = max(maxPosJy(j),SupportFoot{j}(2));
       minPosJy(j) = SupportFoot{j}(2) + min(Xt{j}(:,2));
       minPosJy(j) = min(minPosJy(j),SupportFoot{j}(2));
   else   % When the foot is pair, the direction of Axis Y changes, so... 
       maxPosJy(j) = SupportFoot{j}(2) - min(Xt{j}(:,2)); % the maximum value in the global frame is when we rest the minimum value of y(t)
       maxPosJy(j) = max(maxPosJy(j),SupportFoot{j}(2));
       minPosJy(j) = SupportFoot{j}(2) - max(Xt{j}(:,2)); % the minimum value in the global frame is when we rest the maximum value of y(t)
       minPosJy(j) = min(minPosJy(j),SupportFoot{j}(2));
   end   
end
maxPosX = max(maxPosJx);
minPosX = min(minPosJx);
maxPosY = max(maxPosJy) + D;
minPosY = min(minPosJy) - D;

% ------------------------------------------------------------------------------------------------------------

% Building of trajectories for all the steps and animation
% ---------------------------------------------
if Animation && produceVideo
    writerobj = VideoWriter(strcat(['ReducedModel_',DataName],'.avi'));
    writerobj.FrameRate = framerate; % The smaller FrameRate the slower the video (Frames per second)
    open(writerobj);    
    disp('Making a video...')    
end
ZMPdS = cell(1,N);
for j=1:N    
    xt = SupportFoot{j}(1) +  Xt{j}(:,1)';  % global position of x(t) for step "j"
    if mod(j,2) % If j is impair (for pair steps we add distance D and invert direction)    
        yt = SupportFoot{j}(2) + Xt{j}(:,2)'; % global position of y(t) for step "j"
        ypt = Xt{j}(:,4)';                       % global velocity yp(t) for step "j" 
    else
        yt = SupportFoot{j}(2) - Xt{j}(:,2)';  % global position of y(t) for step "j"
        ypt = -Xt{j}(:,4)';                       % global velocity yp(t) for step "j" 
    end
    xpt = Xt{j}(:,4)';                       % xp(t) for step "j"     
    tG = (j-1)*T  + t{j}';  % tG is the global time for all the steps
    
    % ===============================================================
    %     Variables for animation
    % ===============================================================
    if Animation                
        % Sampled variables
        OnesRowVectS = ones(1,n);
        Xs = sampling(Xt{j}',n); % Xs is the sampled evolution of the CoM  for step "j" in the LOCAL frame attached to the support foot
        ts = (j-1)*T  + sampling(t{j}',n);  % ts is the sampled time for all the steps
        ZMPdS{j} = sampling(ZMPd{j},n);  % ZMPdS is the sampled ZMP for each step;
        
        xs = SupportFoot{j}(1) + Xs(1,:); % Sampled position of the CoM in X for step "j" in the WORLD frame
        if mod(j,2) % If j is impair (for pair steps we add distance D and invert direction)
            ys = SupportFoot{j}(2) + Xs(2,:); % Sampled position of the CoM in Y for step "j" in the WORLD frame
        else
            ys = SupportFoot{j}(2) - Xs(2,:); % Sampled position of the CoM in Y for step "j" in the WORLD frame
        end
        xps = Xs(4,:);                      % Sampled velocity in X of the CoM for step "j"
        yps = Xs(5,:);                      % Sampled velocity in Y of the CoM for step "j"
        zs = Xs(3,:); % Xs is the sampled evolution of the CoM  for step "j" in the LOCAL frame attached to the support foot        
        zps = Xs(6,:);
        % zs = z0*OnesRowVectS;
        
        % Colors for plots % color = [R,G,B];
        % ------------------------------------
        % color = [0,0,0]; % Black
        % color = [1,0,0]; % Red
        % color = [0,1,1]; % Cyan
        % color = [1,0,1]; % Magenta
        % color = [1,1,0]; % Yellow
        % color = [0,0.8,0]; % Green
        % color = [0,0,0.9]; % Blue
        % color = [0.48,0.06,0.89]; % Purple
        % color = [0.68,0.47,0]; % Brown
        color = rand(1,3); % Random Color
        
        xsAll = [xsAll xs];
        ysAll = [ysAll ys];
        zsAll = [zsAll zs];
        CoMIniEndPos{j} = [xs(1),ys(1),zs(1),xs(end),ys(end),zs(end)];
        for i=1:n
            fig = figure (1);
            % if we want to draw all the trace of the pendulum we must put it "on"
            hold off
            plot3([ZMPdS{j}(1,i),xs(i)],[ZMPdS{j}(2,i),ys(i)],[0,zs(i)],'-ko');
            hold on
            % The next part draw the initial and final position of the pendulum for each step
            % ------------------------------------------------------------------------------------
            for k=1:j
                % Initial position
                plot3([ZMPd{k}(1,1),CoMIniEndPos{k}(1,1)],[ZMPd{k}(2,1),CoMIniEndPos{k}(1,2)],[0,CoMIniEndPos{k}(1,3)],'--o', 'color',[0.68,0.47,0]);
                % Final position
                if k~=j % It doesn't draw the final position of the pendulum until the next step
                    plot3([ZMPd{k}(1,end),CoMIniEndPos{k}(1,4)],[ZMPd{k}(2,end),CoMIniEndPos{k}(1,5)],[0,CoMIniEndPos{k}(1,6)],'--o', 'color',[0.48,0.06,0.89]);
                end
                % Trajectory of the ZMP                
                if k<j
                    plot3(ZMPdS{k}(1,:),ZMPdS{k}(2,:),0*OnesRowVectS,'LineWidth',LineWidth);
                else
                    plot3(ZMPdS{k}(1,1:i),ZMPdS{k}(2,1:i),0*(1:i),'LineWidth',LineWidth);
                end
            end
            % Trajectory of the CoM
            plot3(xsAll(1:i+(j-1)*n),ysAll(1:i+(j-1)*n),zsAll(1:i+(j-1)*n),'color',color,'LineWidth',LineWidth)
            axis([minPosX,maxPosX,minPosY,maxPosY,0,0.4]); % axis([x0,xf,y0,yf,z0,zf]);
            xlabel('x [m]','interpreter','Latex','FontSize',FontSize);
            ylabel('y [m]','interpreter','Latex','FontSize',FontSize);
            zlabel('z [m]','interpreter','Latex','FontSize',FontSize);
            title(['t = ' num2str(ts(i)) ' [sec]']);
            grid on
            if  produceVideo
                writeVideo(writerobj,getframe(fig));
            end 
            pause(0.5)
        end        
        % Sampled states for all the trajectory
        xpsAll = [xpsAll xps];
        ypsAll = [ypsAll yps];
        zpsAll = [zpsAll zps];
        tsAll = [tsAll ts];
        
    end
    % ===============================================================
    % States for all the trajectory
    xtAll = [xtAll xt];
    xptAll = [xptAll xpt];
    ytAll = [ytAll yt];
    yptAll = [yptAll ypt];  
    ztAll = [ztAll zt];
    zptAll = [zptAll zpt];
    tAll = [tAll tG];
    ExAll = [ExAll Ex{j}'];                  % ExAll is the orbital energy in X for all the steps
    EyAll = [EyAll Ey{j}'];                  % ExAll is the orbital energy in Y for all the steps
    LAll = [LAll L{j}'];                     % LAll is the synchronization measure for all the steps
end
if Animation && produceVideo
    close(writerobj);
    disp('Video produced successfully')
    disp('------------------------------')
end

%% Storing all the parameters and information of this simulation
% =====================================================================
Solution.t = t;
Solution.Xt = Xt;
Solution.XtAll = [tAll', xtAll', ytAll', xptAll', yptAll', ztAll, zptAll];
if Animation
    Solution.XSampledAll = [tsAll', xsAll', ysAll', xpsAll', ypsAll', zsAll', zpsAll'];
end
Solution.SupportFootPos = SupportFoot;
Solution.zt = zt;
% Build just ONE structure with all the information
InfNAO.robot = robot;
% % InfNAO.iniParameters = initParam;
InfNAO.gait_parameters = gait_parameters;
InfNAO.Solution = Solution;
disp(['Saving data as: ' DataName]);
disp('------------------------------');
save(DataName,'InfNAO')

%% =====================================================================
% Evolution of the position and velocity CoM in X w.r.t. time
% ---------------------------------------------
figure (2)
subplot(3,1,1)  
hold on
plot(tAll,xtAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$x(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(tAll,xptAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{x}(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);
subplot(3,1,3)  
hold on
plot(tAll,ExAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$E_x(t)$ ','interpreter','Latex','FontSize',FontSize);

% Evolution of the position and velocity CoM in Y w.r.t. time
% ---------------------------------------------
figure (3)
subplot(3,1,1)  
hold on
plot(tAll,ytAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$y(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(tAll,yptAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{y}(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);
subplot(3,1,3)  
hold on
plot(tAll,EyAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$E_y(t)$ ','interpreter','Latex','FontSize',FontSize);


% Evolution of the CoM X-Y
% ---------------------------------------------
figure (4)
subplot(3,1,1)  
hold on
plot(xtAll,ytAll,'color','k','LineWidth',LineWidth)
axis([min(xtAll) max(xtAll) -inf inf])
xlabel('$x$ [m]','interpreter','Latex','FontSize',FontSize);
ylabel('$y$ [m]','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(xptAll(1),yptAll(1),'*b')
plot(xptAll(end),yptAll(end),'*r')
legend('Begining','Ending' )
plot(xptAll,yptAll,'.k')
axis([min(xptAll) max(xptAll) -inf inf])
xlabel('$\dot{x}$ [m/s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{y}$ [m/s]','interpreter','Latex','FontSize',FontSize);
subplot(3,1,3)  
hold on
plot(tAll,LAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$L(t)$','interpreter','Latex','FontSize',FontSize);
%
%------------------
figure (5)
subplot(3,1,1)  
hold on
plot(tAll,ztAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$z(t) [m]$','interpreter','Latex','FontSize',FontSize);
subplot(3,1,2)  
hold on
plot(tAll,zptAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$\dot{z}(t)$ [m/s]','interpreter','Latex','FontSize',FontSize);
subplot(3,1,3)  
hold on
plot(tAll,ExAll,'color','k','LineWidth',LineWidth)
axis([min(tAll) max(tAll) -inf inf])
xlabel('$t$ [s]','interpreter','Latex','FontSize',FontSize);
ylabel('$E_x(t)$ ','interpreter','Latex','FontSize',FontSize);

%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------