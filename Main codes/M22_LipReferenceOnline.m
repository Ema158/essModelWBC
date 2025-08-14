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
% Computing of joint trajectories positions velocities and accelerations  based on the CoM trajectory (Position and velocity)
% Also, computing reaction moment and force on the support foot, joint torques and ZMP.
% ==============================================================================================
% Creation: 19/dic/2017
% Last modification: -/-/-
% --------------------------------------------------------------------------------------------------
% This file load the CoM trajectory, gait information and others parameters to compute the Reaction
% moment and force of the ground, joint torques and ZMP produced.
% IN HERE the evolution of the ZMP COULD be OUTSIDE of the sole, all deppends of the CoM trajectory in position and
% velocity and the motion given to the free foot.
% --------------------------------------------------------------------------------------------------
% 
%
echo off
global coms;% En 1 se grafican los centros de masa de cada eslabon
                %En 0 no
coms=0;
% -----------------------------------------------   
Hour = datestr(now,13);
disp([Hour ' -> Reading data']);
% -----------------------------------------------   
% Options
% ----------------------------------------------- 
DataName = 'InfoNAO_Param_t_10prueba3'; % File produced in "M04d_...m" CHANGE OptionContVar = 1;
% DataName = 'InfoNAO_Param_t_10prueba'; % File produced in "M04d_...m" CHANGE OptionContVar = 1;

anim = 1; % Do you want animation? 1-> yes, 0-> no
% -------------------------------------------------------------------------------------------------
% CHOSING CONTROLLED VARIABLE FILES
% -------------------------------------------------------------------------------------------------
global OptionContVar  % Option to chose the controlled variables "hd", "hpd" and "hppd"
% 1 -> Controlled variables defined by polynomials w.r.t. time, IMPACT is considered. Files: "hd_Polyn", "hpd_Polyn" and "hppd_Polyn". 
% 2 -> Controlled variables defined by cycloidal motion w.r.t. time, IMPACT is NOT considered. Files: "hd_CycMotion_t", "hpd_CycMotion_t" and "hppd_CycMotion_t". 
% 3 -> Controlled variables defined by polynomials w.r.t. "x" of the CoM, IMPACT is considered. Files: "hd_Polyn", "hpd_Polyn_x" and "hppd_Polyn_x". 
% OptionContVar = 2;
OptionContVar = 1;
% -----------------------------------------------
% input
% -----------------------------------------------
load(DataName); 
NameAnim = ['anim_', DataName];
% -----------------------------------------------
robot = InfNAO.robot;
% robot = genebot(); 
% initParam = InfROMEO.iniParameters;
gait_parameters_gait = InfNAO.gait_parameters_gait;
gait_parametersStart = InfNAO.gait_parametersStart;
gait_parametersStartStep = InfNAO.gait_parametersStartStep;
gait_parametersStop = InfNAO.gait_parametersStop;
gait_parametersStopStep = InfNAO.gait_parametersStopStep;
Solution = InfNAO.Solution;

t = Solution.t;    % Cell array of elapsed time for each step
Xt = Solution.Xt;  % Cell array of solution X(t) for each step
%
tStart = Solution.tStart;
XtStart = Solution.XtStart;
%
tStartStep = Solution.tStartStep;
XtStartStep = Solution.XtStartStep;
%
tStop = Solution.tStop;
XtStop = Solution.XtStop;
%
tStopStep = Solution.tStopStep;
XtStopStep = Solution.XtStopStep;
Nstep = size(Xt,2); % number of steps

qt = cell(1,Nstep+2);
qDt = cell(1,Nstep+2);
qDDt = cell(1,Nstep+2);
ZMP = cell(1,Nstep+2);
F =cell(1,Nstep+2);
M = cell(1,Nstep+2);
Tau = cell(1,Nstep+2);

samplesAct = 0;
for j=1:(Nstep+2)
%     X0 = Xt{j}(1,:); % Initial condition of the CoM
    % % Torque, force and ZMP computation
    % -----------------------------------------------  
    fprintf('Step %d out of %d \n',j,Nstep);
    DateVecOld = datevec(Hour);
    Hour = datestr(now,13);
    disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
    disp([Hour ' -> Computing joint positions velocities and acceleration based on the CoM position and velocity']);
    Q = state_v(robot);
    if j==1
        [qtStartDS,qDtStartDS,qDDtStartDS] = joints_fromCoMpos_Vel_HZDtime(robot,XtStart,gait_parametersStart,tStart);
        [qtStartSS,qDtStartSS,qDDtStartSS] = joints_fromCoMpos_Vel_HZDtime(robot,XtStartStep,gait_parametersStartStep,tStartStep);
        qt{j} = [qtStartDS,qtStartSS];
        qDt{j} = [qDtStartDS,qDtStartSS];
        qDDt{j} = [qDDtStartDS,qDDtStartSS];
        samples = size(qt{j},2);
    end
    if j~=1 && j~=Nstep+2
        [qt{j},qDt{j},qDDt{j}] = joints_fromCoMpos_Vel_HZDtime(robot,Xt{j-1},gait_parameters_gait,t{j-1});
        samples = size(t{j-1},2);
    end
    if j==Nstep+2
        [qtStopSS,qDtStopSS,qDDtStopSS] = joints_fromCoMpos_Vel_HZDtime(robot,XtStopStep,gait_parametersStopStep,tStopStep);
        [qtStopDS,qDtStopDS,qDDtStopDS] = joints_fromCoMpos_Vel_HZDtime(robot,XtStop,gait_parametersStop,tStop);
        qt{j} = [qtStopSS,qtStopDS];
        qDt{j} = [qDtStopSS,qDtStopDS];
        qDDt{j} = [qDDtStopSS,qDDtStopDS];
        samples = size(qt{j},2);
    end
    % ------------------------------------------------    
    
    % % Torque, force and ZMP computation
    % -----------------------------------------------
    DateVecOld = datevec(Hour);
    Hour = datestr(now,13);
    disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
    disp([Hour ' -> Computation of torques, forces and ZMP based on "q", "qp" and "qpp" ...']);
    % ------------------------------------------------    
    ZMP{j} = zeros(2,samples);
    F{j} = zeros(3,samples);
    M{j} = zeros(3,samples);
    Tau{j} = zeros(robot.joints,samples);

    for i = 1:samples
        % "Newton_Euler.m" Algorithm
        [F{j}(:,i),M{j}(:,i),Tau{j}(:,i)]= Newton_Euler(qt{j}(:,i),qDt{j}(:,i),qDDt{j}(:,i));
        ZMP{j}(1,i) = -M{j}(2,i)/F{j}(3,i);
        ZMP{j}(2,i) =  M{j}(1,i)/F{j}(3,i);        
    end
    % Building the joint trajectories for all the steps
        if mod(j,2) % If j is impair 
            qtAll(:,1+samplesAct:samples+samplesAct) = qt{j};  % joint position q(t) for all the steps
            qDtAll(:,1+samplesAct:samples+samplesAct) = qDt{j};  % joint velocities q(t) for all the steps
            qDDtAll(:,1+samplesAct:samples+samplesAct) = qDDt{j};  % joint accelerations q(t) for all the steps
        else
            % Swaping according to the impact (see impact_Pos_Vel.m)        
            qtSwap = [qt{j}(12,:); -qt{j}([11,10,9],:); qt{j}([8,7,6,5],:); -qt{j}([4,3,2],:); qt{j}(1,:); -qt{j}(13,:);  qt{j}(14:22,:)];
            qDtSwap = [qDt{j}(12,:); -qDt{j}([11,10,9],:); qDt{j}([8,7,6,5],:); -qDt{j}([4,3,2],:); qDt{j}(1,:); -qDt{j}(13,:);  qDt{j}(14:22,:)];
            qDDtSwap = [qDDt{j}(12,:); -qDDt{j}([11,10,9],:); qDDt{j}([8,7,6,5],:); -qDDt{j}([4,3,2],:); qDDt{j}(1,:); -qDDt{j}(13,:);  qDDt{j}(14:22,:)];
            qtAll(:,1+samplesAct:samples+samplesAct) = qtSwap;  % joint position q(t) for all the steps
            qDtAll(:,1+samplesAct:samples+samplesAct) = qDtSwap;  % joint velocities q(t) for all the steps
            qDDtAll(:,1+samplesAct:samples+samplesAct) = qDDtSwap;  % joint accelerations q(t) for all the steps
        end
    F_All(:,1+samplesAct:samples+samplesAct) = F{j};
    M_All(:,1+samplesAct:samples+samplesAct) = M{j};
    Tau_All(:,1+samplesAct:samples+samplesAct) = Tau{j};
    ZMP_All(:,1+samplesAct:samples+samplesAct) = ZMP{j};
    samplesAct = samplesAct + samples;
    % ---------------------------------------------------------
end

%% Evolution of the key point variables (20 controlled variables and X-Y CoM)
disp('--------------------------------------------------------------------------------------------');
disp('Computing controlled variables evolution (Q and Qp) based on joint information (q and qp)...')
Q = cell(1,Nstep+2);
Qp = cell(1,Nstep+2);
for j=1:(Nstep+2)
    if j==1
        samples = size(qt{j},2);
    end
    if j~=1 && j~=Nstep+2
        samples = length(t{j-1});
    end
    if j==Nstep+2
        samples = size(qt{j},2);
    end
    for i=1:samples
        robot = robot_move(robot,qt{j}(:,i));
        robot.qD = qDt{j}(:,i);
        % Checking states of the robot
        [Q{j}(:,i), Qp{j}(:,i)] = current_states(robot);
    end
end

%% Storing all the parameters and information of this simulation
% =====================================================================
Solution.JointPos = qt;
Solution.JointVel = qDt;
Solution.JointAcc = qDDt;
Solution.JointPosAll = qtAll;
Solution.JointVelAll = qDtAll;
Solution.JointAccAll = qDDtAll;
Solution.ReactionForce = F;
Solution.ReactionMoment = M;
Solution.Torques = Tau;
Solution.ZMP = ZMP;
Solution.ReactionForceAll = F_All;
Solution.ReactionMomentAll = M_All;
Solution.TorquesAll = Tau_All;
Solution.ZMPAll = ZMP_All;
Solution.Q = Q;
Solution.Qp = Qp;

% Save just ONE structure with all the information
InfNAO.Solution = Solution;
% ---------------------------------------------------------
DateVecOld = datevec(Hour);
Hour = datestr(now,13);
disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
disp([Hour ' -> Adding data from joints, tau, F, M, ZMP and others to the data file: ' DataName]);
disp('------------------------------');
% ---------------------------------------------------------
save(DataName,'InfNAO')


%% Walking ANIMATION
% ==============================================================================
if anim    
    dataS = cell(Nstep+2,1); % Sampled joint positions
    disp('Animation...')
    % This part is just to make the animation faster, the larger "n" the slower and finer the animation
    n = 10; % Number of samples of vector
    for i=1:Nstep+2
        qS = sampling(qt{i},n); % sampling of joint position "q"       
        % We don't need the joint velocities to draw the robot, so we don't sample the velocity "qp"
        dataS{i,1} = qS;
    end
    framerate = 5;
    animation(dataS,Nstep+2,NameAnim,framerate); % ("parametro"= Numero de pasos a observar al final de la simulaci�n y a grabar en el video
    animation_stick(dataS,Nstep+2);    %"parametro"= Numero de pasos que se dibujar�n
    disp(['Animation stored as: ' NameAnim]);
    disp('----------------------------------');
end
% ==============================================================================

%% PLOTS
% =======================================================
DateVecOld = datevec(Hour);
Hour = datestr(now,13);
disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
disp([Hour ' -> Plotting...']);
% -----------------------------------------
% In the variable "plots" we chose which plot we want to show...
plots(1) = 1;
plots(2) = 1;
plots(3) = 1;
plots(4) = 1;
plots(5) = 1;
% plots(1) = 0;
% plots(2) = 0;
% plots(3) = 0;
% plots(4) = 0;
% plots(5) = 0;
plots(6) = 0;
plots(7) = 0;
plots(8) = 0;
% plots(1) -> joint position, velocity and acceleration
% plots(2) -> reaction force and moment
% plots(3) -> joint torques
% plots(4) -> ZMP time
% plots(5) -> ZMP foot
% plots(6) -> CoM time
% plots(7) -> CoM X-Y
% plots(8) -> CoM samples
% ------------------------------------------------------------
% General file for plotting:
colors = 'krbgymckrbgymckrbgymc'; % Posible color for the lines of each step. Maximum 7 steps (since there are 7 different colors)
for j=1:(Nstep)
    hold on
    LineType = colors(j);
    graphix(plots,Xt{j},Tau{j+1},t{j},qt{j+1},qDt{j+1},qDDt{j+1},F{j+1},M{j+1},ZMP{j+1},LineType,5);
end
% ------------------------------------------------------------
figure(30)
FootCenter = [0,0];
width = 0.08; % foot width [m]
length2Ankle = 0.05; % foot lenght from center to ankle [m]
length2toes = 0.15; % foot lenght from center to the toes 
ZMPfootprints(ZMP{1},FootCenter,width,length2Ankle,length2toes,colors(1))
plot(XtStart(:,1),XtStart(:,2))
hold on
plot(XtStartStep(:,1),XtStartStep(:,2))
S = gait_parameters_gait.S;
D = gait_parameters_gait.D;
for j=1:Nstep+1
    if mod(j,2)
        FootCenter = [S*j,D];
        ZMPx = ZMP{j+1}(1,:) + S*j;
        ZMPy = -ZMP{j+1}(2,:) + D;
        if j<Nstep+1
            plot(Xt{j}(:,1)+S*j,-Xt{j}(:,2)+D)
        else
            plot(XtStop(:,1)+S*j,-XtStop(:,2)+D)
            plot(XtStopStep(:,1)+S*j,-XtStopStep(:,2)+D)
        end
    else
        FootCenter = [S*j,0];
        ZMPx = ZMP{j+1}(1,:) + S*j;
        ZMPy = ZMP{j+1}(2,:);
        if j<Nstep+1
            plot(Xt{j}(:,1)+S*j,Xt{j}(:,2))
        else
            plot(XtStop(:,1)+S*j,XtStop(:,2))
            plot(XtStopStep(:,1)+S*j,XtStopStep(:,2))
        end
    end
    ZMPfootprints([ZMPx;ZMPy],FootCenter,width,length2Ankle,length2toes,colors(j+1))
end
%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------