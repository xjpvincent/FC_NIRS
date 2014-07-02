function varargout = FC_NIRS_qcTailorData(varargin)
% FC_NIRS_QCTAILORDATA MATLAB code for FC_NIRS_qcTailorData.fig
%      FC_NIRS_QCTAILORDATA, by itself, creates a new FC_NIRS_QCTAILORDATA or raises the existing
%      singleton*.
%
%      H = FC_NIRS_QCTAILORDATA returns the handle to a new FC_NIRS_QCTAILORDATA or the handle to
%      the existing singleton*.
%
%      FC_NIRS_QCTAILORDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FC_NIRS_QCTAILORDATA.M with the given input arguments.
%
%      FC_NIRS_QCTAILORDATA('Property','Value',...) creates a new FC_NIRS_QCTAILORDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FC_NIRS_qcTailorData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FC_NIRS_qcTailorData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FC_NIRS_qcTailorData

% Last Modified by GUIDE v2.5 01-Jul-2014 17:32:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FC_NIRS_qcTailorData_OpeningFcn, ...
                   'gui_OutputFcn',  @FC_NIRS_qcTailorData_OutputFcn, ...
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


% --- Executes just before FC_NIRS_qcTailorData is made visible.
function FC_NIRS_qcTailorData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FC_NIRS_qcTailorData (see VARARGIN)

% Choose default command line output for FC_NIRS_qcTailorData
handles.output = hObject;
if length(varargin)==1
    handles.father_handles=varargin{1};
    set(handles.father_handles.input_directory,'Enable','off');
    set(handles.father_handles.choose_directory,'Enable','off');
    set(handles.father_handles.raw_sublist,'Enable','off');
    set(handles.father_handles.select_sublist,'Enable','off');
    set(handles.father_handles.raw2select,'Enable','off');
    set(handles.father_handles.select2raw,'Enable','off');
    set(handles.father_handles.all2select,'Enable','off');
    set(handles.father_handles.all2select,'Enable','off');
    set(handles.father_handles.output_directory,'Enable','off');
    set(handles.father_handles.choose_outdirectory,'Enable','off');
end
global SIGNAL_TYPE2;
global DISPLAY_DATA;
%set the popbuttion;
var_name=fieldnames(DISPLAY_DATA);
if israwdata(var_name)
    showsignal(1)=1;
else
    showsignal(1)=0;
end
if isprocOD(var_name)
     showsignal(2)=1;
else
    showsignal(2)=0;
end
if israwConc(var_name)
     showsignal(3)=1;
else
    showsignal(3)=0;
end
if isprocConc(var_name)
     showsignal(4)=1;
else
    showsignal(4)=0;
end
%SIGNAL_TYPE2
signal_type=SIGNAL_TYPE2(find(showsignal==1));
set(handles.signal_type1,'String',signal_type);

fc_NIRS_plottailorSDG(hObject, eventdata, handles);
fc_NIRS_plottailorData(hObject, eventdata, handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FC_NIRS_qcTailorData wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FC_NIRS_qcTailorData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_nirs_displaySTD(hObject, eventdata, handles);
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



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startTime=str2num(get(handles.edit_startTime,'String'));
preTime=str2num(get(handles.edit_preTime,'String'));
postTime=str2num(get(handles.edit_postTime,'String'));
global DISPLAY_DATA;
data_fieldnames=fieldnames(DISPLAY_DATA);
for k=1:size(data_fieldnames,1)
    switch data_fieldnames{k,1}
        case 'rawdata'
            t=DISPLAY_DATA.rawdata.t;
            d=DISPLAY_DATA.rawdata.d;
            tindex=find(t>(startTime-preTime)&t<(startTime+postTime));
            t=t(tindex)-t(tindex(1));
            d=d(tindex,:);
            DISPLAY_DATA.rawdata.t=t;
            DISPLAY_DATA.rawedata.d=d;
        case 'procOD'
            t=DISPLAY_DATA.procOD.t;
            dod=DISPLAY_DATA.procOD.dod;
            tindex=find(t>(startTime-preTime)&t<(startTime+postTime));
            t=t(tindex)-t(tindex(1));
            dod=dod(tindex,:);
            DISPLAY_DATA.procOD.t=t;
            DISPLAY_DATA.procOD.dod=dod;           
        case 'rawConc'
            t=DISPLAY_DATA.rawConc.t;
            HbO=DISPLAY_DATA.rawConc.HbO;
            HbR=DISPLAY_DATA.rawConc.HbR;
            HbT=DISPLAY_DATA.rawConc.HbT;
            tindex=find(t>(startTime-preTime)&t<(startTime+postTime));
            t=t(tindex)-t(tindex(1));
            HbO=HbO(tindex,:);
            HbR=HbR(tindex,:);
            HbT=HbT(tindex,:);
            DISPLAY_DATA.rawConc.t=t;
            DISPLAY_DATA.rawConc.HbO=HbO;
            DISPLAY_DATA.rawConc.HbR=HbR;
            DISPLAY_DATA.rawConc.HbT=HbT;
        case 'procConc'
            t=DISPLAY_DATA.procConc.t;
            HbO=DISPLAY_DATA.procConc.HbO;
            HbR=DISPLAY_DATA.procConc.HbR;
            HbT=DISPLAY_DATA.procConc.HbT;
            tindex=find(t>(startTime-preTime)&t<(startTime+postTime));
            t=t(tindex)-t(tindex(1));
            HbO=HbO(tindex,:);
            HbR=HbR(tindex,:);
            HbT=HbT(tindex,:);
            DISPLAY_DATA.procConc.t=t;
            DISPLAY_DATA.procConc.HbO=HbO;
            DISPLAY_DATA.procConc.HbR=HbR;
            DISPLAY_DATA.procConc.HbT=HbT;
     end
end
set(handles.edit_startTime,'String','0');
set(handles.edit_preTime,'String','0');
set(handles.edit_postTime,'String','');
fc_NIRS_plotData(hObject, eventdata, handles);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in signal_type1.
function signal_type1_Callback(hObject, eventdata, handles)
% hObject    handle to signal_type1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global SIGNAL_TYPE2;
global SIGNAL_TYPE3;
global SIGNAL_TYPE4;
global DISPLAY_STATE;

sig=get(hObject,'String');
val=get(hObject,'Value');
sig_selected=sig{val};
%var_name=sig(val);
% if strcmp(sig_selected)
%     DISPLAY_STATE.signal_type1=1;
% elseif isprocOD(var_name)
%     DISPLAY_STATE.signal_type1=2;
% elseif israwConc(var_name)
%      DISPLAY_STATE.signal_type1=3;
% elseif isprocConc(var_name)
%      DISPLAY_STATE.signal_type1=4;
% end
for index=1:size(SIGNAL_TYPE2,1)
    if strcmp(sig_selected,SIGNAL_TYPE2{index,1})
    DISPLAY_STATE.signal_type1=index;
    end
end


DISPLAY_STATE.signal_type2=1;
if strcmp(sig_selected,SIGNAL_TYPE2{3,1})|...
        strcmp(sig_selected,SIGNAL_TYPE2{4,1})
    set(handles.signal_type2,'String',SIGNAL_TYPE4);
    set(handles.signal_type2,'Value',1);
else
    set(handles.signal_type2,'String',SIGNAL_TYPE3);
    set(handles.signal_type2,'Value',1);
end
% Hints: contents = cellstr(get(hObject,'String')) returns signal_type1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from signal_type1


% --- Executes during object creation, after setting all properties.
function signal_type1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signal_type1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in signal_type2.
function signal_type2_Callback(hObject, eventdata, handles)
% hObject    handle to signal_type2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
val=get(hObject,'Value');
DISPLAY_STATE.signal_type2=val;
%display the Data

% Hints: contents = cellstr(get(hObject,'String')) returns signal_type2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from signal_type2


% --- Executes during object creation, after setting all properties.
function signal_type2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signal_type2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_startTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_startTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_NIRS_plotData(hObject, eventdata, handles);
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



function edit_preTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_preTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_NIRS_plotData(hObject, eventdata, handles);
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



function edit_postTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_postTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_NIRS_plotData(hObject, eventdata, handles);
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


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
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
    return;
end

startTime=str2num(get(handles.edit_startTime,'String'));
preTime=str2num(get(handles.edit_preTime,'String'));
postTime=str2num(get(handles.edit_postTime,'String'));
global DISPLAY_DATA;
data_fieldnames=fieldnames(DISPLAY_DATA);
for k=1:size(data_fieldnames,1)
    switch data_fieldnames{k,1}
        case 'rawdata'
            t=DISPLAY_DATA.rawdata.t;
            d=DISPLAY_DATA.rawdata.d;
            tindex=find(t>(startTime-preTime)&t<(startTime+postTime));
            t=t(tindex)-t(tindex(1));
            d=d(tindex,:);
            DISPLAY_DATA.rawdata.t=t;
            DISPLAY_DATA.rawedata.d=d;
        case 'procOD'
            t=DISPLAY_DATA.procOD.t;
            dod=DISPLAY_DATA.procOD.dod;
            tindex=find(t>(startTime-preTime)&t<(startTime+postTime));
            t=t(tindex)-t(tindex(1));
            dod=dod(tindex,:);
            DISPLAY_DATA.procOD.t=t;
            DISPLAY_DATA.procOD.dod=dod;           
        case 'rawConc'
            t=DISPLAY_DATA.rawConc.t;
            HbO=DISPLAY_DATA.rawConc.HbO;
            HbR=DISPLAY_DATA.rawConc.HbR;
            HbT=DISPLAY_DATA.rawConc.HbT;
            tindex=find(t>(startTime-preTime)&t<(startTime+postTime));
            t=t(tindex)-t(tindex(1));
            HbO=HbO(tindex,:);
            HbR=HbR(tindex,:);
            HbT=HbT(tindex,:);
            DISPLAY_DATA.rawConc.t=t;
            DISPLAY_DATA.rawConc.HbO=HbO;
            DISPLAY_DATA.rawConc.HbR=HbR;
            DISPLAY_DATA.rawConc.HbT=HbT;
        case 'procConc'
            t=DISPLAY_DATA.procConc.t;
            HbO=DISPLAY_DATA.procConc.HbO;
            HbR=DISPLAY_DATA.procConc.HbR;
            HbT=DISPLAY_DATA.procConc.HbT;
            tindex=find(t>(startTime-preTime)&t<(startTime+postTime));
            t=t(tindex)-t(tindex(1));
            HbO=HbO(tindex,:);
            HbR=HbR(tindex,:);
            HbT=HbT(tindex,:);
            DISPLAY_DATA.procConc.t=t;
            DISPLAY_DATA.procConc.HbO=HbO;
            DISPLAY_DATA.procConc.HbR=HbR;
            DISPLAY_DATA.procConc.HbT=HbT;
     end
end
set(handles.edit_startTime,'String','0');
set(handles.edit_preTime,'String','0');
set(handles.edit_postTime,'String','');
fc_NIRS_plotData(hObject, eventdata, handles);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
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
    return;
end

global DISPLAY_DATA;
output_directory=get(handles.father_handles.output_directory,'String');
raw_sublist=get(handles.father_handles.raw_sublist,'String');
selectValue=get(handles.father_handles.raw_sublist,'Value');
if isempty(raw_sublist)
    return;
end
selectName=raw_sublist{selectValue};
savepath=fullfile(output_directory,selectName);
save(savepath,'DISPLAY_DATA');
select_sublist=get(handles.father_handles.select_sublist,'String');
select_sublist=[select_sublist;raw_sublist(selectValue')];
raw_sublist(selectValue')=[];
if isempty(raw_sublist)
     set(handles.father_handles.raw_sublist,'Value',0);
 else
     set(handles.father_handles.raw_sublist,'Value',1);
     selectValue=raw_sublist{1};
     input=get(handles.father_handles.input_directory,'String');
     DISPLAY_DATA=importdata(fullfile(input,selectValue));
     axes_std=handles.father_handles.axesDisplaySTD;
     axes(axes_std);
     cla;
     axes_corr=handles.father_handles.axes_CorrMatrix;
     axes(axes_corr);
     cla;
     axes_snr=handles.father_handles.axes_opticalSNR;
     axes(axes_snr);
     cla;
     axes_std=handles.father_handles.axesstdSDG;
     axes(axes_std);
     cla;
     fc_NIRS_plotstdSDG(hObject, eventdata, handles.father_handles);
end
if isempty(select_sublist)
    set(handles.father_handles.select_sublist,'Value',0);
else
    set(handles.father_handles.select_sublist,'Value',1);
end
if ~(exist(output_directory,'dir')==7)
    mkdir(fullfile(output_directory));
end   
set(handles.father_handles.raw_sublist,'String',raw_sublist);
set(handles.father_handles.select_sublist,'String',select_sublist);
%delete the figure , destroying the data; recover the father window
figure1_DeleteFcn(hObject, eventdata, handles);
%close the current figure;
close(handles.figure1);

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.father_handles.input_directory,'Enable','on');
set(handles.father_handles.choose_directory,'Enable','on');
set(handles.father_handles.raw_sublist,'Enable','on');
set(handles.father_handles.select_sublist,'Enable','on');
set(handles.father_handles.raw2select,'Enable','on');
set(handles.father_handles.select2raw,'Enable','on');
set(handles.father_handles.all2select,'Enable','on');
set(handles.father_handles.all2select,'Enable','on');
set(handles.father_handles.output_directory,'Enable','on');
set(handles.father_handles.choose_outdirectory,'Enable','on');


% --- Executes on button press in select_Ch.
function select_Ch_Callback(hObject, eventdata, handles)
% hObject    handle to select_Ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.all_Ch,'Value',0);
else
    set(hObject,'Value',1);
end
fc_nirs_plottailorData(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of select_Ch


% --- Executes on button press in all_Ch.
function all_Ch_Callback(hObject, eventdata, handles)
% hObject    handle to all_Ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.select_Ch,'Value',0);
else
    set(hObject,'Value',1);
end
fc_nirs_plottailorData(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of all_Ch




%judge is exist rawdata;
function [r]=israwdata(var_name)
r=0;
x=strfind(var_name,'rawdata');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
    end
end
%is exist procOD;
function [r]=isprocOD(var_name)
r=0;
x=strfind(var_name,'procOD');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
    end
end
%is exist procConc
function [r]=isprocConc(var_name)
r=0;
x=strfind(var_name,'procConc');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
    end
end

function [r]=israwConc(var_name)
r=0;
x=strfind(var_name,'rawConc');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
    end
end


% --- Executes during object creation, after setting all properties.
function axestailorSDG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axestailorSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axestailorSDG


% --- Executes on mouse press over axes background.
function axestailorSDG_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axestailorSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_NIRS_AxestailorSDG_buttondown(hObject, eventdata, handles)
