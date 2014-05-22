function varargout = fc_analsysis_viewResult1(varargin)
% FC_ANALSYSIS_VIEWRESULT1 MATLAB code for fc_analsysis_viewResult1.fig
%      FC_ANALSYSIS_VIEWRESULT1, by itself, creates a new FC_ANALSYSIS_VIEWRESULT1 or raises the existing
%      singleton*.
%
%      H = FC_ANALSYSIS_VIEWRESULT1 returns the handle to a new FC_ANALSYSIS_VIEWRESULT1 or the handle to
%      the existing singleton*.
%
%      FC_ANALSYSIS_VIEWRESULT1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FC_ANALSYSIS_VIEWRESULT1.M with the given input arguments.
%
%      FC_ANALSYSIS_VIEWRESULT1('Property','Value',...) creates a new FC_ANALSYSIS_VIEWRESULT1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fc_analsysis_viewResult1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fc_analsysis_viewResult1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fc_analsysis_viewResult1

% Last Modified by GUIDE v2.5 21-May-2014 22:57:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fc_analsysis_viewResult1_OpeningFcn, ...
                   'gui_OutputFcn',  @fc_analsysis_viewResult1_OutputFcn, ...
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


% --- Executes just before fc_analsysis_viewResult1 is made visible.
function fc_analsysis_viewResult1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fc_analsysis_viewResult1 (see VARARGIN)

% Choose default command line output for fc_analsysis_viewResult1
handles.output = hObject;

if nargin<2
    %error
    return;
end
handles.workplace=varargin{1};
handles.sublist=varargin{2};
handles.fc_type=varargin{3};
handles.SD=varargin{4};
global SIGNAL_TYPE;
if SIGNAL_TYPE(1)==1
    set(handles.checkbox_HbO,'Enable','on');
else
      %  set(handles.checkbox_HbO,'Enable','off');
end
if SIGNAL_TYPE(2)==1
    set(handles.checkbox_HbR,'Enable','on');
else
        set(handles.checkbox_HbR,'Enable','off');
end
if SIGNAL_TYPE(3)==1
    set(handles.checkbox_HbT,'Enable','on');
else
    set(handles.checkbox_HbT,'Enable','off');
end
% Update handles structure
set(handles.subjects_list,'String',handles.sublist);

guidata(hObject, handles);

% UIWAIT makes fc_analsysis_viewResult1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fc_analsysis_viewResult1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox_HbR.
function checkbox_HbR_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_HbR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.checkbox_HbO,'Value',0);
    set(handles.checkbox_HbT,'Value',0);
else
    set(hObject,'Value',1);
end
plot_individualResult(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox_HbR


% --- Executes on button press in checkbox_HbO.
function checkbox_HbO_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_HbO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.checkbox_HbR,'Value',0);
    set(handles.checkbox_HbT,'Value',0);
else
    set(hObject,'Value',1);
end
plot_individualResult(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox_HbO


% --- Executes on button press in checkbox_HbT.
function checkbox_HbT_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_HbT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.checkbox_HbO,'Value',0);
    set(handles.checkbox_HbR,'Value',0);
else
    set(hObject,'Value',1);
end
plot_individualResult(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox_HbT


% --- Executes on selection change in subjects_list.
function subjects_list_Callback(hObject, eventdata, handles)
% hObject    handle to subjects_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_individualResult(hObject, eventdata, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns subjects_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from subjects_list


% --- Executes during object creation, after setting all properties.
function subjects_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subjects_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
