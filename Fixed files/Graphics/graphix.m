function FigNum = graphix(plots,Xt,Tau,t,qt,qDt,qDDt,F,M,ZMP,LineColor,FigIni)
% With this function almmost all variables we usually need can be plotted.
% If we want to plot some variable with some other details, it is recommended to use directly "plot_vector" function
% ---------------------------------------------------------------------------------

% plots(1) -> joint position, velocity and acceleration
% plots(2) -> reaction force and moment
% plots(3) -> joint torques
% plots(4) -> ZMP time
% plots(5) -> ZMP foot
% plots(6) -> CoM time
% plots(7) -> CoM X-Y
% plots(8) -> CoM samples

% LineType - > The color of the line
% FigIni -> The next figures will start to be created from this number
if nargin>11
    FigNum = FigIni;
else
    FigNum = 1;
end

samples = length(t);
% ====================================================
%     LIMITS (join positions, velocities and torques)
% ====================================================
lim = limits();
onesVect = ones(1,samples);
limTau = zeros(22,samples);
limVel = zeros(22,samples);
limPosMax = zeros(22,samples);
limPosMin = zeros(22,samples);
for i=1:22
    limTau(i,:) = lim.tor(i)*onesVect;
    limVel(i,:) = lim.vel(i)*onesVect;
    limPosMin(i,:) = lim.pos(1,i)*onesVect;
    limPosMax(i,:) = lim.pos(2,i)*onesVect;    
end
% ---------------------------------------------------------------------
% Adjust of the limits for velocity and torque for the knees
% centrode = load('reductionCentrode.csv'); % The values of "Centroide" are in degrees
% Values for the SUPPORT leg knee
% Relation_knee_1 = interp1q(centrode(:,1),centrode(:,2),-qt(3,:)'*180/pi);
% Function -> yi = interp1q(x,y,xi)
% We have a set of data (x,y), if wanted ti know the values of y for required values of x that are not among the set we
% have, we need to use an interpolation. In this case a linear interpolation is considered.
% Thus, function yi = interp1q(x,y,xi); asign values to "yi" for required values of "xi" that not belong to the set
% (x,y) but are in the range of "x". Namely, if we have the set (x,y)=([1,2,3],[12,24,15]), note that "x" is monotonic
% and its range is from 1 to 3. Then if wanted to know a value of "y" for a value of x= 2.32 we need to interpolate
% (get values for "y" corresponding to values of "x" between 2 and 3).
% In this case, we have "(x,y) = (centroide(:,1),centroide(:,2))", where "centroide" is the set of (x,y) data with a
% monotonic "x" (this is a REQUISITE) and it goes from -1.5990 to 115 with variable intervals (it means that it could be
% that the value for "y" corresponding to some value "x" (for example  x=0.15143) is not asigned. Then, what we are
% doing is giving a desired set of x-data "xi" given by "-qt(3,:)'*180/pi" (that is inside the range x=[-1.5990,115]) for whose
% we want to know the corresponing values of y stored in "yi", or in this case in "Relation_knee_1".
% Values for the FREE leg knee
% Relation_knee_2 = interp1q(centrode(:,1),centrode(:,2),qt(10,:)'*180/pi); % We make the same for another specific interval "xi" given by "qt(10,:)'*180/pi)"
% limTau(3,:) = lim.tor(3)*Relation_knee_1;
% limTau(10,:) = lim.tor(10)*Relation_knee_2;
% limVel(3,:) = lim.vel(3)./Relation_knee_1;
% limVel(10,:) = lim.vel(10)./Relation_knee_2;
% =================================================================================



% Plots
% ========================================================
if plots(1)~=0
    % Joint positions, velocities and accelerations % plot_joints (t,joints,q,qD,qDD,figIni,Grupo,linea) Grupo = Number of joints per figure
    plot_joints(t,1:22,qt,qDt,qDDt,FigNum,5,LineColor);
    plot_joints(t,1:22,limPosMax,limVel,qDDt,FigNum,5,['--',LineColor]);
    FigNum = plot_joints(t,1:22,limPosMin,-limVel,qDDt,FigNum,5,['--',LineColor]);
end

if plots(2)~=0
    figure(FigNum)  %Force anda moment evolution in X, Y and Z produced in the support frame due to the robot motion
    labelAxis = 'XYZ';
    k=1;
    for i=1:3
        subplot(3,2,k)   % 1, 3, 5
        hold on
        plot(t,F(i,:),LineColor)
        axis([min(t) max(t) -inf inf])
        ylabel(['Force in ' labelAxis(i)]);
        xlabel('$t$ [s]','interpreter','Latex');
        if k==1
            title('Force');
        end
        k=k+1;
        subplot(3,2,k)  % 2, 4, 6
        hold on
        plot(t,M(i,:),LineColor)
        axis([min(t) max(t) -inf inf])
        ylabel(['Moment in ' labelAxis(i)]);
        xlabel('$t$ [s]','interpreter','Latex');
        if k==2
            title('Moment');
        end
        k=k+1;
    end
    FigNum = FigNum + 1; %Since it takes 1 figure to plot this
end

if plots(3)~=0
    % Joint torques
    % plot_vector(t,var,x,figIni,Matriz,linea,LabelX,LabelY) % Matriz -> Array of Subplot, ej [2,2], [3,2], etc...
    LabelX = ''; %'$t$ [s]';  % if we don't want to write anything just leave it as: LabelX = '';
    LabelY = '$\tau$ ';
    plot_vector(t,1:22,Tau,FigNum,[4,4],LineColor,LabelX,LabelY);    
    %plot_vector(t,1:22,limTau,FigNum,[4,4],['--',LineColor],LabelX,LabelY);
    %FigNum = plot_vector(t,1:22,-limTau,FigNum,[4,4],['--',LineColor],LabelX,LabelY);
    FigNum = FigNum +2;
end

if plots(4)~=0
    % ZMP
    % plot_vector(t,var,x,figIni,Matriz,linea,LabelX,LabelY) % Matriz -> Array of Subplot, ej [2,2], [3,2], etc...
    LabelX = '$t$ [s]'; %'$t$ [s]';  % if we don't want to write anything just leave it as: LabelX = '';
    LabelY = '$ZMP$ ';
    FigNum = plot_vector(t,1:2,ZMP,FigNum,[4,4],LineColor,LabelX,LabelY);     % [1,5,7:13,31]    
end

if plots(5)~=0    
    mu = 0.7;
    Ft = zeros(1,samples);
    Ffri = zeros(1,samples);
    for i = 1:samples
        Ft(i) = sqrt(F(1,i)^2 + F(2,i)^2); % Tangential force
        Ffri(i) = mu*F(3,i);               % Friction force
    end    
    disp(['The friction coefficient used to calculate the friction force was mu = ', num2str(mu)]);
    % ZMP evolution in the X-Y plane
    figure(FigNum)
    subplot(2,2,1)
    hold on
    plot(t,F(3,:),LineColor)
    ylabel('Normal force [N] ($F_z$)','interpreter','latex');
    xlabel('t [s]','interpreter','latex');
    subplot(2,2,2)
    hold on
    plot(t,Ft,LineColor,t,Ffri,['--',LineColor])
    ylabel('Friction force [N]','interpreter','latex');
    xlabel('t [s]','interpreter','latex');
    legend('Tangential force', 'Max force allowed \mu F_z')
    subplot(2,1,2)
    hold on
    FootCenter = [0,0];
    width = 0.08; % foot width [m]
    length2Ankle = 0.05; % foot lenght from center to ankle [m]
    length2toes = 0.15; % foot lenght from center to the toes 
    ZMPfootprints(ZMP,FootCenter,width,length2Ankle,length2toes,LineColor)
    FigNum = FigNum + 1; %Since it takes 1 figure to plot this
end

if plots(6)~=0
    % Trajectory of the CoM (position and velocity) with respect to time
    % plot_vector(t,var,x,figIni,Matriz,linea,LabelX,LabelY) % Matriz -> Array of Subplot, ej [2,2], [3,2], etc...
    LabelX = '$t$ [s]'; %'$t$ [s]';  % if we don't want to write anything just leave it as: LabelX = '';
    LabelY = '$X$ ';
    FigNum = plot_vector(t,1:4,Xt',FigNum,[2,2],LineColor,LabelX,LabelY);    
end

if plots(7)~=0
    figure(FigNum)
    hold on
    plot(Xt(:,1),Xt(:,2),LineColor)
    axis equal
    hold on
    title('CoM evolution');
    ylabel('y [m]');
    xlabel('x [m]');
    FigNum = FigNum + 1; %Since it takes 1 figure to plot this
end

if plots(8)~=0
    % Trajectory of the CoM (position and velocity) with respect to number of samples
    % plot_vector(t,var,x,figIni,Matriz,linea,LabelX,LabelY) % Matriz -> Array of Subplot, ej [2,2], [3,2], etc...
    LabelX = 'Samples'; %'$t$ [s]';  % if we don't want to write anything just leave it as: LabelX = '';
    LabelY = '$X$ ';    
    FigNum = plot_vector(1:samples,1:4,Xt',FigNum,[2,2],LineColor,LabelX,LabelY);    
end
