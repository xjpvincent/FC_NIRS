function varargout = restNIRS(varargin)
% RESTNIRS MATLAB code for restNIRS.fig
%      RESTNIRS, by itself, creates a new RESTNIRS or raises the existing
%      singleton*.
%
%      H = RESTNIRS returns the handle to a new RESTNIRS or the handle to
%      the existing singleton*.
%
%      RESTNIRS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESTNIRS.M with the given input arguments.
%
%      RESTNIRS('Property','Value',...) creates a new RESTNIRS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before restNIRS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to restNIRS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help restNIRS

% Last Modified by GUIDE v2.5 09-May-2014 15:21:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @restNIRS_OpeningFcn, ...
                   'gui_OutputFcn',  @restNIRS_OutputFcn, ...
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


% --- Executes just before restNIRS is made visible.
function restNIRS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to restNIRS (see VARARGIN)

% Choose default command line output for restNIRS
%define global variable
global GUI_DATA;
GUI_DATA.fig_processing=hObject;
GUI_DATA=initGUI_DATA(hObject,varargin);
%GUI_DATA.
%GUI_DATA.handles=handles;
% set working directory
 %change_directory()

% %import data 
% 
% imported_data = importdata(strcat(pathname,filename));
% GUI_DATA.rawdata=imported_data;
% GUI_DATA.rawdata.SD.MeasListVis=GUI_DATA.rawdata.SD.MeasListAct;

%plot the sources and detectors
%axesSDG(handles);
%plotSDG(handles,hObject);
%display Data
%displayData();
%setObject();
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes restNIRS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = restNIRS_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on selection change in display_directory.
function display_directory_Callback(hObject, eventdata, handles)
% hObject    handle to display_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns display_directory contents as cell array
%        contents{get(hObject,'Value')} returns selected item from display_directory
global GUI_DATA;

n=get(handles.display_directory,'Value');
filelist=get(handles.display_directory,'String');
plot_subject=filelist{n};
imported_data = importdata(strcat(GUI_DATA.plotstate.workpath,'\','RawData\',plot_subject));
GUI_DATA.rawdata=imported_data;
GUI_DATA.rawdata.SD.MeasListVis=GUI_DATA.rawdata.SD.MeasListAct;
GUI_DATA.currentData=imported_data;
GUI_DATA.currentData.SD.MeasListVis=GUI_DATA.rawdata.SD.MeasListAct;

%Update the displays
plotSDG();
displayData();


% --- Executes during object creation, after setting all properties.
function display_directory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display_directory (see GCBO)
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
change_directory()



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


% --- Executes on key press with focus on display_directory and none of its controls.
function display_directory_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to display_directory (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over display_directory.
function display_directory_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to display_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in precessing_run.
function precessing_run_Callback(hObject, eventdata, handles)
% hObject    handle to precessing_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI_DATA
restNIRS_Preprocessing();

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
if get(GUI_DATA.handles.radio_OD,'Value')
    GUI_DATA.plotstate.plotOD=get(GUI_DATA.handles.wavelength,'Value');
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
if get(hObject,'Value')>0
    set(GUI_DATA.handles.check_group,'Value',0);
end

% Hint: get(hObject,'Value') returns toggle state of check_current


% --- Executes on button press in check_group.
function check_group_Callback(hObject, eventdata, handles)
% hObject    handle to check_group (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
if get(hObject,'Value')>0
    set(GUI_DATA.handles.check_current,'Value',0);
end
% Hint: get(hObject,'Value') returns toggle state of check_group


% --- Executes on button press in radio_OD.
function radio_OD_Callback(hObject, eventdata, handles)
% hObject    handle to radio_OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GUI_DATA;
GUI_DATA.plotstate.plotOD=get(GUI_DATA.handles.wavelength,'Value');
if(get(hObject,'Value')>0)
    set(GUI_DATA.handles.radio_Conc,'Value',0);
end
%display Data
displayData();
setObject();
% Hint: get(hObject,'Value') returns toggle state of radio_OD

    






% --- Executes on button press in radio_Conc.
function radio_Conc_Callback(hObject, eventdata, handles)
% hObject    handle to radio_Conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
GUI_DATA.plotstate.Conc=get(hObject,'Value');
if(get(hObject,'Value')>0)
    set(GUI_DATA.handles.radio_OD,'Value',0);
end
% Hint: get(hObject,'Value') returns toggle state of radio_Conc
%display Data
displayData();
setObject();

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

displayData();
plotSDG();



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
