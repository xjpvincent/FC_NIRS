function varargout = fc_analsysis_viewResult2(varargin)
% FC_ANALSYSIS_VIEWRESULT2 MATLAB code for fc_analsysis_viewResult2.fig
%      FC_ANALSYSIS_VIEWRESULT2, by itself, creates a new FC_ANALSYSIS_VIEWRESULT2 or raises the existing
%      singleton*.
%
%      H = FC_ANALSYSIS_VIEWRESULT2 returns the handle to a new FC_ANALSYSIS_VIEWRESULT2 or the handle to
%      the existing singleton*.
%
%      FC_ANALSYSIS_VIEWRESULT2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FC_ANALSYSIS_VIEWRESULT2.M with the given input arguments.
%
%      FC_ANALSYSIS_VIEWRESULT2('Property','Value',...) creates a new FC_ANALSYSIS_VIEWRESULT2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fc_analsysis_viewResult2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fc_analsysis_viewResult2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fc_analsysis_viewResult2

% Last Modified by GUIDE v2.5 22-May-2014 00:37:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fc_analsysis_viewResult2_OpeningFcn, ...
                   'gui_OutputFcn',  @fc_analsysis_viewResult2_OutputFcn, ...
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


% --- Executes just before fc_analsysis_viewResult2 is made visible.
function fc_analsysis_viewResult2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fc_analsysis_viewResult2 (see VARARGIN)

% Choose default command line output for fc_analsysis_viewResult2
handles.output = hObject;
handles.workplace=varargin{1};
handles.signal_type=varargin{2};
handles.fc_type=varargin{3};
handles.SD=varargin{4};
tmp=handles.signal_type;
tmp=tmp.*[1 2 3]';
tmp(find(tmp==0))=[];
signal_str={'HbO','HbR','HbT'};
set(handles.popupmenu_signalType,'String',signal_str(tmp));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fc_analsysis_viewResult2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fc_analsysis_viewResult2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox_R.
function checkbox_R_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.checkbox_Z,'Value',0);
    set(handles.checkbox_Z2R,'Value',0);
    set(handles.checkbox_T,'Value',0);
else
    set(hObject,'Value',1);
end
plot_groupResult(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox_R


% --- Executes on button press in checkbox_T.
function checkbox_T_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.checkbox_Z,'Value',0);
    set(handles.checkbox_Z2R,'Value',0);
    set(handles.checkbox_R,'Value',0);
else
    set(hObject,'Value',1);
end
plot_groupResult(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox_T


% --- Executes on button press in checkbox_Z.
function checkbox_Z_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.checkbox_R,'Value',0);
    set(handles.checkbox_Z2R,'Value',0);
    set(handles.checkbox_T,'Value',0);
else
    set(hObject,'Value',1);
end
plot_groupResult(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox_Z


% --- Executes on button press in checkbox_Z2R.
function checkbox_Z2R_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Z2R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.checkbox_Z,'Value',0);
    set(handles.checkbox_R,'Value',0);
    set(handles.checkbox_T,'Value',0);
else
    set(hObject,'Value',1);
end
plot_groupResult(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox_Z2R


% --- Executes on selection change in popupmenu_signalType.
function popupmenu_signalType_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_signalType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_signalType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_signalType


% --- Executes during object creation, after setting all properties.
function popupmenu_signalType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_signalType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
