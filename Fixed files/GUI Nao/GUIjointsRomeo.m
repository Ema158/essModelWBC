function varargout = GUIjointsRomeo(varargin)
% GUIJOINTSROMEO MATLAB code for GUIjointsRomeo.fig
%      GUIJOINTSROMEO, by itself, creates a new GUIJOINTSROMEO or raises the existing
%      singleton*.
%
%      H = GUIJOINTSROMEO returns the handle to a new GUIJOINTSROMEO or the handle to
%      the existing singleton*.
%
%      GUIJOINTSROMEO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIJOINTSROMEO.M with the given input arguments.
%
%      GUIJOINTSROMEO('Property','Value',...) creates a new GUIJOINTSROMEO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIjointsRomeo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIjointsRomeo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIjointsRomeo

% Last Modified by GUIDE v2.5 11-Sep-2019 12:31:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIjointsRomeo_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIjointsRomeo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% IMPORTANT
% To modify GUI write "guide" in the comand display and open the existing GUI file, i.e. "GUIjointsRomeo".

% --- Executes just before GUIjointsRomeo is made visible.
function GUIjointsRomeo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIjointsRomeo (see VARARGIN)

% Choose default command line output for GUIjointsRomeo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GUIjointsRomeo wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% =========================================
% Initializarion of ROMEO GUI
Initialization;
% handles % uncomment this to see in the "command display" all the handles we have acces and can be used in all the functions
% ------------------------------------------

% --- Outputs from this function are returned to the command line.
function varargout = GUIjointsRomeo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% -------------------------------------------------------------------------------------------------------------
% ENDING. I create this function by right click on the background of the GUI interface -> View Callbacks -> DeleteFcn
% This code is executed before closing the GUI
% --------------------------------------------------------------------------------------------------------------
% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ----------------------------------------------------------------------------------------------
% Code executed when GUI is closed:
global continueCode
continueCode = 1; % This variable is created to notify to MATLAB that the GUI was closed
% ----------------------------------------------------------------------------------------------

% -------------------------------------------------------------------------------------------------------------
% RESIZING. I create this function by right click on the background of the GUI interface -> View Callbacks -> SizeChangedFcn
% This code is executed before closing the GUI
% --------------------------------------------------------------------------------------------------------------
% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% =====================================================================================================
% The code above was done to move the figures and panels if the GUI is resized (it was not very good).
% However it was commented since I found a better way to do it in MATLAB 2016b! =P
% In the GUI editor go to: Tools -> GUI Options... -> Resize behavior - > Proporcional
% In this way the GUI will be resizeble and all the components will keep the same proportion as the original size... 
% In my case this was enough. If I wanted to do something different I could select "non-resizable" an then in the "Inspector"
% of the GUI (double-click on the GUI space) check the oprtion "Resize" and do something as the code above
% =====================================================================================================
% % PositionGUI = get(handles.figure1,'Position');
% % PositionPlot = get(handles.plotRomeo,'Position');
% % PositionPanelJoints = get(handles.Panel_Joints,'Position');
% % PositionPanelFrames = get(handles.Panel_Frames,'Position');
% % widthGUI = PositionGUI(3);
% % heightGUI = PositionGUI(4);
% % PositionPlot(1) = 0.1*widthGUI;     % Set position in X of the plot
% % PositionPlot(4) = heightGUI - 5.5;  % Set height of the plot
% % set(handles.plotRomeo,'Position',PositionPlot);
% % PositionPanelJoints(1) = PositionPlot(1) + PositionPlot(3) + 0.033*widthGUI;  % Set position in X of the panel "Joints"
% % PositionPanelJoints(2) = heightGUI - PositionPanelJoints(4);                  % Set position in Y of the panel "Joints"
% % set(handles.Panel_Joints,'Position',PositionPanelJoints);
% % PositionPanelFrames(1) = PositionPanelJoints(1) + PositionPanelJoints(3);     % Set position in X of the panel "Frames"
% % PositionPanelFrames(2) = PositionPanelJoints(2);                              % Set position in Y of the panel "Frames"
% % set(handles.Panel_Frames,'Position',PositionPanelFrames);

% --- Executes on slider movement.
function sl_q1_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q1 = get(handles.sl_q1,'Value'); % we can use hObject intead of "handles.sl_q1" since hObect is the same in this function
set(handles.ed_q1,'String',num2str(q1,4));
handles.q(1) = q1;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q1_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q1 as text
%        str2double(get(hObject,'String')) returns contents of ed_q1 as a double
% --------------------------------------------------------
% My code
q1 = str2double(get(handles.ed_q1,'String'));
if q1<handles.limits.pos(1,2)
    q1 = handles.limits.pos(1,1);
elseif q1>handles.limits.pos(2,1)
    q1 = handles.limits.pos(2,1);
end
set(handles.sl_q1,'Value',q1);
set(handles.ed_q1,'String',num2str(q1,4));
handles.q(1) = q1;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q2 = get(handles.sl_q2,'Value');
set(handles.ed_q2,'String',num2str(q2,4));
handles.q(2) = q2;
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes during object creation, after setting all properties.
function sl_q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
% --------------------------------------------------------
% My code
q2 = str2double(get(handles.ed_q2,'String'));
if q2<handles.limits.pos(1,2)
    q2 = handles.limits.pos(1,2);
elseif q2>handles.limits.pos(2,2)
    q2 = handles.limits.pos(2,2);
end
set(handles.sl_q2,'Value',q2);
set(handles.ed_q2,'String',num2str(q2,4));
handles.q(2) = q2;
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes during object creation, after setting all properties.
function ed_q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q3_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q3 = get(handles.sl_q3,'Value');
set(handles.ed_q3,'String',num2str(q3,3));
handles.q(3) = q3;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function ed_q3_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q2 as text
%        str2double(get(hObject,'String')) returns contents of ed_q2 as a double
% --------------------------------------------------------
% My code
q3 = str2double(get(handles.ed_q3,'String'));
if q3<handles.limits.pos(1,3)
    q3 = handles.limits.pos(1,3);
elseif q3>handles.limits.pos(2,3)
    q3 = handles.limits.pos(2,3);
end
set(handles.sl_q3,'Value',q3);
set(handles.ed_q3,'String',num2str(q3,4));
handles.q(3) = q3;
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes during object creation, after setting all properties.
function ed_q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q4 = get(handles.sl_q4,'Value');
set(handles.ed_q4,'String',num2str(q4,4));
handles.q(4) = q4;
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes during object creation, after setting all properties.
function sl_q4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ed_q4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
% --------------------------------------------------------
% My code
q4 = str2double(get(handles.ed_q4,'String'));
if q4<handles.limits.pos(1,4)
    q4 = handles.limits.pos(1,4);
elseif q4>handles.limits.pos(2,4)
    q4 = handles.limits.pos(2,4);
end
set(handles.sl_q4,'Value',q4);
set(handles.ed_q4,'String',num2str(q4,4));
handles.q(4) = q4;
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes during object creation, after setting all properties.
function ed_q4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q5_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q5 = get(hObject,'Value'); 
set(handles.ed_q5,'String',num2str(q5,4));
handles.q(5) = q5;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ed_q5_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q5 as text
%        str2double(get(hObject,'String')) returns contents of ed_q5 as a double
% --------------------------------------------------------
% My code
q5 = str2double(get(hObject,'String'));
if q5<handles.limits.pos(1,5)
    q5 = handles.limits.pos(1,5);
elseif q5>handles.limits.pos(2,5)
    q5 = handles.limits.pos(2,5);
end
set(handles.sl_q5,'Value',q5);
set(hObject,'String',num2str(q5,4));
handles.q(5) = q5;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q6_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
dep=q6_q7_dep;
if dep==1
    q7 = get(hObject,'Value'); 
set(handles.ed_q6,'String',num2str(q7,4));
handles.q(7) = q7;
end
q6 = get(hObject,'Value'); 
set(handles.ed_q6,'String',num2str(q6,4));
handles.q(6) = q6;
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes during object creation, after setting all properties.
function sl_q6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ed_q6_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q6 as text
%        str2double(get(hObject,'String')) returns contents of ed_q6 as a double
% --------------------------------------------------------
% My code
dep=q6_q7_dep;
q6 = str2double(get(hObject,'String'));
if q6<handles.limits.pos(1,6)
    q6 = handles.limits.pos(1,6);
elseif q6>handles.limits.pos(2,6)
    q6 = handles.limits.pos(2,6);
end
set(handles.sl_q6,'Value',q6);
set(hObject,'String',num2str(q6,4));
handles.q(6) = q6;
if dep==1
    handles.q(7)=q7;
end
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q7_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q7 = get(hObject,'Value');
set(handles.ed_q7,'String',num2str(q7,4));
handles.q(7) = q7;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ed_q7_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q7 as text
%        str2double(get(hObject,'String')) returns contents of ed_q7 as a double
% --------------------------------------------------------
% My code
q7 = str2double(get(hObject,'String'));
if q7<handles.limits.pos(1,7)
    q7 = handles.limits.pos(1,7);
elseif q7>handles.limits.pos(2,7)
    q7 = handles.limits.pos(2,7);
end
set(handles.sl_q7,'Value',q7);
set(hObject,'String',num2str(q7,4));
handles.q(7) = q7;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q8_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q8 = get(hObject,'Value');
set(handles.ed_q8,'String',num2str(q8,4));
handles.q(8) = q8;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q8_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q8 as text
%        str2double(get(hObject,'String')) returns contents of ed_q8 as a double
% --------------------------------------------------------
% My code
q8 = str2double(get(hObject,'String'));
if q8<handles.limits.pos(1,8)
    q8 = handles.limits.pos(1,8);
elseif q8>handles.limits.pos(2,8)
    q8 = handles.limits.pos(2,8);
end
set(handles.sl_q8,'Value',q8);
set(hObject,'String',num2str(q8,4));
handles.q(8) = q8;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q9_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q9 = get(hObject,'Value');
set(handles.ed_q9,'String',num2str(q9,4));
handles.q(9) = q9;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ed_q9_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q9 as text
%        str2double(get(hObject,'String')) returns contents of ed_q9 as a double
% --------------------------------------------------------
% My code
q9 = str2double(get(hObject,'String'));
if q9<handles.limits.pos(1,9)
    q9 = handles.limits.pos(1,9);
elseif q9>handles.limits.pos(2,9)
    q9 = handles.limits.pos(2,9);
end
set(handles.sl_q9,'Value',q9);
set(hObject,'String',num2str(q9,4));
handles.q(9) = q9;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q10_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q10 = get(hObject,'Value');
set(handles.ed_q10,'String',num2str(q10,4));
handles.q(10) = q10;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q10_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q10 as text
%        str2double(get(hObject,'String')) returns contents of ed_q10 as a double
% --------------------------------------------------------
% My code
q10 = str2double(get(hObject,'String'));
if q10<handles.limits.pos(1,10)
    q10 = handles.limits.pos(1,10);
elseif q10>handles.limits.pos(2,10)
    q10 = handles.limits.pos(2,10);
end
set(handles.sl_q10,'Value',q10);
set(hObject,'String',num2str(q10,4));
handles.q(10) = q10;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q11_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q11 = get(hObject,'Value');
set(handles.ed_q11,'String',num2str(q11,4));
handles.q(11) = q11;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ed_q11_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q11 as text
%        str2double(get(hObject,'String')) returns contents of ed_q11 as a double
% --------------------------------------------------------
% My code
q11 = str2double(get(hObject,'String'));
if q11<handles.limits.pos(1,11)
    q11 = handles.limits.pos(1,11);
elseif q11>handles.limits.pos(2,11)
    q11 = handles.limits.pos(2,11);
end
set(handles.sl_q11,'Value',q11);
set(hObject,'String',num2str(q11,4));
handles.q(11) = q11;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q12_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q12 = get(hObject,'Value');
set(handles.ed_q12,'String',num2str(q12,4));
handles.q(12) = q12;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q12_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q12 as text
%        str2double(get(hObject,'String')) returns contents of ed_q12 as a double
% --------------------------------------------------------
% My code
q12 = str2double(get(hObject,'String'));
if q12<handles.limits.pos(1,12)
    q12 = handles.limits.pos(1,12);
elseif q12>handles.limits.pos(2,12)
    q12 = handles.limits.pos(2,12);
end
set(handles.sl_q12,'Value',q12);
set(hObject,'String',num2str(q12,4));
handles.q(12) = q12;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q13_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q13 = get(hObject,'Value');
set(handles.ed_q13,'String',num2str(q13,4));
handles.q(13) = q13;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q13_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q13 as text
%        str2double(get(hObject,'String')) returns contents of ed_q13 as a double
% --------------------------------------------------------
% My code
q13 = str2double(get(hObject,'String'));
if q13<handles.limits.pos(1,13)
    q13 = handles.limits.pos(1,13);
elseif q13>handles.limits.pos(2,13)
    q13 = handles.limits.pos(2,13);
end
set(handles.sl_q13,'Value',q13);
set(hObject,'String',num2str(q13,4));
handles.q(13) = q13;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q14_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q14 = get(hObject,'Value');
set(handles.ed_q14,'String',num2str(q14,4));
handles.q(14) = q14;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q14_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q14 as text
%        str2double(get(hObject,'String')) returns contents of ed_q14 as a double
% --------------------------------------------------------
% My code
q14 = str2double(get(hObject,'String'));
if q14<handles.limits.pos(1,14)
    q14 = handles.limits.pos(1,14);
elseif q14>handles.limits.pos(2,14)
    q14 = handles.limits.pos(2,14);
end
set(handles.sl_q14,'Value',q14);
set(hObject,'String',num2str(q14,4));
handles.q(14) = q14;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q15_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q15 = get(hObject,'Value');
set(handles.ed_q15,'String',num2str(q15,4));
handles.q(15) = q15;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q15_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q15 as text
%        str2double(get(hObject,'String')) returns contents of ed_q15 as a double
% --------------------------------------------------------
% My code
q15 = str2double(get(hObject,'String'));
if q15<handles.limits.pos(1,15)
    q15 = handles.limits.pos(1,15);
elseif q15>handles.limits.pos(2,15)
    q15 = handles.limits.pos(2,15);
end
set(handles.sl_q15,'Value',q15);
set(hObject,'String',num2str(q15,4));
handles.q(15) = q15;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q16_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q16 = get(hObject,'Value');
set(handles.ed_q16,'String',num2str(q16,4));
handles.q(16) = q16;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q16_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q16 as text
%        str2double(get(hObject,'String')) returns contents of ed_q16 as a double
% --------------------------------------------------------
% My code
q16 = str2double(get(hObject,'String'));
if q16<handles.limits.pos(1,16)
    q16 = handles.limits.pos(1,16);
elseif q16>handles.limits.pos(2,16)
    q16 = handles.limits.pos(2,16);
end
set(handles.sl_q16,'Value',q16);
set(hObject,'String',num2str(q16,4));
handles.q(16) = q16;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q17_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q17 = get(hObject,'Value');
set(handles.ed_q17,'String',num2str(q17,4));
handles.q(17) = q17;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q17_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q17 as text
%        str2double(get(hObject,'String')) returns contents of ed_q17 as a double
% --------------------------------------------------------
% My code
q17 = str2double(get(hObject,'String'));
if q17<handles.limits.pos(1,17)
    q17 = handles.limits.pos(1,17);
elseif q17>handles.limits.pos(2,17)
    q17 = handles.limits.pos(2,17);
end
set(handles.sl_q17,'Value',q17);
set(hObject,'String',num2str(q17,4));
handles.q(17) = q17;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q18_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q18 = get(hObject,'Value');
set(handles.ed_q18,'String',num2str(q18,4));
handles.q(18) = q18;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q18_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q18 as text
%        str2double(get(hObject,'String')) returns contents of ed_q18 as a double
% --------------------------------------------------------
% My code
q18 = str2double(get(hObject,'String'));
if q18<handles.limits.pos(1,18)
    q18 = handles.limits.pos(1,18);
elseif q18>handles.limits.pos(2,18)
    q18 = handles.limits.pos(2,18);
end
set(handles.sl_q18,'Value',q18);
set(hObject,'String',num2str(q18,4));
handles.q(18) = q18;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q19_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q19 = get(hObject,'Value');
set(handles.ed_q19,'String',num2str(q19,4));
handles.q(19) = q19;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q19_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q19 as text
%        str2double(get(hObject,'String')) returns contents of ed_q19 as a double
% --------------------------------------------------------
% My code
q19 = str2double(get(hObject,'String'));
if q19<handles.limits.pos(1,19)
    q19 = handles.limits.pos(1,19);
elseif q19>handles.limits.pos(2,19)
    q19 = handles.limits.pos(2,19);
end
set(handles.sl_q19,'Value',q19);
set(hObject,'String',num2str(q19,4));
handles.q(19) = q19;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q20_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q20 = get(hObject,'Value');
set(handles.ed_q20,'String',num2str(q20,4));
handles.q(20) = q20;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q20_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q20 as text
%        str2double(get(hObject,'String')) returns contents of ed_q20 as a double
% --------------------------------------------------------
% My code
q20 = str2double(get(hObject,'String'));
if q20<handles.limits.pos(1,20)
    q20 = handles.limits.pos(1,20);
elseif q20>handles.limits.pos(2,20)
    q20 = handles.limits.pos(2,20);
end
set(handles.sl_q20,'Value',q20);
set(hObject,'String',num2str(q20,4));
handles.q(20) = q20;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q21_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q21 = get(hObject,'Value');
set(handles.ed_q21,'String',num2str(q21,4));
handles.q(21) = q21;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q21_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q21 as text
%        str2double(get(hObject,'String')) returns contents of ed_q21 as a double
% --------------------------------------------------------
% My code
q21 = str2double(get(hObject,'String'));
if q21<handles.limits.pos(1,21)
    q21 = handles.limits.pos(1,21);
elseif q21>handles.limits.pos(2,21)
    q21 = handles.limits.pos(2,21);
end
set(handles.sl_q21,'Value',q21);
set(hObject,'String',num2str(q21,4));
handles.q(21) = q21;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q22_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q22 = get(hObject,'Value');
set(handles.ed_q22,'String',num2str(q22,4));
handles.q(22) = q22;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q22_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q22 as text
%        str2double(get(hObject,'String')) returns contents of ed_q22 as a double
% --------------------------------------------------------
% My code
q22 = str2double(get(hObject,'String'));
if q22<handles.limits.pos(1,22)
    q22 = handles.limits.pos(1,22);
elseif q22>handles.limits.pos(2,22)
    q22 = handles.limits.pos(2,22);
end
set(handles.sl_q22,'Value',q22);
set(hObject,'String',num2str(q22,4));
handles.q(22) = q22;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q23_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q23 = get(hObject,'Value');
set(handles.ed_q23,'String',num2str(q23,4));
handles.q(23) = q23;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q23_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q23 as text
%        str2double(get(hObject,'String')) returns contents of ed_q23 as a double
% --------------------------------------------------------
% My code
q23 = str2double(get(hObject,'String'));
if q23<handles.limits.pos(1,23)
    q23 = handles.limits.pos(1,23);
elseif q23>handles.limits.pos(2,23)
    q23 = handles.limits.pos(2,23);
end
set(handles.sl_q23,'Value',q23);
set(hObject,'String',num2str(q23,4));
handles.q(23) = q23;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q24_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q24 = get(hObject,'Value');
set(handles.ed_q24,'String',num2str(q24,4));
handles.q(24) = q24;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q24_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q24 as text
%        str2double(get(hObject,'String')) returns contents of ed_q24 as a double
% --------------------------------------------------------
% My code
q24 = str2double(get(hObject,'String'));
if q24<handles.limits.pos(1,24)
    q24 = handles.limits.pos(1,24);
elseif q24>handles.limits.pos(2,24)
    q24 = handles.limits.pos(2,24);
end
set(handles.sl_q24,'Value',q24);
set(hObject,'String',num2str(q24,4));
handles.q(24) = q24;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q25_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q25 = get(hObject,'Value');
set(handles.ed_q25,'String',num2str(q25,4));
handles.q(25) = q25;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q25_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q25 as text
%        str2double(get(hObject,'String')) returns contents of ed_q25 as a double
% --------------------------------------------------------
% My code
q25 = str2double(get(hObject,'String'));
if q25<handles.limits.pos(1,25)
    q25 = handles.limits.pos(1,25);
elseif q25>handles.limits.pos(2,25)
    q25 = handles.limits.pos(2,25);
end
set(handles.sl_q25,'Value',q25);
set(hObject,'String',num2str(q25,4));
handles.q(25) = q25;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q26_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q26 = get(hObject,'Value');
set(handles.ed_q26,'String',num2str(q26,4));
handles.q(26) = q26;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q26_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q26 as text
%        str2double(get(hObject,'String')) returns contents of ed_q26 as a double
% --------------------------------------------------------
% My code
q26 = str2double(get(hObject,'String'));
if q26<handles.limits.pos(1,26)
    q26 = handles.limits.pos(1,26);
elseif q26>handles.limits.pos(2,26)
    q26 = handles.limits.pos(2,26);
end
set(handles.sl_q26,'Value',q26);
set(hObject,'String',num2str(q26,4));
handles.q(26) = q26;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q27_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q27 = get(hObject,'Value');
set(handles.ed_q27,'String',num2str(q27,4));
handles.q(27) = q27;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q27_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q27 as text
%        str2double(get(hObject,'String')) returns contents of ed_q27 as a double
% --------------------------------------------------------
% My code
q27 = str2double(get(hObject,'String'));
if q27<handles.limits.pos(1,27)
    q27 = handles.limits.pos(1,27);
elseif q27>handles.limits.pos(2,27)
    q27 = handles.limits.pos(2,27);
end
set(handles.sl_q27,'Value',q27);
set(hObject,'String',num2str(q27,4));
handles.q(27) = q27;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q28_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q28 = get(hObject,'Value');
set(handles.ed_q28,'String',num2str(q28,4));
handles.q(28) = q28;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q28_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q28 as text
%        str2double(get(hObject,'String')) returns contents of ed_q28 as a double
% --------------------------------------------------------
% My code
q28 = str2double(get(hObject,'String'));
if q28<handles.limits.pos(1,28)
    q28 = handles.limits.pos(1,28);
elseif q28>handles.limits.pos(2,28)
    q28 = handles.limits.pos(2,28);
end
set(handles.sl_q28,'Value',q28);
set(hObject,'String',num2str(q28,4));
handles.q(28) = q28;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q29_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q29 = get(hObject,'Value');
set(handles.ed_q29,'String',num2str(q29,4));
handles.q(29) = q29;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q29_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q29 as text
%        str2double(get(hObject,'String')) returns contents of ed_q29 as a double
% --------------------------------------------------------
% My code
q29 = str2double(get(hObject,'String'));
if q29<handles.limits.pos(1,29)
    q29 = handles.limits.pos(1,29);
elseif q29>handles.limits.pos(2,29)
    q29 = handles.limits.pos(2,29);
end
set(handles.sl_q29,'Value',q29);
set(hObject,'String',num2str(q29,4));
handles.q(29) = q29;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q30_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q30 = get(hObject,'Value');
set(handles.ed_q30,'String',num2str(q30,4));
handles.q(30) = q30;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q30_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q30 as text
%        str2double(get(hObject,'String')) returns contents of ed_q30 as a double
% --------------------------------------------------------
% My code
q30 = str2double(get(hObject,'String'));
if q30<handles.limits.pos(1,30)
    q30 = handles.limits.pos(1,30);
elseif q30>handles.limits.pos(2,30)
    q30 = handles.limits.pos(2,30);
end
set(handles.sl_q30,'Value',q30);
set(hObject,'String',num2str(q30,4));
handles.q(30) = q30;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_q31_Callback(hObject, eventdata, handles)
% hObject    handle to sl_q31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% --------------------------------------------------------
% My code
q31 = get(hObject,'Value');
set(handles.ed_q31,'String',num2str(q31,4));
handles.q(31) = q31;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function sl_q31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_q31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function ed_q31_Callback(hObject, eventdata, handles)
% hObject    handle to ed_q31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_q31 as text
%        str2double(get(hObject,'String')) returns contents of ed_q31 as a double
% --------------------------------------------------------
% My code
q31 = str2double(get(hObject,'String'));
if q31<handles.limits.pos(1,31)
    q31 = handles.limits.pos(1,31);
elseif q31>handles.limits.pos(2,31)
    q31 = handles.limits.pos(2,31);
end
set(handles.sl_q31,'Value',q31);
set(hObject,'String',num2str(q31,4));
handles.q(31) = q31;
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes during object creation, after setting all properties.
function ed_q31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_q31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_Zero.
function PB_Zero_Callback(hObject, eventdata, handles)
% hObject    handle to PB_Zero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.q = zeros(31,1);
% Setting the values for the 31 sliders and edits
for i=1:22
    set(handles.(['sl_q',int2str(i)]),'Value',handles.q(i));
    set(handles.(['ed_q',int2str(i)]),'String',num2str(handles.q(i),4));
end
% Insetad of doing manually for each one... =)
% set(handles.sl_q1,'Value',handles.q(1));
% set(handles.ed_q1,'String',num2str(handles.q(1),4));
% ------------------------------------
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes on button press in PB_Rest.
function PB_Rest_Callback(hObject, eventdata, handles)
% hObject    handle to PB_Rest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.q = zeros(22,1);
% This values comes from "genebot"
% Stand leg
handles.q(2) = 0.1;
handles.q(3) =-0.2;
handles.q(4) = 0.1;
% Free leg
handles.q(9) =-0.1;
handles.q(10)= 0.2;
handles.q(11)=-0.1;
% Right arm
handles.q(13)= 1.6;
handles.q(14)= 0;
handles.q(15)= 1.6;
handles.q(16)= 0.2;
% Left arm
handles.q(17)= 1.6;
handles.q(18)= 0;
handles.q(19)=-1.6;
handles.q(20)=-0.2;
% Setting the values for the 31 sliders and edits
for i=1:22
    set(handles.(['sl_q',int2str(i)]),'Value',handles.q(i));
    set(handles.(['ed_q',int2str(i)]),'String',num2str(handles.q(i),4));
end
% Insetad of doing manually for each one... =)
% set(handles.sl_q1,'Value',handles.q(1));
% set(handles.ed_q1,'String',num2str(handles.q(1),4));
% ------------------------------------
% Moving and plotting ROMEO
PlottingRomeo;


% ========================================================
%           PANEL COMPUTATION
% ========================================================

% --- Executes on button press in PB_Compute.
function PB_Compute_Callback(hObject, eventdata, handles)
% hObject    handle to PB_Compute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Label = get(hObject,'String');
% if strcmp(Label,'Record')
%     set(hObject,'String','Stop');
% else
%     set(hObject,'String','Record');
% end

% In the variable "plots" we chose which plot we want to show...
plots(1) = get(handles.chk_joints,'Value');
plots(2) = get(handles.chk_reaction,'Value');
plots(3) = get(handles.chk_torques,'Value');
plots(4) = get(handles.chk_ZMP,'Value');
plots(5) = get(handles.chk_ZMP,'Value');
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
if max(plots)==1;       
    set(hObject,'String','Computing');
    set(hObject,'Enable','off');    
    samples = 2;
    q = zeros(31,samples);
    Tau = zeros(31,samples);
    F = zeros(3,samples);
    M = zeros(3,samples);
    ZMP = zeros(2,samples);
    if plots(1) == 1 && max(plots)==1  % Only joints are required
        disp('Ploting joints...');
        for i=1:samples
            q(:,i) = handles.q;
        end
    end
    if plots(2) == 1 || plots(3) == 1 || plots(4) == 1
        disp('Compting the reaction wrench, torques and ZMP...');        
        for i=1:samples
            q(:,i) = handles.q;
            [F(:,i ),M(:,i ),Tau(:,i )]= Newton_Euler(handles.q,zeros(31,1),zeros(31,1));
            ZMP(1,i) = -M(2,i)/F(3,i);
            ZMP(2,i) =  M(1,i)/F(3,i);
        end
        disp('Reaction wrench, torques and ZMP computed.');
    end
    set(handles.PB_CloseFig,'Visible','on');
    
    colors = 'krbgymc';
    pos = randi(length(colors));
    LineType = colors(pos);
    FigNum = 5;
    graphix(plots,zeros(4,1),Tau,1:samples,q,zeros(size(q)),zeros(size(q)),F,M,ZMP,LineType,FigNum);
    
    set(hObject,'Enable','on');
    set(hObject,'String','Compute');    
else
    disp('Select one or more options for plotting')
end



% --- Executes on button press in chk_joints.
function chk_joints_Callback(hObject, eventdata, handles)
% hObject    handle to chk_joints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_joints


% --- Executes on button press in chk_reaction.
function chk_reaction_Callback(hObject, eventdata, handles)
% hObject    handle to chk_reaction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_reaction


% --- Executes on button press in chk_torques.
function chk_torques_Callback(hObject, eventdata, handles)
% hObject    handle to chk_torques (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_torques


% --- Executes on button press in chk_ZMP.
function chk_ZMP_Callback(hObject, eventdata, handles)
% hObject    handle to chk_ZMP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_ZMP


% --- Executes on button press in PB_CloseFig.
function PB_CloseFig_Callback(hObject, eventdata, handles)
% hObject    handle to PB_CloseFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Figs = findall(0,'type','figure');
if size(Figs,1)>1
    close(1:Figs(2).Number);
end
set(handles.PB_CloseFig,'Visible','off');

% ========================================================
%           PANEL FRAMES
% ========================================================
% --- Executes on button press in chk_frame1.
function chk_frame1_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame1

% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame2.
function chk_frame2_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame2
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame3.
function chk_frame3_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame3
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame4.
function chk_frame4_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame4
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame5.
function chk_frame5_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame5
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame6.
function chk_frame6_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame6
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame7.
function chk_frame7_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame7
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame8.
function chk_frame8_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame8
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame9.
function chk_frame9_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame9
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame10.
function chk_frame10_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame10
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame11.
function chk_frame11_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame11
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame12.
function chk_frame12_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame12
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame13.
function chk_frame13_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame13
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame14.
function chk_frame14_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame14
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame15.
function chk_frame15_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame15
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame16.
function chk_frame16_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame16
% Moving and plotting ROMEO
PlottingRomeo;
% --- Executes on button press in chk_frame17.
function chk_frame17_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame17
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame18.
function chk_frame18_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame18
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame19.
function chk_frame19_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame19
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame20.
function chk_frame20_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame20
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame21.
function chk_frame21_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame21
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame22.
function chk_frame22_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame22
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame23.
function chk_frame23_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame23
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame24.
function chk_frame24_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame24
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame25.
function chk_frame25_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame25
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame26.
function chk_frame26_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame26
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame27.
function chk_frame27_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame27
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame28.
function chk_frame28_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame28
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame29.
function chk_frame29_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame29
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame30.
function chk_frame30_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame30
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame31.
function chk_frame31_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame31
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame32.
function chk_frame32_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame32
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame33.
function chk_frame33_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame33
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame34.
function chk_frame34_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame34
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame35.
function chk_frame35_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame35
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_frame36.
function chk_frame36_Callback(hObject, eventdata, handles)
% hObject    handle to chk_frame36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_frame36
% Moving and plotting ROMEO
PlottingRomeo;
val = 1; % this variable will make an "AND chain", and it would be true only if ALL check_frames are checked. =)
for i=1:27 % number of frames
    val = val && get(handles.(['chk_frame',int2str(i)]),'Value');    
end
if val
    set(handles.chk_allFrames,'Value',1);
else
    set(handles.chk_allFrames,'Value',0);
end

% --- Executes on button press in chk_allFrames.
function chk_allFrames_Callback(hObject, eventdata, handles)
% hObject    handle to chk_allFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_allFrames
chk = get(hObject,'Value');
if chk
    for i=1:27 % number of frames
        set(handles.(['chk_frame',int2str(i)]),'Value',1);
    end
else
    for i=1:27 % number of frames
        set(handles.(['chk_frame',int2str(i)]),'Value',0);
    end
end
% Moving and plotting ROMEO
PlottingRomeo;

% --- Executes on button press in chk_AlignFrames.
function chk_AlignFrames_Callback(hObject, eventdata, handles)
% hObject    handle to chk_AlignFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_AlignFrames
% Moving and plotting ROMEO
PlottingRomeo;


% --- Executes on button press in chk_ROS.
function chk_ROS_Callback(hObject, eventdata, handles)
% hObject    handle to chk_ROS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of chk_ROS

if get(hObject,'Value')
    if isunix
        disp('Joint values published for ROS')
        ROSjoints;
    else
        disp('This option is just available for Linux/ROS')
        set(hObject,'Value',0);
        set(hObject,'Enable','off');
    end
else
    disp('Joint values not published for ROS')    
end


% --- Executes on button press in q_dep.
function q_dep_Callback(hObject, eventdata, handles)
% hObject    handle to q_dep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of q_dep
dep=q6_q7_dep;
