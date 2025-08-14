
function ZMPfootprints(ZMP,FootCenter,FootWidth,FootLength2Ankle,FootLength2toes,LineType,alpha)
% Prints the evolution of the ZMP and the footprint of the support foot
% ----------------------------------------------------------------------

% FootCenter -> Center of the foot
% FootWidth -> foot width [cm]
% FootLength2Ankle -> foot lenght from center to ankle [cm]
% FootLength2toes -> foot lenght from center to the toes [cm]

if nargin == 6
    alpha = 0;
end
RotZ_01 = [cos(alpha), -sin(alpha); sin(alpha), cos(alpha)]; % 2x2 rotation matrix in Z

% If it is a row vector we transform it to column vector
if isrow(FootCenter)
    FootCenter = FootCenter';
end

plot(ZMP(1,1),ZMP(2,1),['o',LineType],'HandleVisibility','off') % Begining
hold on
plot(ZMP(1,end),ZMP(2,end),['x',LineType],'HandleVisibility','off') % Ending
hold on
plot(ZMP(1,:),ZMP(2,:),LineType,'HandleVisibility','off') % Trajectory
%axis equal
title('ZMP evolution');
ylabel('y [m]');
xlabel('x [m]');
% Footprint -> foot lenght = lenght2Ankle + length2toes
x1 = -FootLength2Ankle;   % x1y1-------x2y2
y1 = +FootWidth/2;        %  |          |
x2 = +FootLength2toes;    %  |    FC    |
y2 = +FootWidth/2;        %  |          |
x3 = +FootLength2toes;    % x4y4-------x3y3
y3 = -FootWidth/2;
x4 = -FootLength2Ankle;
y4 = -FootWidth/2;
v1 = FootCenter + RotZ_01*[x1;y1];  % v1--------- v2
v2 = FootCenter + RotZ_01*[x2;y2];  %  |          |
v3 = FootCenter + RotZ_01*[x3;y3];  %  |    FC    |
v4 = FootCenter + RotZ_01*[x4;y4];  %  |          |
                                    % v4--------- v3

% plot([x1,x2,x3,x4,x1],[y1,y2,y3,y4,y1],'--','color', [0.5 0.5 0.5]) % to draw with gray color
plot([v1(1),v2(1),v3(1),v4(1),v1(1)],[v1(2),v2(2),v3(2),v4(2),v1(2)],'--','color', [0.5 0.5 0.5],'HandleVisibility','off') % to draw with gray color

