function [value, isterminal, direction] = PEvents_HDZtime_Internal_Statae_x(t,X)
% Identify the moment when the swing leg touch the ground
% Since in here, MANY events can be written, the next variables have index i: 
% isterminal(i)
% direction(i)
% value(i)
% However in our case, one event is "when the swing foot touch the groud", i.e. i=1.
% ....

global contB
global OutOfWorkSpace
global contD  % Once Out of workspace flag is activated, 'contD' counts the number of times PEvents is called.. 
%               in order to stop the integration 

if ~isempty(OutOfWorkSpace)
     if isempty(contD)
        contD = 1;
    end
    if mod(contD,4) == 1
        value(3) = 1;
    elseif mod(contD,4) == 2
        value(3) = 0;
    elseif mod(contD,4) == 3
        value(3) = -1;
    else
        value(3) = 0;
    end
    contD = contD+1;            
else
    value(3) = 1;
end
% global nQ
% value(3) = 1e-4 - nQ;   % This value should be always  positive since nQ is almost zero if the robot is inside its work space... 
isterminal(3) = 1;                 % it will stop the integration when...
direction(3) = 0;                  % it detects the change from positive to negative

% if the the CoM is Out of the work space, we don't compute the next of the function and return
if OutOfWorkSpace
    value(1:2) = [1,1];
    isterminal(1:2) = [1,1];         
    direction(1:2) = [-1,-1];    
    fprintf('Iteration: %d, t = %f, CoM -> Out of Workspace! Stopping integration...\n',contB,t)
    return;
end

global robot gait_parameters

% init;

x = X(1);
y = X(2);
xp = X(3);
yp = X(4);

%Inverse model
% based on the CoM and Current time the joint position is computed
q = InvGeometricHZDtime(x,y,robot,gait_parameters,t);
robot = robot_move(robot,q);

% Then, based in the joint position, the hight of the free foot is computed
%Foot height
z_foot = robot.T(3,4,14);

fprintf('Iteration: %d, t = %f, CoM_x = %f,  CoM_y = %f,  CoM_xp = %f,  CoM_yp = %f\n',contB,t,x,y,xp,yp)
fprintf('Foot height = %f\n',z_foot)
if x>0.01
    value(1) = z_foot;
%     xf = gait_parameters.xfcyc; % Just for some particular test
%     value(1) = xf - x;
%     if z_foot<1e-5
%     value(1)=0;
%     end
else
    value(1) =1;
end

% an event OCCURS WHEN value(i) = 0;
isterminal(1) = 1; % 1 -> When an event is detected (in this case there is just one) the integration is STOPPED. 
                   % 0 -> When an event is detected the integration is NOT STOPPED.
direction(1) = 0;  % It detects when the value of "value" pass through zero (0-> detects when goes from negative to positive or vice versa)
                   % If we select 1  -> It will just detect when the value goes from negative to positive 
                   % If we select -1 -> It will just detect when the value goes from positive to negative
                   % Thus, we could think we should use direction(1) = -1 since the hight of the foot is positive and it
                   % is decressing, so we want to detect when be negative (i.e. it already stepped the ground). However 0
                   % is used in order to be more precise, since sometimes the change from positive to negative is "so rough".
                   % For instance, the hight of the foot could be 0.1m and then -0.1m and if direction(1) = -1 the
                   % algorithm would stop. Nevertheless we can not know what happend from 0.1m to 0m. Thus, by using
                   % direction(1) = 0, the algorithm will stop until z_foot is very small (based on the values given by
                   % "Reltol" and/or "AbsTol"). Thus, at that moment, it doesn't matter if it change from positive to
                   % negative or vice versa since the chage is so small that doesn't affect for example from
                   % z_foot = -0.00000000001 to 0.00000000001  

% In here we ADD another way to STOP the integration... this will be when a maximum number of iterations 
% have been performed in the dynamics and there is no convergence, i.e. the evolution of the CoM is not good...
global noLanding
if ~isempty(contB) % If there is a value is because it is desired to show the number of iteration performed
    MaxIteration = 350;    % Maximum number of iterations to wait for landing the free foot, if this value is acvhieved..
    value(2) = MaxIteration - contB;   % it is going to change form positive to negative and...
    isterminal(2) = 1;                 % it will stop the integration when...
    direction(2) = -1;                 % it detects the change from positive to negative
    if (contB>MaxIteration || contB==MaxIteration)
       noLanding = 1;
    end
end           

% ========================================================
% This code could be useful to visualize the evolution of the CoM when a FIX POINT is tried to be found.
global contC
% contC is used to plot the CoM evolution as the solver is working
% if contC is empty it means it wasn't initialized by other codes so it is not required to plot the CoM evolution
if ~isempty(contC)  %
    global CoMx CoMy
    global contA  % To make a new figure each cycle
    global Stop
    CoMx(contC) = x;
    CoMy(contC) = y;
    figure(50+contA)
    plot(CoMx,CoMy,'*b');
    axis([-.2 .2 -.01 0.2])
    ylabel('y [cm]');
    xlabel('x [m]');
    if Stop
        display('Press any key to continue...');
        pause;
    end
    contC = contC + 1;
    % Draw the robot
    T = gait_parameters.T;
    range = T/20;
    permit = T/3;
    if (t<range) || ((permit-range)<t&&t<permit) || ((2*permit-range)<t&&t<2*permit) || ((3*permit-range)<t&&t<3*permit)
%         figure(100+contA)
%         robot_draw(robot,0,0);
        % ver como agregar la evolucion del centro de masa =) 
%         axis equal
    end

end
% =========================================================
    
end
