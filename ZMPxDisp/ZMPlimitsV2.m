
function ZMPlimitsV2(ZMPMax,ZMPMin,FootCenter)
% Footprint -> foot lenght = lenght2Ankle + length2toes
x1 = ZMPMin(1);         % x1y1-------x2y2
y1 = ZMPMax(2);        %  |          |
x2 = ZMPMax(1);        %  |    FC    |
y2 = ZMPMax(2);        %  |          |
x3 = ZMPMax(1);        % x4y4-------x3y3
y3 = ZMPMin(2);
x4 = ZMPMin(1); 
y4 = ZMPMin(2); 
v1 = FootCenter + [x1,y1];  % v1--------- v2
v2 = FootCenter + [x2,y2];  %  |          |
v3 = FootCenter + [x3,y3];  %  |    FC    |
v4 = FootCenter + [x4,y4];  %  |          |
                             % v4--------- v3

% plot([x1,x2,x3,x4,x1],[y1,y2,y3,y4,y1],'--','color', [0.5 0.5 0.5]) % to draw with gray color
plot([v1(1),v2(1),v3(1),v4(1),v1(1)],[v1(2),v2(2),v3(2),v4(2),v1(2)],'--','color', [1 0 0],'HandleVisibility','off') % to draw with gray color

