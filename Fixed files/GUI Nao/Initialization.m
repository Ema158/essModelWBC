% GUI initialization
% ============================

% Robot structure is generated
% global robot
handles.robot = genebot();
% --------------------------------------------------------
% Support foot position
xs = 0;
ys = 0;

% We create the variable "limits" and we add it to the structure "handles"
% "handles" is a variable used to share data among all the functions in the GUI
% limits of the joints
handles.limits = limits();
% lim.pos - > Array 2x31 First line minimum position, 2nd line maimum position
% Setting of the maximum and minimum value for each position (sliders)
for i=1:24
    set(handles.(['sl_q',int2str(i)]),'Min',handles.limits.pos(1,i));
    set(handles.(['sl_q',int2str(i)]),'Max',handles.limits.pos(2,i));
end
% Using loop instead of:
% set(handles.sl_q1,'Min',handles.limits.pos(1,1));
% set(handles.sl_q1,'Max',handles.limits.pos(2,1));
% set(handles.sl_q2,'Min',handles.limits.pos(1,2));
% set(handles.sl_q2,'Max',handles.limits.pos(2,2));
% ...
% ...
% set(handles.sl_q31,'Min',handles.limits.pos(1,31));
% set(handles.sl_q31,'Max',handles.limits.pos(2,31));
% 

handles.q = zeros(31,1);
handles.SupportFootPos = [0,0]; % x0,y0

% Moving and plotting ROMEO
% ---------------------------------------------
% This part of the code is very similar to "Plotting Romeo". However, in here since it is the firt ploting, we don't
% need to erease anything or store the "previous view" of the figure.
% ---------------------------------------------
handles.robot = robot_move(handles.robot,handles.q); 
robot_draw(handles.robot,handles.SupportFootPos(1),handles.SupportFootPos(2))  % Support on the RIGHT foot
axis equal
% Plotting ground
hold on
[X,Y] = meshgrid(-0.1:0.05:0.3,-0.1:0.4:0.3);
Z = zeros(size(X));
surf(X,Y,Z)
%      R  G   B   % Usually a map is builded like this...
% map = [0, 0, 0.3
%     0, 0, 0.4
%     0, 0, 0.5
%     0, 0, 0.6
%     0, 0, 0.8
%     0, 0, 1.0];
% but in this case since I know is just a flat surface... i just gonna use one color:
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
color = [0.79,0.79,0.79]; % light gray
map = color;
colormap(map) % this instructtion paint the surface according to "map"
grid on
handles.viewFigure = get(handles.plotRomeo,'View');

% This code is neccesary to add the structure "handles"
% We upgrade the variable "handles" (since we have added our variable "limits" to it)
handles.output = hObject;
% We upgrade the variable "handles" (since we have added our variable "limits" to it)
guidata(hObject, handles);


