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
% DataName = 'InfoNAO_Param_t_caminadoNoWBCDS'; % File produced in "M04d_...m" CHANGE OptionContVar = 1;
DataName = 'InfoNAO_DSNoWBCAcc'; % File produced in "M04d_...m" CHANGE OptionContVar = 1;

anim = 0; % Do you want animation? 1-> yes, 0-> no
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
gait_parametersSS = InfNAO.gait_parametersSS;
gait_parametersDS = InfNAO.gait_parametersDS;
gait_parametersStart = InfNAO.gait_parametersStart;
gait_parametersStartStep = InfNAO.gait_parametersStartStep;
gait_parametersStop = InfNAO.gait_parametersStop;
gait_parametersStopStep = InfNAO.gait_parametersStopStep;
Solution = InfNAO.Solution;
%
tSS = Solution.tSS;    % Cell array of elapsed time for each step
XtSS = Solution.XtSS;  % Cell array of solution X(t) for each step
tDS = Solution.tDS;    % Cell array of elapsed time for each step
XtDS = Solution.XtDS;  % Cell array of solution X(t) for each step
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
Nstep = size(XtSS,2); % number of steps
%
%
Zref = Solution.Zref;
ZMax = Solution.ZMax;
ZMin = Solution.ZMin;
tRef = Solution.tRef;
offsetX = Solution.offsetX;
%
qt = cell(1,Nstep+2);
qDt = cell(1,Nstep+2);
qDDt = cell(1,Nstep+2);
CMPSS = cell(1,Nstep+2);
CMPDS = cell(1,Nstep+2);
CAMSS = cell(1,Nstep+2);
CAMDS = cell(1,Nstep+2);
ZMPSS = cell(1,Nstep+2);
ZMPDS = cell(1,Nstep+2);
F = cell(1,Nstep+2);
M = cell(1,Nstep+2);
Tau = cell(1,Nstep+2);
CAM = cell(1,Nstep+2);
CMP = cell(1,Nstep+2);
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
    if j==1
        [qtStartDS,qDtStartDS,qDDtStartDS] = joints_fromCoMpos_Vel_HZDtimeNoWBC(robot,XtStart,gait_parametersStart,tStart);
        [qtStartSS,qDtStartSS,qDDtStartSS] = joints_fromCoMpos_Vel_HZDtimeNoWBC(robot,XtStartStep,gait_parametersStartStep,tStartStep);
        qt{j} = [qtStartDS,qtStartSS];
        qDt{j} = [qDtStartDS,qDtStartSS];
        qDDt{j} = [qDDtStartDS,qDDtStartSS];
        XtAllStart = [XtStart;XtStartStep];
        tStartAll = [tStart,tStart(end)+tStartStep];
        samples = size(qt{j},2);
        ZMP{j} = zeros(2,samples);
        CMP{j} = zeros(2,samples);
        CAM{j} = zeros(3,samples);
        F{j} = zeros(3,samples);
        M{j} = zeros(3,samples);
        Tau{j} = zeros(robot.joints,samples);
        for i = 1:samples
            [F{j}(:,i),M{j}(:,i),Tau{j}(:,i)]= Newton_Euler(qt{j}(:,i),qDt{j}(:,i),qDDt{j}(:,i));
            ZMP{j}(1,i) = -M{j}(2,i)/F{j}(3,i);
            ZMP{j}(2,i) =  M{j}(1,i)/F{j}(3,i);   
            CMP{j}(1,i) = XtAllStart(i,1) - (F{j}(1,i)/F{j}(3,i))*gait_parametersStart.z_i;
            CMP{j}(2,i) = XtAllStart(i,2) - (F{j}(2,i)/F{j}(3,i))*gait_parametersStart.z_i;
            CAM{j}(1,i) = (ZMP{j}(2,i)-XtAllStart(i,2))*F{j}(3,i) + F{j}(2,i)*gait_parametersStart.z_i;
            CAM{j}(2,i) = (XtAllStart(i,1)-ZMP{j}(1,i))*F{j}(3,i) - F{j}(1,i)*gait_parametersStart.z_i;
            CAM{j}(3,i) = (ZMP{j}(1,i)-XtAllStart(i,1))*F{j}(2,i) - (ZMP{j}(2,i)-XtAllStart(i,2))*F{j}(1,i);
        end
    end
    if j~=1 && j~=Nstep+2
        [qtSS{j},qDtSS{j},qDDtSS{j}] = joints_fromCoMpos_Vel_HZDtimeNoWBC(robot,XtSS{j-1},gait_parametersSS,tSS{j-1});
        [qtDS{j},qDtDS{j},qDDtDS{j}] = joints_fromCoMpos_Vel_HZDtimeNoWBC(robot,XtDS{j-1},gait_parametersDS,tDS{j-1});
        samplesSS = size(tSS{j-1},2);
        samplesDS = size(tDS{j-1},2);
        samples = samplesSS+samplesDS;
        CMP{j} = zeros(2,samples);
        CAM{j} = zeros(3,samples);
        ZMP{j} = zeros(2,samples);
        F{j} = zeros(3,samples);
        M{j} = zeros(3,samples);
        Tau{j} = zeros(robot.joints,samples);
        for i = 1:samplesSS
            [FSS{j}(:,i),MSS{j}(:,i),TauSS{j}(:,i)]= Newton_Euler(qtSS{j}(:,i),qDtSS{j}(:,i),qDDtSS{j}(:,i));
            ZMPSS{j}(1,i) = -MSS{j}(2,i)/FSS{j}(3,i);
            ZMPSS{j}(2,i) =  MSS{j}(1,i)/FSS{j}(3,i);    
            CMPSS{j}(1,i) = XtSS{j-1}(i,1) - (FSS{j}(1,i)/FSS{j}(3,i))*gait_parametersSS.z_i;
            CMPSS{j}(2,i) = XtSS{j-1}(i,2) - (FSS{j}(2,i)/FSS{j}(3,i))*gait_parametersSS.z_i;
            CAMSS{j}(1,i) = (ZMPSS{j}(2,i)-XtSS{j-1}(i,2))*FSS{j}(3,i) + FSS{j}(2,i)*gait_parametersSS.z_i;
            CAMSS{j}(2,i) = (XtSS{j-1}(i,1)-ZMPSS{j}(1,i))*FSS{j}(3,i) - FSS{j}(1,i)*gait_parametersSS.z_i;
            CAMSS{j}(3,i) = (ZMPSS{j}(1,i)-XtSS{j-1}(i,1))*FSS{j}(2,i) - (ZMPSS{j}(2,i)-XtSS{j-1}(i,2))*FSS{j}(1,i);
        end
        for i = 1:samplesDS
            [FDS{j}(:,i),MDS{j}(:,i),TauDS{j}(:,i)]= Newton_Euler(qtDS{j}(:,i),qDtDS{j}(:,i),qDDtDS{j}(:,i));
            ZMPDS{j}(1,i) = -MDS{j}(2,i)/FDS{j}(3,i);
            ZMPDS{j}(2,i) =  MDS{j}(1,i)/FDS{j}(3,i);        
            CMPDS{j}(1,i) = XtDS{j-1}(i,1) - (FDS{j}(1,i)/FDS{j}(3,i))*gait_parametersSS.z_i;
            CMPDS{j}(2,i) = XtDS{j-1}(i,2) - (FDS{j}(2,i)/FDS{j}(3,i))*gait_parametersSS.z_i;
            CAMDS{j}(1,i) = (ZMPDS{j}(2,i)-XtDS{j-1}(i,2))*FDS{j}(3,i) + FDS{j}(2,i)*gait_parametersDS.z_i;
            CAMDS{j}(2,i) = (XtDS{j-1}(i,1)-ZMPDS{j}(1,i))*FDS{j}(3,i) - FDS{j}(1,i)*gait_parametersDS.z_i;
            CAMDS{j}(3,i) = (ZMPDS{j}(1,i)-XtDS{j-1}(i,1))*FDS{j}(2,i) - (ZMPDS{j}(2,i)-XtDS{j-1}(i,2))*FDS{j}(1,i);
        end
        qt{j} = [qtSS{j},qtDS{j}];
        qDt{j} = [qDtSS{j},qDtDS{j}];
        qDDt{j} = [qDDtSS{j},qDDtDS{j}];
        F{j} = [FSS{j},FDS{j}];
        M{j} = [MSS{j},MDS{j}];
        Tau{j} = [TauSS{j},TauDS{j}];
        ZMP{j} = [ZMPSS{j},ZMPDS{j}];
        CMP{j} = [CMPSS{j},CMPDS{j}];
        CAM{j} = [CAMSS{j},CAMDS{j}];
        t{j-1} = [tSS{j-1},tSS{j-1}(end)+tDS{j-1}];
        Xt{j-1} = [XtSS{j-1};XtDS{j-1}];
    end
    if j==Nstep+2
        [qtStopSS,qDtStopSS,qDDtStopSS] = joints_fromCoMpos_Vel_HZDtimeNoWBC(robot,XtStopStep,gait_parametersStopStep,tStopStep);
        [qtStopDS,qDtStopDS,qDDtStopDS] = joints_fromCoMpos_Vel_HZDtimeNoWBC(robot,XtStop,gait_parametersStop,tStop);
        samplesSS = size(qtStopSS,2);
        samplesDS = size(qtStopDS,2);
        samples = samplesSS+samplesDS;
        ZMP{j} = zeros(2,samples);
        CMP{j} = zeros(2,samples);
        CAM{j} = zeros(2,samples);
        F{j} = zeros(3,samples);
        M{j} = zeros(3,samples);
        Tau{j} = zeros(robot.joints,samples);
    for i = 1:samplesSS
            [FSS{j}(:,i),MSS{j}(:,i),TauSS{j}(:,i)]= Newton_Euler(qtStopSS(:,i),qDtStopSS(:,i),qDDtStopSS(:,i));
            ZMPSS{j}(1,i) = -MSS{j}(2,i)/FSS{j}(3,i);
            ZMPSS{j}(2,i) =  MSS{j}(1,i)/FSS{j}(3,i); 
            CMPSS{j}(1,i) = XtStopStep(i,1) - (FSS{j}(1,i)/FSS{j}(3,i))*gait_parametersStart.z_i;
            CMPSS{j}(2,i) = XtStopStep(i,2) - (FSS{j}(2,i)/FSS{j}(3,i))*gait_parametersStart.z_i;
            CAMSS{j}(1,i) = (ZMPSS{j}(2,i)-XtStopStep(i,2))*FSS{j}(3,i) + FSS{j}(2,i)*gait_parametersStart.z_i;
            CAMSS{j}(2,i) = (XtStopStep(i,1)-ZMPSS{j}(1,i))*FSS{j}(3,i) - FSS{j}(1,i)*gait_parametersStart.z_i;
            CAMSS{j}(3,i) = (ZMPSS{j}(1,i)-XtStopStep(i,1))*FSS{j}(2,i) - (ZMPSS{j}(2,i)-XtStopStep(i,2))*FSS{j}(1,i);  
    end
    for i = 1:samplesDS
            [FDS{j}(:,i),MDS{j}(:,i),TauDS{j}(:,i)]= Newton_Euler(qtStopDS(:,i),qDtStopDS(:,i),qDDtStopDS(:,i));
            ZMPDS{j}(1,i) = -MDS{j}(2,i)/FDS{j}(3,i);
            ZMPDS{j}(2,i) =  MDS{j}(1,i)/FDS{j}(3,i); 
            CMPDS{j}(1,i) = XtStop(i,1) - (FDS{j}(1,i)/FDS{j}(3,i))*gait_parametersStart.z_i;
            CMPDS{j}(2,i) = XtStop(i,2) - (FDS{j}(2,i)/FDS{j}(3,i))*gait_parametersStart.z_i;
            CAMDS{j}(1,i) = (ZMPDS{j}(2,i)-XtStop(i,2))*FDS{j}(3,i) + FDS{j}(2,i)*gait_parametersStart.z_i;
            CAMDS{j}(2,i) = (XtStop(i,1)-ZMPDS{j}(1,i))*FDS{j}(3,i) - FDS{j}(1,i)*gait_parametersStart.z_i;
            CAMDS{j}(3,i) = (ZMPDS{j}(1,i)-XtStop(i,1))*FDS{j}(2,i) - (ZMPDS{j}(2,i)-XtStop(i,2))*FDS{j}(1,i);  
    end
        qt{j} = [qtStopSS,qtStopDS];
        qDt{j} = [qDtStopSS,qDtStopDS];
        qDDt{j} = [qDDtStopSS,qDDtStopDS];
        F{j} = [FSS{j},FDS{j}];
        M{j} = [MSS{j},MDS{j}];
        Tau{j} = [TauSS{j},TauDS{j}];
        ZMP{j} = [ZMPSS{j},ZMPDS{j}];
        CMP{j} = [CMPSS{j},CMPDS{j}];
        CAM{j} = [CAMSS{j},CAMDS{j}];
        XtStopAll = [XtStopStep;XtStop];
        tStopAll = [tStopStep,tStopStep(end)+tStop];
        t{j-1} = [tStopStep,tStopStep(end)+tStop];
        Xt{j-1} = [XtStopStep;XtStop];
        XtSS{j-1} = XtStopStep;
        XtDS{j-1} = XtStop;
    end
    % ------------------------------------------------    
    
    % % Torque, force and ZMP computation
    % -----------------------------------------------
    DateVecOld = datevec(Hour);
    Hour = datestr(now,13);
    disp(['Elapsed time: ' datestr(etime(datevec(Hour),DateVecOld)/86400, 'HH:MM:SS')]);
    disp([Hour ' -> Computation of torques, forces and ZMP based on "q", "qp" and "qpp" ...']);
    % ------------------------------------------------    
    
    
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
% plots(1) = 1;
% plots(2) = 1;
% plots(3) = 1;
% plots(4) = 1;
% plots(5) = 1;
plots(1) = 0;
plots(2) = 0;
plots(3) = 0;
plots(4) = 0;
plots(5) = 0;
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
S = gait_parametersSS.S;
D = gait_parametersSS.D;
FootCenter = [0,0];
width = 0.08; % foot width [m]
length2Ankle = 0.05; % foot lenght from center to ankle [m]
length2toes = 0.10; % foot lenght from center to the toes 
ZMPfootprints(ZMP{1},FootCenter,width,length2Ankle,length2toes,colors(1))
plot(Zref(1,:),Zref(2,:))
% plot(XtStart(:,1),XtStart(:,2),'k')
plotZMPConstraints(S,offsetX,Nstep+2)
% plot(XtStartStep(:,1),XtStartStep(:,2),'k')
for j=1:Nstep+1
    if mod(j,2)
        FootCenter = [S*j,D];
        ZMPxSS = ZMPSS{j+1}(1,:) + S*j;
        ZMPySS = -ZMPSS{j+1}(2,:) + D;
        ZMPxDS = ZMPDS{j+1}(1,:) + S*j;
        ZMPyDS = -ZMPDS{j+1}(2,:) + D;
%         plot(XtSS{j}(:,1)+S*j,-XtSS{j}(:,2)+D,'k')
%         plot(XtDS{j}(:,1)+S*j,-XtDS{j}(:,2)+D,'k')
    else
        FootCenter = [S*j,0];
        ZMPxSS = ZMPSS{j+1}(1,:) + S*j;
        ZMPySS = ZMPSS{j+1}(2,:);
        ZMPxDS = ZMPDS{j+1}(1,:) + S*j;
        ZMPyDS = ZMPDS{j+1}(2,:);
%         plot(XtSS{j}(:,1)+S*j,XtSS{j}(:,2),'k')
%         plot(XtDS{j}(:,1)+S*j,XtDS{j}(:,2),'k')
    end
    ZMPfootprints([ZMPxSS;ZMPySS],FootCenter,width,length2Ankle,length2toes,'r')
    ZMPfootprints([ZMPxDS;ZMPyDS],FootCenter,width,length2Ankle,length2toes,'k')
end
figure(31)
plot(tStartAll,CAM{1}(1,:))
hold on
for j=1:Nstep
    if mod(j,2)
        plot(tStartAll(end)+t{1}+t{1}(end)*(j-1),-CAM{j+1}(1,:))
    else 
        plot(tStartAll(end)+t{1}+t{1}(end)*(j-1),CAM{j+1}(1,:))
    end
end
if mod(Nstep,2)
    plot(tStartAll(end)+t{1}(end)*(Nstep)+tStopAll,CAM{Nstep+2}(1,:))
else
    plot(tStartAll(end)+t{1}(end)*(Nstep)+tStopAll,-CAM{Nstep+2}(1,:))
end
title('Angular Momentum rate change in x');
figure(32)
plot(tStartAll,CAM{1}(2,:))
hold on
for j=1:Nstep
    plot(tStartAll(end)+t{1}+t{1}(end)*(j-1),CAM{j+1}(2,:))
end
plot(tStartAll(end)+t{1}(end)*(Nstep)+tStopAll,CAM{Nstep+2}(2,:))
title('Angular Momentum rate change in y');
figure(33)
plot(tStartAll,XtAllStart(:,5))
hold on
for j=1:Nstep
    if mod(j,2)
        plot(tStartAll(end)+t{1}+t{1}(end)*(j-1),-Xt{j}(:,5))
    else
        plot(tStartAll(end)+t{1}+t{1}(end)*(j-1),Xt{j}(:,5))
    end
end
if mod(Nstep,2)
    plot(tStartAll(end)+t{1}(end)*(Nstep)+tStopAll,XtStopAll(:,5))
else
    plot(tStartAll(end)+t{1}(end)*(Nstep)+tStopAll,-XtStopAll(:,5))
end
title('Angular Momentum in x');
figure(34)
plot(tStartAll,XtAllStart(:,6))
hold on
for j=1:Nstep
    plot(tStartAll(end)+t{1}+t{1}(end)*(j-1),Xt{j}(:,6))
end
plot(tStartAll(end)+t{1}(end)*(Nstep)+tStopAll,XtStopAll(:,6))
title('Angular Momentum in y');
figure(35)
plot(tRef,Zref(2,:),'k--')
hold on
plot(tRef,ZMax(2,:),'r--')
plot(tRef,ZMin(2,:),'b--')
plot(tStartAll,ZMP{1}(2,:),'k')
for j=1:Nstep
    if mod(j,2)
        FootCenter = [S*j,D];
        ZMPySS = -ZMPSS{j+1}(2,:) + D;
        ZMPyDS = -ZMPDS{j+1}(2,:) + D;
        ZMPy = [ZMPySS,ZMPyDS];
        plot(t{j}+tStartAll(end)+t{j}(end)*(j-1),ZMPy,'k')
    else
        ZMPySS = ZMPSS{j+1}(2,:);
        ZMPyDS = ZMPDS{j+1}(2,:);
        ZMPy = [ZMPySS,ZMPyDS];
        plot(t{j}+tStartAll(end)+t{j}(end)*(j-1),ZMPy,'k')
    end
end
if mod(Nstep,2)==false
    ZMPyStop = -ZMP{Nstep+2}(2,:) + D;
else
    ZMPyStop = ZMP{Nstep+2}(2,:);
end
plot(tStopAll+tStartAll(end)+t{Nstep}(end)*(Nstep),ZMPyStop,'k')
figure(36)
plot(tRef,Zref(1,:),'k--')
hold on
plot(tRef,ZMax(1,:),'r--')
plot(tRef,ZMin(1,:),'b--')
plot(tStartAll,ZMP{1}(1,:),'k')
for j=1:Nstep
        ZMPxSS = ZMPSS{j+1}(1,:) + S*j;
        ZMPxDS = ZMPDS{j+1}(1,:) + S*j;
        ZMPx = [ZMPxSS,ZMPxDS];
        plot(t{j}+tStartAll(end)+t{j}(end)*(j-1),ZMPx,'k')
end
ZMPxStop = ZMP{Nstep+2}(1,:) + S*(Nstep+1);
plot(tStopAll+tStartAll(end)+t{Nstep}(end)*(Nstep),ZMPxStop,'k')
%% End of the code
% ----------------------------------------------------------------------------------------------
cd ..                  % Go down one folder (go out from the current folder and stay in the previous one)
remove_paths;          % Remove the paths of the folders added at the begining
cd(currentfolder);     % Return to the original folder
% ----------------------------------------------------------------------------------------------