% Plotting of the new configuration of Romeo
% As this part of the code repeats in many functions it was place in this file
% ---------------------------------------------------------------------------

% By using the current joint position "q" the robot stucture is computed
handles.robot = robot_move(handles.robot,handles.q); 
% Store the value of the view of the figure to keep the same view after ploting..
handles.viewFigure = get(handles.plotRomeo,'View');
hold off 
plot(0,0,'x'); % I need to plot anything else to erase the previous drawing of the robot ¬¬
hold off
% plotting of ROMEO
robot_draw(handles.robot,handles.SupportFootPos(1),handles.SupportFootPos(2))  % Support on the RIGHT foot
% ----------------------
% plotting of the frames
for i=1:27 % number of frames
    chk = get(handles.(['chk_frame',int2str(i)]),'Value');
    if chk    % if is checked plot the frame
        if get(handles.chk_AlignFrames,'Value') % if "AlignFrames" is checked we plot the frames aligned with frame 0 in ZERO position
            plot_frames(handles.robot.T(:,:,i)*handles.robot.Tconst(:,:,i),'r',.05,0); %(TT, COLOR, Size, OPT)
        else
            plot_frames(handles.robot.T(:,:,i),'b',.05,0); %(TT, COLOR, Size, OPT)
        end
    end
end
% ----------------------
axis equal
% Plotting of the ground
hold on
[X,Y] = meshgrid(-0.1:0.05:0.3,-0.1:0.4:0.3);
Z = zeros(size(X));
surf(X,Y,Z)
% The instruction "colormap(map)" was defined in "Initialization.m" % this instructtion paint the surface according to "map"
grid on
% Set the stored value of the view to the figure
set(handles.plotRomeo,'View',handles.viewFigure);
% Since we are changing our data we need to upgrade again our structure "handles" 
guidata(hObject, handles);
% -------------------------------------------------------------------
% Publish values of ROS
chk = get(handles.chk_ROS,'Value');
if chk
    ROSjoints;
end
% -------------------------------------------------------------------