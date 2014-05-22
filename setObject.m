function setObject(hObject, eventdata, handles)
global GUI_DATA;

% fig_processing=guihandles(GUI_DATA.handles);
if ~isempty(GUI_DATA.currentData)
set(handles.radio_od2con,'Enable','on');
set(handles.radio_od2con,'Enable','on');
set(handles.precessing_run,'Enable','on');
set(handles.radio_detrend,'Enable','on');
set(handles.radio_bpfilter,'Enable','on');
x=get(handles.radio_tRange,'Enable');
set(handles.radio_tRange,'Enable','on');
set(handles.check_current,'Enable','on');
set(handles.check_group,'Enable','on');
set(handles.radio_OD,'Enable','on');
set(handles.wavelength,'Enable','on');
%set(handles.edit_detrend,'Enable','on');
set(handles.hpf_text,'Enable','on');
set(handles.lpf_text,'Enable','on');
set(handles.data_tRange,'Enable','on');
set(handles.radio_Conc,'Enable','off');
set(handles.conc_type,'Enable','off');

drawnow;
%set(handles.conc_type,'Enable','on');
%set(handles.radio_Conc,'Enable','on');
end
end