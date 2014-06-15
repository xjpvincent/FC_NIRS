function varargout = FC_NIRS_preprocessing(varargin)
% FC_NIRS_PREPROCESSING MATLAB code for FC_NIRS_preprocessing.fig
%      FC_NIRS_PREPROCESSING, by itself, creates a new FC_NIRS_PREPROCESSING or raises the existing
%      singleton*.
%
%      H = FC_NIRS_PREPROCESSING returns the handle to a new FC_NIRS_PREPROCESSING or the handle to
%      the existing singleton*.
%
%      FC_NIRS_PREPROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FC_NIRS_PREPROCESSING.M with the given input arguments.
%
%      FC_NIRS_PREPROCESSING('Property','Value',...) creates a new FC_NIRS_PREPROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FC_NIRS_preprocessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FC_NIRS_preprocessing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FC_NIRS_preprocessing

% Last Modified by GUIDE v2.5 03-Jun-2014 17:09:52

% Begin initialization code - DO NOT EDIT
%
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FC_NIRS_preprocessing_OpeningFcn, ...
                   'gui_OutputFcn',  @FC_NIRS_preprocessing_OutputFcn, ...
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


% --- Executes just before FC_NIRS_preprocessing is made visible.
function FC_NIRS_preprocessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FC_NIRS_preprocessing (see VARARGIN)

% Choose default command line output for FC_NIRS_preprocessing
%define global variable

global PARA_LIST;
global CAL_LIST;
global Method_LIST;
Method_LIST=get(handles.MethodList,'String');
CAL_LIST=[];
%init the PARA_LIST
PARA_LIST=cell(4,1);
PARA_LIST{1,1}=struct('name','OD2Conc',...
    'discription','Discription:Convert optical density to concentrations.T',...
    'para','[6 6]',...
    'para_info','pathlength factors for each wavelength',...
    'func','fc_nirs_OD2Conc');
PARA_LIST{2,1}=struct('name','Detrend',...
    'discription','Discription:Default values is 1.',...
    'para','[1]',...
    'para_info','The degrees of polynomial curve fitting:',...
    'func','fc_nirs_Detrend');
PARA_LIST{3,1}=struct('name','BandPass Filter',...
    'discription','BandPass Filter,hpf -high pass filter frequency(Hz). default value[0.01 0.1]',...
    'para','[0.01 0.1]',...
    'para_info','BandPass Filter(Hz)[lpf hpf]:',...
    'func','fc_nirs_BandpassFilt');

PARA_LIST{4,1}=struct('name','Analysis tRange',...
    'discription','The the time range to analysis ',...
    'para','[0 0]',...
    'para_info','Analysis time range(s):',...
     'func','fc_nirs_tRange');

set(handles.input_directory,'String',cd);
set(handles.output_directory,'String',strcat(cd,'\procData'));
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FC_NIRS_preprocessing wait for user response (see UIRESUME)
% uiwait(handles.fig_processing);


% --- Outputs from this function are returned to the command line.
function varargout = FC_NIRS_preprocessing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in main_networkanaysis.
function main_networkanaysis_Callback(hObject, eventdata, handles)
% hObject    handle to main_networkanaysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_networkanaysis



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in display_datalist.
function display_datalist_Callback(hObject, eventdata, handles)
% hObject    handle to display_datalist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns display_datalist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from display_datalist



% --- Executes during object creation, after setting all properties.
function display_datalist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display_datalist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in main_precessing.
function main_precessing_Callback(hObject, eventdata, handles)
% hObject    handle to main_precessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_precessing


% --- Executes on button press in main_qc.
function main_qc_Callback(hObject, eventdata, handles)
% hObject    handle to main_qc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_qc


% --------------------------------------------------------------------
function menu_file_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function file_directory_Callback(hObject, eventdata, handles)
% hObject    handle to file_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
change_directory(hObject, eventdata, handles)



% --------------------------------------------------------------------
function menu_exit_Callback(hObject, eventdata, handles)
% hObject    handle to menu_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close

% --------------------------------------------------------------------
function nirs_tools_Callback(hObject, eventdata, handles)
% hObject    handle to nirs_tools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tools_covert_Callback(hObject, eventdata, handles)
% hObject    handle to tools_covert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axesSDG_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axesSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
restNIRS_AxesSDG_buttondown(hObject, eventdata, handles)


% --- Executes on key press with focus on display_datalist and none of its controls.
function display_datalist_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to display_datalist (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over display_datalist.
function display_datalist_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to display_datalist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in precessing_run.
function precessing_run_Callback(hObject, eventdata, handles)
% hObject    handle to precessing_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set(hObject,'Enable','off');
drawnow;
fc_NIRS_RUN_preprocessing(hObject, eventdata, handles)
set(hObject,'Enable','on');
drawnow;

% --- Executes on button press in radio_detrend.
function radio_detrend_Callback(hObject, eventdata, handles)
% hObject    handle to radio_detrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(hObject,'Value')>0)
    set(handles.edit_detrend,'Enable','on');
    return ;
end
set(handles.edit_detrend,'Enable','off');
% Hint: get(hObject,'Value') returns toggle state of radio_detrend


% --- Executes on button press in radio_od2con.
function radio_od2con_Callback(hObject, eventdata, handles)
% hObject    handle to radio_od2con (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_od2con


% --- Executes on button press in radio_bpfilter.
function radio_bpfilter_Callback(hObject, eventdata, handles)
% hObject    handle to radio_bpfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_bpfilter


% --- Executes on button press in radio_tRange.
function radio_tRange_Callback(hObject, eventdata, handles)
% hObject    handle to radio_tRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_tRange



function data_tRange_Callback(hObject, eventdata, handles)
% hObject    handle to data_tRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
settRange(hObject,eventdata,handles);
% Hints: get(hObject,'String') returns contents of data_tRange as text
%        str2double(get(hObject,'String')) returns contents of data_tRange as a double


% --- Executes during object creation, after setting all properties.
function data_tRange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_tRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on selection change in wavelength.
function wavelength_Callback(hObject, eventdata, handles)
% hObject    handle to wavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns wavelength contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wavelength
global GUI_DATA;
fig_processing=guihandles(GUI_DATA.fig_processing);
if get(fig_processing.radio_OD,'Value')
    GUI_DATA.plotstate.plotOD=get(fig_processing.wavelength,'Value');
else
    GUI_DATA.plotstate.plotOD=0;
end
%display Data
%set object 
plotSDG();
displayData();

% --- Executes during object creation, after setting all properties.
function wavelength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over precessing_run.
function precessing_run_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to precessing_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function hpf_text_Callback(hObject, eventdata, handles)
% hObject    handle to hpf_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hpf_text as text
%        str2double(get(hObject,'String')) returns contents of hpf_text as a double


% --- Executes during object creation, after setting all properties.
function hpf_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hpf_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lpf_text_Callback(hObject, eventdata, handles)
% hObject    handle to lpf_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lpf_text as text
%        str2double(get(hObject,'String')) returns contents of lpf_text as a double


% --- Executes during object creation, after setting all properties.
function lpf_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lpf_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on precessing_run and none of its controls.
function precessing_run_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to precessing_run (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in check_current.
function check_current_Callback(hObject, eventdata, handles)
% hObject    handle to check_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end
if get(hObject,'Value')>0
    set(handles.check_group,'Value',0);
end


% Hint: get(hObject,'Value') returns toggle state of check_current


% --- Executes on button press in check_group.
function check_group_Callback(hObject, eventdata, handles)
% hObject    handle to check_group (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end
if get(hObject,'Value')>0
    set(handles.check_current,'Value',0);
end
% Hint: get(hObject,'Value') returns toggle state of check_group


% --- Executes on button press in radio_OD.
function radio_OD_Callback(hObject, eventdata, handles)
% hObject    handle to radio_OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI_DATA;
fig_processing=guihandles(GUI_DATA.fig_processing);
GUI_DATA.plotstate.plotOD=get(fig_processing.wavelength,'Value');
 set(fig_processing.wavelength,'Enable','on');
GUI_DATA.plotstate.Conc=0;
if(get(hObject,'Value')>0)
    set(fig_processing.radio_Conc,'Value',0);
    set(fig_processing.conc_type,'Enable','off');
end
%display Data
displayData();
% Hint: get(hObject,'Value') returns toggle state of radio_OD

    






% --- Executes on button press in radio_Conc.
function radio_Conc_Callback(hObject, eventdata, handles)
% hObject    handle to radio_Conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
GUI_DATA.plotstate.Conc=get(hObject,'Value');
%handles=guihandles(GUI_DATA.handles);
set(handles.conc_type,'Enable','on');
%handles=guihandles(GUI_DATA.handles);
if(get(hObject,'Value')>0)
    set(handles.radio_OD,'Value',0);
    set(handles.wavelength,'Enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of radio_Conc
%display Data
displayData(hObject, eventdata, handles);


% --- Executes on selection change in conc_type.
function conc_type_Callback(hObject, eventdata, handles)
% hObject    handle to conc_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI_DATA;
GUI_DATA.plotstate.Conc=get(hObject,'Value');
% Hints: contents = cellstr(get(hObject,'String')) returns conc_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from conc_type
%display Data

displayData(hObject, eventdata, handles);
plotSDG(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function conc_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conc_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_detrend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_detrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_detrend as text
%        str2double(get(hObject,'String')) returns contents of edit_detrend as a double


% --- Executes during object creation, after setting all properties.
function edit_detrend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_detrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over main_precessing.
function main_precessing_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to main_precessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on data_tRange and none of its controls.
function data_tRange_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to data_tRange (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11


% --- Executes on button press in radiobutton12.
function radiobutton12_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton12



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton13.
function radiobutton13_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton13


% --- Executes on button press in radiobutton14.
function radiobutton14_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton14



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_selectedch.
function radio_selectedch_Callback(hObject, eventdata, handles)
% hObject    handle to radio_selectedch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
%handles=guihandles(GUI_DATA.handles);
GUI_DATA.plotstate.plotType=get(handles.radio_selectedch,'Value');
set(handles.radio_allch,'Value',0);
plotSDG(hObject, eventdata, handles);
displayData(hObject, eventdata, handles);



% Hint: get(hObject,'Value') returns toggle state of radio_selectedch


% --- Executes on button press in radio_allch.
function radio_allch_Callback(hObject, eventdata, handles)
% hObject    handle to radio_allch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
GUI_DATA.plotstate.plot=[];
GUI_DATA.plotstate.plotLst=[];
GUI_DATA.plotstate.plotType=get(handles.radio_allch,'Value')+1;
set(handles.radio_selectedch,'Value',0);
plotSDG(hObject, eventdata, handles);
displayData(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radio_allch


% --- Executes during object deletion, before destroying properties.
function handles_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to handles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
clear GUI_DATA;


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ParentDir=uigetdir(pwd , 'Pick parent directory of dataset');
select_inputDirectory(hObject, eventdata, handles);
%fc_NIRS_plotSDG(hObject, eventdata, handles);
    
function select_inputDirectory(hObject, eventdata, handles)
pathnm = uigetdir(cd, 'Pick the new directory' );
if pathnm==0
    return;
end
set(handles.input_directory,'String',pathnm)
%probe the existing file.
nirsfilelist=dir(strcat(pathnm,'\','*.nirs'));
%procfilelist=dir(strcat(pathnm,'\','*.proc'));
datalist=[];
if size(nirsfilelist,1)>0
    for fileidx=1:size(nirsfilelist,1)
        datalist{fileidx,1}=nirsfilelist(fileidx).name;
    end
end
%set the input datalist.
%set(handles.
set(handles.display_datalist,'String',datalist);




function directory_place_Callback(hObject, eventdata, handles)
% hObject    handle to input_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_directory as text
%        str2double(get(hObject,'String')) returns contents of input_directory as a double


% --- Executes during object creation, after setting all properties.
function directory_place_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function fig_processing_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to fig_processing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function input_directory_Callback(hObject, eventdata, handles)
% hObject    handle to input_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_directory as text
%        str2double(get(hObject,'String')) returns contents of input_directory as a double


% --- Executes during object creation, after setting all properties.
function input_directory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathnm = uigetdir(cd, 'Pick the new directory' );
if pathnm==0
    return;
end
set(handles.output_directory,'String',pathnm)



% --- Executes on selection change in MethodList.
function MethodList_Callback(hObject, eventdata, handles)
% hObject    handle to MethodList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MethodList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MethodList


% --- Executes during object creation, after setting all properties.
function MethodList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MethodList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ConfigListbox.
function ConfigListbox_Callback(hObject, eventdata, handles)
% hObject    handle to ConfigListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ConfigListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ConfigListbox


% --- Executes during object creation, after setting all properties.
function ConfigListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ConfigListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CalListbox.
function CalListbox_Callback(hObject, eventdata, handles)
% hObject    handle to CalListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if get(gcf , 'SelectionType') , 'normal')
% end
% Hints: contents = cellstr(get(hObject,'String')) returns CalListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CalListbox
global PARA_LIST;
inputpara=[];
if strcmp(get(gcf,'SelectionType'),'alt')
    %inputpara=inputdlg()
elseif strcmp(get(gcf,'SelectionType'),'normal')
    %inputpara=inputdlg()
elseif strcmp(get(gcf,'SelectionType'),'open')
    callist=get(handles.CalListbox,'String');
    selectValue=get(handles.CalListbox,'Value');
    if isempty(callist)
    return;
    end
    %assign the processing parameters 
    %corresponding to processing method;
%     inputpara=inputdlg(callist{selectValue},'parameters');
%     inputpara=inputpara{1};
% if ~isempty(inputpara)
for i=1:size(PARA_LIST,1)
    if ~isempty(strfind(PARA_LIST{i,1}.name,callist{selectValue,1}))
        %inputpara=inputdlg(callist{selectValue},'parameters',PARA_LIST{i,1}.para);
        inputpara=inputdlg(callist{selectValue},'parameters',1,{PARA_LIST{i,1}.para});
        if isempty(inputpara)
            return;        
        end
        inputpara=inputpara{1};
        if ~isempty(inputpara)
            PARA_LIST{i,1}.para=inputpara;
        end
        %set(handles.
        break;
    end
    %   end
end

%set the processing information
%    set(handles.ConfigListbox,'String',inputpara);
end

%show the processing information
callist=get(handles.CalListbox,'String');
selectValue=get(handles.CalListbox,'Value');
if isempty(callist)
    return;
end

% if ~isempty(inputpara)
% set(handles.ConfigListbox,'String',...
%     strcat(callist{selectValue,1},inputpara));
% end
%display the method information;
display_methodInfo(hObject, eventdata, handles);
% --- Executes during object creation, after setting all properties.
function CalListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CalListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

methodlist=get(handles.MethodList,'String');
if ~isempty(methodlist)
    selectValue=get(handles.MethodList,'Value');
    calList=get(handles.CalListbox,'String');
    calList=[calList;methodlist(selectValue')];
    %CAL_LIST=[CAL_LIST;methodlist(selectValue')];
    methodlist(selectValue')=[];
    if isempty(methodlist)
        set(handles.MethodList,'Value',0);
    else 
        set(handles.MethodList,'Value',1);
    end
     if isempty(calList)
        set(handles.CalListbox,'Value',0);
    else 
        set(handles.CalListbox,'Value',1);
    end
    set(handles.MethodList,'String',methodlist);
    set(handles.CalListbox,'String',calList);

end
display_methodInfo(hObject, eventdata, handles);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%add by xjp.14/6/3
global CAL_LIST;
calList=get(handles.CalListbox,'String');
if ~isempty(calList)
    selectValue=get(handles.CalListbox,'Value');
    methodlist=get(handles.MethodList,'String');
    methodlist=[methodlist;calList(selectValue')];
    calList(selectValue')=[];
    if isempty(methodlist)
        set(handles.MethodList,'Value',0);
    else 
        set(handles.MethodList,'Value',1);
    end
     if isempty(calList)
        set(handles.CalListbox,'Value',0);
    else 
        set(handles.CalListbox,'Value',1);
    end
    set(handles.MethodList,'String',methodlist);
    set(handles.CalListbox,'String',calList);
    CAL_LIST=calList;
end
display_methodInfo(hObject, eventdata, handles);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%show the raw data;
input_directory=get(handles.input_directory,'String');
FC_NIRS_displayTimeseries(input_directory);

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%show the result;
output_directory=get(handles.output_directory,'String');
FC_NIRS_displayTimeseries(output_directory);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CAL_LIST;
calList=get(handles.CalListbox,'String');
if size(calList,1)<2|get(handles.CalListbox,'Value')<2;
    return
else
    selectValue=get(handles.CalListbox,'Value');
    %swap the processing methods
    tmp=calList(selectValue,1);
    calList(selectValue,1)=calList(selectValue-1,1);
    calList(selectValue-1,1)=tmp;
    set(handles.CalListbox,'String',calList);
    set(handles.CalListbox,'Value',selectValue-1);
end
CAL_LIST=get(handles.CalListbox,'String');
display_methodInfo(hObject, eventdata, handles);

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CAL_LIST;
calList=get(handles.CalListbox,'String');
if size(calList,1)<2|get(handles.CalListbox,'Value')...
        >(size(calList,1)-1)
    return
else
    selectValue=get(handles.CalListbox,'Value');
    %swap the processing methods
    tmp=calList(selectValue,1);
    calList(selectValue,1)=calList(selectValue+1,1);
    calList(selectValue+1,1)=tmp;
    set(handles.CalListbox,'String',calList);
    set(handles.CalListbox,'Value',selectValue+1);
end
CAL_LIST=get(handles.CalListbox,'String');
display_methodInfo(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function output_directory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function display_methodInfo(hObject, eventdata, handles)
% hObject    handle to output_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global PARA_LIST;
calList=get(handles.CalListbox,'String');
selectValue=get(handles.CalListbox,'Value');
if isempty(calList)
   return; 
end
selected_method=calList{selectValue,1};

for i=1:size(PARA_LIST,1)
    if ~isempty(strfind(PARA_LIST{i,1}.name,selected_method))
        tmp=cell(4,1);
        tmp{1,1}=PARA_LIST{i,1}.name;
        tmp{2,1}=strcat('.',PARA_LIST{i,1}.para_info,':');
        tmp{3,1}=strcat('..',PARA_LIST{i,1}.para);
        tmp{4,1}=strcat('.',PARA_LIST{i,1}.discription);
        set(handles.ConfigListbox,'String',tmp);
        set(handles.ConfigListbox,'Value',1);
        %set(handles.
        break;
    end
end
%PARA_LIST
%strfind
