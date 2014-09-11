function varargout = FC_NIRS_fcAnalysis(varargin)
% FC_NIRS_FCANALYSIS MATLAB code for FC_NIRS_fcAnalysis.fig
%      FC_NIRS_FCANALYSIS, by itself, creates a new FC_NIRS_FCANALYSIS or raises the existing
%      singleton*.
%
%      H = FC_NIRS_FCANALYSIS returns the handle to a new FC_NIRS_FCANALYSIS or the handle to
%      the existing singleton*.
%
%      FC_NIRS_FCANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FC_NIRS_FCANALYSIS.M with the given input arguments.
%
%      FC_NIRS_FCANALYSIS('Property','Value',...) creates a new FC_NIRS_FCANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FC_NIRS_fcAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FC_NIRS_fcAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FC_NIRS_fcAnalysis

% Last Modified by GUIDE v2.5 14-Jul-2014 00:02:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FC_NIRS_fcAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @FC_NIRS_fcAnalysis_OutputFcn, ...
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


% --- Executes just before FC_NIRS_fcAnalysis is made visible.
function FC_NIRS_fcAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FC_NIRS_fcAnalysis (see VARARGIN)

% Choose default command line output for FC_NIRS_fcAnalysis
global ANALYSIS_PARA;
ANALYSIS_PARA.signal_type=zeros(3,1);
ANALYSIS_PARA.corr_type{1}.name='Pearson';
ANALYSIS_PARA.corr_type{1}.func='fc_pearson';
ANALYSIS_PARA.corr_type{2}.name='Cross';
ANALYSIS_PARA.corr_type{2}.func='fc_cross';
ANALYSIS_PARA.corr_type{3}.name='Spearman';
ANALYSIS_PARA.corr_type{3}.func='fc_spearman';
ANALYSIS_PARA.corr_choose=1;
ANALYSIS_PARA.fc_method='seed-based';
ANALYSIS_PARA.statistic=zeros(4,1);
ANALYSIS_PARA.seed=[];

handles.output = hObject;
set(handles.input_directory,'String',cd);
nirsfile=dir(fullfile(pwd,filesep,'*.proc'));
nirslist=cell(1,length(nirsfile));
if size(nirsfile,1)
for i=1:size(nirsfile,1)
    nirslist{i}=nirsfile(i).name(1:end-12);
end
set(handles.sublist,'String',nirslist);
tmp=importdata(cd,'',nirsfile(1).name);
handles.SD=tmp.SD;
end
%set default directory
set(handles.output_directory,'String',fullfile(cd,'\','fc_Result'));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FC_NIRS_fcAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FC_NIRS_fcAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



input_directory=get(handles.input_directory,'String');
pathnm = uigetdir(input_directory, 'Pick the new directory' );
if pathnm==0
    return;
end
set(handles.input_directory,'String',pathnm);
%set work path
%check whether exist FileFold 'RawData';
if  size(dir(fullfile(pathnm,'*.proc')))<1
    uiwait(msgbox('There is no processed directory in the currently directory, please check your data','Erro'));
    return;
end
%cd(pathnm);
%check whether exist nirs file;
if length(dir(fullfile(pathnm,'*.proc')))<1
    uiwait(msgbox('Your  Folder has no processed proc file, please check it ','Warning'));
    return
end

nirsfile=dir(fullfile(pathnm,'*.proc'));
nirslist=cell(1,size(nirsfile,1));
if size(nirsfile,1)
for i=1:size(nirsfile,1)
    nirslist{i}=nirsfile(i).name;
end
set(handles.sublist,'String',nirslist);
end
 %%set SD
 tmp=importdata(fullfile(pathnm,nirsfile(1).name));
 handles.SD=tmp.SD;



% Update handles structure
guidata(hObject, handles);
% --- Executes on selection change in sublist.
function sublist_Callback(hObject, eventdata, handles)
% hObject    handle to sublist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sublist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sublist


% --- Executes during object creation, after setting all properties.
function sublist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sublist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in Buttion_Seedbased.
function Buttion_Seedbased_Callback(hObject, eventdata, handles)
% hObject    handle to Buttion_Seedbased (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Value',1);
set(handles.Buttion_wholebrain,'Value',0);
set(handles.seed_info,'Visible','on');
set(handles.seed_text,'Visible','on');
global ANALYSIS_PARA;
ANALYSIS_PARA.fc_method='seed-based';
set(handles.button_viewResult1,'Enable','off');
set(handles.button_viewResult2,'Enable','off');
% Hint: get(hObject,'Value') returns toggle state of Buttion_Seedbased


% --- Executes on button press in Buttion_wholebrain.
function Buttion_wholebrain_Callback(hObject, eventdata, handles)
% hObject    handle to Buttion_wholebrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Value',1);
set(handles.Buttion_Seedbased,'Value',0);
set(handles.seed_info,'Visible','off');
set(handles.seed_text,'Visible','off');
global ANALYSIS_PARA;
ANALYSIS_PARA.fc_method='whole-brain';
set(handles.button_viewResult1,'Enable','off');
set(handles.button_viewResult2,'Enable','off');
% Hint: get(hObject,'Value') returns toggle state of Buttion_wholebrain


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on selection change in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns radiobutton3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from radiobutton3


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11


% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12


% --- Executes on button press in checkbox17.
function checkbox17_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox17


% --- Executes on button press in checkbox18.
function checkbox18_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox18


% --- Executes on button press in checkbox19.
function checkbox19_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox19


% --- Executes on button press in checkbox20.
function checkbox20_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox20


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox_HbR.
function checkbox_HbR_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_HbR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ANALYSIS_PARA;
if get(hObject,'Value')
    set(handles.checkbox_All,'Value',0);
    ANALYSIS_PARA.signal_type(2)=1;
else
    ANALYSIS_PARA.signal_type(2)=0;
end
% Hint: get(hObject,'Value') returns toggle state of checkbox_HbR


% --- Executes on button press in checkbox_HbO.
function checkbox_HbO_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_HbO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ANALYSIS_PARA;
if get(hObject,'Value')
    set(handles.checkbox_All,'Value',0);
    ANALYSIS_PARA.signal_type(1)=1;
else
    ANALYSIS_PARA.signal_type(1)=0;
end
% Hint: get(hObject,'Value') returns toggle state of checkbox_HbO


% --- Executes on button press in checkbox_HbT.
function checkbox_HbT_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_HbT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ANALYSIS_PARA;
if get(hObject,'Value')
    set(handles.checkbox_All,'Value',0);
    ANALYSIS_PARA.signal_type(3)=1;
else
    ANALYSIS_PARA.signal_type(3)=0;
end
% Hint: get(hObject,'Value') returns toggle state of checkbox_HbT


% --- Executes on button press in checkbox_All.
function checkbox_All_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_All (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ANALYSIS_PARA;
if get(hObject,'Value')
    set(handles.checkbox_HbO,'Value',1);
    set(handles.checkbox_HbR,'Value',1);
    set(handles.checkbox_HbT,'Value',1);
    ANALYSIS_PARA.signal_type=ones(3,1);
else
    set(handles.checkbox_HbO,'Value',0);
    set(handles.checkbox_HbR,'Value',0);
    set(handles.checkbox_HbT,'Value',0);
    ANALYSIS_PARA.signal_type=zeros(3,1);
end

% Hint: get(hObject,'Value') returns toggle state of checkbox_All


% --- Executes on button press in checkbox_Pcorr.
function checkbox_Pcorr_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Pcorr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.checkbox_Ccorr,'Value',0);
else
    set(hObject,'Value',1);
end
% Hint: get(hObject,'Value') returns toggle state of checkbox_Pcorr


% --- Executes on button press in checkbox_Ccorr.
function checkbox_Ccorr_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Ccorr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.checkbox_Pcorr,'Value',0);
else
    set(hObject,'Value',1);
end
% Hint: get(hObject,'Value') returns toggle state of checkbox_Ccorr



function seed_info_Callback(hObject, eventdata, handles)
% hObject    handle to seed_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ANALYSIS_PARA;
ANALYSIS_PARA.seed=str2num(get(handles.seed_info,'String'));
if isempty(ANALYSIS_PARA.seed)
    for tmp=1:5
        set(handles.seed_info,'BackgroundColor',[1 0 0]);
        pause(0.1);
        set(handles.seed_info,'BackgroundColor',[1 1 1]);
        pause(0.1);
    end
    set(handles.seed_info,'BackgroundColor',[1 0 0]);
else
    set(handles.seed_info,'BackgroundColor',[1 1 1]);
end
% if isempty
% Hints: get(hObject,'String') returns contents of seed_info as text
%        str2double(get(hObject,'String')) returns contents of seed_info as a double


% --- Executes during object creation, after setting all properties.
function seed_info_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seed_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in individual_analysis.
function individual_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to individual_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%set(hObject,'Enable','off');
set(handles.button_viewResult1,'Enable','off');
run_individual_analysis(hObject, eventdata, handles);
set(hObject,'Enable','on');
set(handles.button_viewResult1,'Enable','on');

% --- Executes on button press in button_viewResult1.
function button_viewResult1_Callback(hObject, eventdata, handles)
% hObject    handle to button_viewResult1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.Buttion_Seedbased,'Value')
   fc_type='seed';
end
if get(handles.Buttion_wholebrain,'Value')
    fc_type='wholebrain';
end
if isempty(get(handles.sublist,'String'))
    return;
end

fc_analsysis_viewResult1(get(handles.output_directory,'String'),...
    get(handles.sublist,'String'),...
   fc_type,handles.SD);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(~, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox_R.
function checkbox_R_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.checkbox_AllStatistic,'Value',0);
global ANALYSIS_PARA;
ANALYSIS_PARA.statistic(1)=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of checkbox_R


% --- Executes on button press in checkbox_T.
function checkbox_T_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.checkbox_AllStatistic,'Value',0);
 global ANALYSIS_PARA;
ANALYSIS_PARA.statistic(4)=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of checkbox_T


% --- Executes on button press in checkbox_Z.
function checkbox_Z_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.checkbox_AllStatistic,'Value',0);
  global ANALYSIS_PARA;
ANALYSIS_PARA.statistic(2)=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of checkbox_Z


% --- Executes on button press in checkbox_Z2R.
function checkbox_Z2R_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Z2R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.checkbox_AllStatistic,'Value',0);
   global ANALYSIS_PARA;
ANALYSIS_PARA.statistic(3)=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of checkbox_Z2R


% --- Executes on button press in checkbox_AllStatistic.
function checkbox_AllStatistic_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_AllStatistic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global ANALYSIS_PARA;
if get(hObject,'Value')
    set(handles.checkbox_R,'Value',1);
    set(handles.checkbox_Z,'Value',1);
    set(handles.checkbox_Z2R,'Value',1);
    set(handles.checkbox_T,'Value',1);
     ANALYSIS_PARA.statistic=ones(4,1);
else
    set(handles.checkbox_R,'Value',0);
    set(handles.checkbox_Z,'Value',0);
    set(handles.checkbox_Z2R,'Value',0);
    set(handles.checkbox_T,'Value',0);
     ANALYSIS_PARA.statistic=zeros(4,1);
end
% Hint: get(hObject,'Value') returns toggle state of checkbox_AllStatistic


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%set(hObject,'Enable','off');
set(handles.button_viewResult2,'Enable','off');
set(hObject,'Enable','off');
run_group_analysis(hObject, eventdata, handles);
set(hObject,'Enable','on');
set(handles.button_viewResult2,'Enable','on');
% --- Executes on button press in button_viewResult2.
function button_viewResult2_Callback(hObject, eventdata, handles)
% hObject    handle to button_viewResult2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.Buttion_Seedbased,'Value')
   fc_type='seed';
end
if get(handles.Buttion_wholebrain,'Value')
    fc_type='whole';
end
global SIGNAL_TYPE;
global ANALYSIS_PARA;
%signal_type=SIGNAL_TYPE;
statistic=ANALYSIS_PARA.statistic;
output_directory=get(handles.output_directory,'String');
signal_type=[1 1 1]';
fc_analsysis_viewResult2(output_directory,...
    signal_type,...
   fc_type,handles.SD,statistic);


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathnm = uigetdir(cd, 'Pick the new directory' );
if pathnm==0
    return;
end
set(handles.output_directory,'String',pathnm)



function output_directory_Callback(hObject, eventdata, handles)
% hObject    handle to output_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_directory as text
%        str2double(get(hObject,'String')) returns contents of output_directory as a double


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


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ANALYSIS_PARA;
ANALYSIS_PARA.corr_choose=get(hObject,'Value');;
% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
