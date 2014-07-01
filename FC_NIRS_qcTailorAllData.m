function varargout = FC_NIRS_qcTailorAllData(varargin)
% FC_NIRS_QCTAILORALLDATA MATLAB code for FC_NIRS_qcTailorAllData.fig
%      FC_NIRS_QCTAILORALLDATA, by itself, creates a new FC_NIRS_QCTAILORALLDATA or raises the existing
%      singleton*.
%
%      H = FC_NIRS_QCTAILORALLDATA returns the handle to a new FC_NIRS_QCTAILORALLDATA or the handle to
%      the existing singleton*.
%
%      FC_NIRS_QCTAILORALLDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FC_NIRS_QCTAILORALLDATA.M with the given input arguments.
%
%      FC_NIRS_QCTAILORALLDATA('Property','Value',...) creates a new FC_NIRS_QCTAILORALLDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FC_NIRS_qcTailorAllData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FC_NIRS_qcTailorAllData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FC_NIRS_qcTailorAllData

% Last Modified by GUIDE v2.5 01-Jul-2014 18:14:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FC_NIRS_qcTailorAllData_OpeningFcn, ...
                   'gui_OutputFcn',  @FC_NIRS_qcTailorAllData_OutputFcn, ...
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


% --- Executes just before FC_NIRS_qcTailorAllData is made visible.
function FC_NIRS_qcTailorAllData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FC_NIRS_qcTailorAllData (see VARARGIN)

% Choose default command line output for FC_NIRS_qcTailorAllData
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FC_NIRS_qcTailorAllData wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FC_NIRS_qcTailorAllData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_startTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_startTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_startTime as text
%        str2double(get(hObject,'String')) returns contents of edit_startTime as a double


% --- Executes during object creation, after setting all properties.
function edit_startTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_startTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_postTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_postTime as text
%        str2double(get(hObject,'String')) returns contents of edit_postTime as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_postTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_postTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_postTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_postTime as text
%        str2double(get(hObject,'String')) returns contents of edit_postTime as a double


% --- Executes during object creation, after setting all properties.
function edit_postTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_postTime (see GCBO)
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

%get start time;
startTime=str2num(get(handles.edit_startTime,'String'));
preTime=str2num(get(handles.edit_preTime,'String')); 
postTime=str2num(get(handles.edit_postTime,'String'));
value_flag=[1 1 1];
if isempty(startTime)
    value_flag(1)=0;
end
%get pre time;

   
if isempty(preTime)
    value_flag(2)=0;
end
%get post time
   
if isempty(postTime)
    value_flag(3)=0;
end
if sum(value_flag)<3
    for tmp=1:5
    if value_flag(1)==0;
        set(handles.edit_startTime,'BackgroundColor',[1 0 0]);
    end
    if value_flag(2)==0;
        set(handles.edit_preTime,'BackgroundColor',[1 0 0]);
    end
    if value_flag(3)==0;
        set(handles.edit_postTime,'BackgroundColor',[1 0 0]);
    end
    pause(0.1);
     if value_flag(1)==0;
        set(handles.edit_startTime,'BackgroundColor',[1 1 1]);
    end
    if value_flag(2)==0;
        set(handles.edit_preTime,'BackgroundColor',[1 1 1]);
    end
    if value_flag(3)==0;
        set(handles.edit_postTime,'BackgroundColor',[1 1 1]);
    end
    pause(0.1);
    end
end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_preTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_preTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_preTime as text
%        str2double(get(hObject,'String')) returns contents of edit_preTime as a double


% --- Executes during object creation, after setting all properties.
function edit_preTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_preTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
