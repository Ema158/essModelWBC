function dep=q6_q7_dep
handles = guidata(gcf);
dep=get(handles.q_dep,'Value');
if dep
    dep=1;
else
    dep=0;
end
if dep==1
    set(handles.sl_q7,'visible','off');
    set(handles.t_q7,'visible','off');
    set(handles.ed_q7,'visible','off');
else
    set(handles.sl_q7,'visible','on');
    set(handles.t_q7,'visible','on');
    set(handles.ed_q7,'visible','on');
end