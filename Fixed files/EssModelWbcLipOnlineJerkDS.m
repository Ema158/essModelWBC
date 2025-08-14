function [tStart,tStartStep,tStop,tStopStep,tSS,tDS,XtStart,XtStartStep,XtStop,XtStopStep,XtSS,XtDS,SupportFoot] = EssModelWbcLipOnlineJerkDS(X0,gait_parametersSS,gait_parametersDS,gait_parametersStart,gait_parametersStartStep,gait_parametersStop,gait_parametersStopStep,N,horizon)
global gait_parameters xpp robot
gait_parameters = gait_parametersStart;
S = gait_parameters.S;
D = gait_parameters.D;
Tstart = gait_parameters.T;
[XtStart] = ode4(@dynam_HZDtimeLipReferenceOnlineJerk,0:1e-2:Tstart,X0);
tStart = 0:1e-2:Tstart;
[robot.Zref,robot.tRef] = ZMPReferenceV3OneStep(horizon,0,S,0,D);
[robot.ZMax,robot.ZMin] = ZMPConstraintsOneStep(horizon,0,S,0,D);
gait_parameters = gait_parametersStartStep;
TstartStep = gait_parameters.T;
X_final = XtStart(end,:)';           
[XtStartStep] = ode4(@dynam_HZDtimeLipReferenceOnlineJerk,0:1e-2:TstartStep,X_final);
tStartStep = 0:1e-2:TstartStep;
xpp(2) = -xpp(2);
tSS = cell(1,N);
XtSS = cell(1,N); 
tDS = cell(1,N);
XtDS = cell(1,N); 
SupportFoot = cell(1,N+2);
SupportFootX = 0;
SupportFootY = 0;
gait_parameters = gait_parametersSS;
X_final = XtStartStep(end,:)';  
SupportFoot{1} = [SupportFootX,SupportFootY];
SupportFoot{2} = [SupportFootX,SupportFootY];
SupportFootX = SupportFootX + S;
SupportFootY = SupportFootY + D;
for j=1:N    
    SupportFoot{j+2} = [SupportFootX,SupportFootY];
    % ====================================================================
    % Computation of one step of the robot: 
    % Previous states before impact -> the Impact and Rellabelling -> Evolution of one step -> states before impact
    % ====================================================================
    [tSS{j},tDS{j},XtSS{j},XtDS{j}] = robot_step_EssModel_tJerkDS(X_final,gait_parametersSS,gait_parametersDS); % "robot" and "gait_parameters" structures are needed inside
    % -----------------------------------------------------------------------------------------------------------------
    % Final states:
    X_final = XtDS{j}(end,:)';
    disp('-------------------------------------------');
    % Initial conditions for the Next step
    %-------------------------                    
    SupportFootX = SupportFootX + S;
    if mod(j,2) % If j is impair (for pair steps we add distance D)
        SupportFootY = SupportFootY - D;
    else
        SupportFootY = SupportFootY + D; % We come back to the original position
    end
        xpp(2) = -xpp(2);
end
SupportFoot{N+3} = [SupportFootX,SupportFootY];
SupportFoot{N+4} = [SupportFootX,SupportFootY];
gait_parameters = gait_parametersStopStep;
TstopStep = gait_parameters.T;
X_final(1) = X_final(1)-S;
X_final(2) = -X_final(2)+D;
X_final(14) = -X_final(14);
[robot.Zref,robot.tRef] = ZMPReferenceV2OneStep(horizon,0,0,0,D);
XtStopStep = ode4(@dynam_HZDtimeLipReferenceOnlineJerk,0:1e-2:TstopStep,X_final);
tStopStep = 0:1e-2:TstopStep;
X_final = XtStopStep(end,:)';  
gait_parameters = gait_parametersStop;
Tstop = gait_parameters.T;
[robot.Zref,robot.tRef] = ZMPReferenceV2OneStep(horizon,0,0,D,D/2);
XtStop = ode4(@dynam_HZDtimeLipReferenceOnlineJerk,0:1e-2:Tstop,X_final);
tStop = 0:1e-2:Tstop;