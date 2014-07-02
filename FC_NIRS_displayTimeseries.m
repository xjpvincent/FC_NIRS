function varargout = FC_NIRS_displayTimeseries(varargin)
% FC_NIRS_DISPLAYTIMESERIES MATLAB code for FC_NIRS_displayTimeseries.fig
%      FC_NIRS_DISPLAYTIMESERIES, by itself, creates a new FC_NIRS_DISPLAYTIMESERIES or raises the existing
%      singleton*.
%
%      H = FC_NIRS_DISPLAYTIMESERIES returns the handle to a new FC_NIRS_DISPLAYTIMESERIES or the handle to
%      the existing singleton*.
%
%      FC_NIRS_DISPLAYTIMESERIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FC_NIRS_DISPLAYTIMESERIES.M with the given input arguments.
%
%      FC_NIRS_DISPLAYTIMESERIES('Property','Value',...) creates a new FC_NIRS_DISPLAYTIMESERIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FC_NIRS_displayTimeseries_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FC_NIRS_displayTimeseries_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FC_NIRS_displayTimeseries

% Last Modified by GUIDE v2.5 01-Jun-2014 11:41:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FC_NIRS_displayTimeseries_OpeningFcn, ...
                   'gui_OutputFcn',  @FC_NIRS_displayTimeseries_OutputFcn, ...
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


% --- Executes just before FC_NIRS_displayTimeseries is made visible.
function FC_NIRS_displayTimeseries_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FC_NIRS_displayTimeseries (see VARARGIN)
% Choose default command line output for FC_NIRS_displayTimeseries

%add by xjp.
%clear the command window
clc;
handles.output = hObject;
handles.clearflag=0;
if length(varargin)==1;
    set(handles.input_directory,'String',varargin{1});
elseif  length(varargin)==2;
    set(handles.input_directory,'String',varargin{1});
    handles.clearflag=varargin{2};
else
    set(handles.input_directory,'String',pwd);
end

%set global variable;
global SIGNAL_TYPE1;
global SIGNAL_TYPE2;
global SIGNAL_TYPE3;
global SIGNAL_TYPE4;
global DISPLAY_STATE;
global DISPLAY_DATA;
DISPLAY_STATE.signal_type1=1;
DISPLAY_STATE.signal_type2=1;
DISPLAY_STATE.plotType=0;
DISPLAY_STATE.color=[0 0 1; 
             0 1 0;
             1 0 0;
             1 .5 0;
             1 0 1;
             0 1 1;
             0.5 0.5 1;
             0.5 1 0.5;
             1 0.5 0.5;
             1 0.5 1;
             0.5 1 1;
             0 0 0;
             0.2 0.2 0.2;
             0.4 0.4 0.4;
             0.6 0.6 0.6;
             0.8 0.8 0.8];
DISPLAY_DATA=[];
SIGNAL_TYPE1={'proc Intensity'};
SIGNAL_TYPE2={'raw Data';'proc OD';'raw Conc';'proc Conc'};
SIGNAL_TYPE3={'Wavelength1';'Wavelength2'};
SIGNAL_TYPE4={'HbO';'HbR';'HbT'};

%probe the existing file.
pathnm=get(handles.input_directory,'String');
nirsfilelist=dir(fullfile(pathnm,'*.nirs'));
procfilelist=dir(fullfile(pathnm,'*.proc'));
datalist=[];
if size(nirsfilelist,1)>0
    if size(procfilelist,1)>0
        msgbox('The selected input directory has both nirs and proc format file.','warn'); 
    else
        set(handles.signal_type1,'String',SIGNAL_TYPE1);
        set(handles.signal_type2,'String',SIGNAL_TYPE3);
        set(handles.signal_type1,'Value',1);
        set(handles.signal_type2,'Value',1);
        set(handles.signal_type1,'Enable','on');
        set(handles.signal_type2,'Enable','on');
        set(handles.show_psd,'Enable','on');
        datalist=cell(size(nirsfilelist,1));
         for fileidx=1:size(nirsfilelist,1)
            datalist{fileidx,1}=nirsfilelist(fileidx).name;
         end
    end
else
    if size(procfilelist,1)>0
        datalist=cell(size(procfilelist,1),1); 
        set(handles.signal_type1,'String',SIGNAL_TYPE2);
        set(handles.signal_type2,'String',SIGNAL_TYPE3);
        set(handles.signal_type1,'Value',1);
        set(handles.signal_type2,'Value',1);
        set(handles.display_datalist,'Value',1);
        set(handles.signal_type1,'Enable','on');
        set(handles.signal_type2,'Enable','on');
        set(handles.show_psd,'Enable','on');
        for fileidx=1:size(procfilelist,1)
            datalist{fileidx,1}=procfilelist(fileidx).name;
        end
    end
end
%set the input datalist.
if ~isempty(datalist)
    set(handles.display_datalist,'String',datalist);
    if ~isempty(strfind(datalist{1},'.proc'))
        DISPLAY_DATA=importdata(fullfile(pathnm,'\',datalist{1}));
    end
    if ~isempty(strfind(datalist{1},'.nirs'))
        DISPLAY_DATA.rawdata=importdata(fullfile(pathnm,'\',datalist{1}));
        DISPLAY_DATA.SD=DISPLAY_DATA.rawdata.SD;
    end
else 
    msgbox('The selected input directory has no nirs or proc data.','warn'); 
     set(handles.signal_type1,'Value',1);
    set(handles.signal_type2,'Value',1);
    set(handles.display_datalist,'Value',1);
    set(handles.display_datalist,'String',{'None'});
    set(handles.signal_type1,'String',SIGNAL_TYPE1);
    set(handles.signal_type2,'String',SIGNAL_TYPE3);
    set(handles.signal_type1,'Enable','off');
    set(handles.signal_type2,'Enable','off');
    set(handles.show_psd,'Enable','off'); 
    DISPLAY_DATA=[];
end
if ~isempty(DISPLAY_DATA)
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
  fc_NIRS_plotSDG(hObject, eventdata, handles);
  end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FC_NIRS_displayTimeseries wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FC_NIRS_displayTimeseries_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selected_channels.
function selected_channels_Callback(hObject, eventdata, handles)
% hObject    handle to selected_channels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
if get(hObject,'Value')
    set(handles.all_channels,'Value',0);
    DISPLAY_STATE.plotType=0;
    fc_NIRS_plotData(hObject, eventdata, handles);
else
    set(hObject,'Value',1);
    DISPLAY_STATE.ployType=0;
end
% Hint: get(hObject,'Value') returns toggle state of selected_channels


% --- Executes on button press in all_channels.
function all_channels_Callback(hObject, eventdata, handles)
% hObject    handle to all_channels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
if get(hObject,'Value')
    set(handles.selected_channels,'Value',0);
     DISPLAY_STATE.plotType=1;
    fc_NIRS_plotData(hObject, eventdata, handles);
else
    set(hObject,'Value',1);
     DISPLAY_STATE.ployType=1;
end
% Hint: get(hObject,'Value') returns toggle state of all_channels


% --- Executes on selection change in signal_type1.
function signal_type1_Callback(hObject, eventdata, handles)
% hObject    handle to signal_type1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%select the singal type to display;

global SIGNAL_TYPE1;
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
%display the Data
fc_NIRS_plotData(hObject, eventdata, handles);
        


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
fc_NIRS_plotData(hObject, eventdata, handles);
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


% --- Executes on button press in show_psd.
function show_psd_Callback(hObject, eventdata, handles)
% hObject    handle to show_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_NIRS_plotPSD(hObject, eventdata, handles);

% --- Executes on button press in select_inputdirectory.
function select_inputdirectory_Callback(hObject, eventdata, handles)
% hObject    handle to select_inputdirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%select input directory ;
select_inputDirectory(hObject, eventdata, handles);
%fc_NIRS_plotSDG(hObject, eventdata, handles);
    
function select_inputDirectory(hObject, eventdata, handles)

global SIGNAL_TYPE1;
global SIGNAL_TYPE2;
global SIGNAL_TYPE3;
global SIGNAL_TYPE4;


pathnm = uigetdir(cd, 'Pick the new directory' );
if pathnm==0
    return;
end
set(handles.input_directory,'String',pathnm);

%probe the existing file.
nirsfilelist=dir(fullfile(pathnm,'\','*.nirs'));
procfilelist=dir(fullfile(pathnm,'\','*.proc'));
datalist=[];
if size(nirsfilelist,1)>0
    if size(procfilelist,1)>0
        msgbox('The selected input directory has both nirs and proc format file.','warn'); 
    else
        set(handles.signal_type1,'String',SIGNAL_TYPE1);
        set(handles.signal_type2,'String',SIGNAL_TYPE3);
        set(handles.signal_type1,'Value',1);
        set(handles.signal_type2,'Value',1);
        set(handles.signal_type1,'Enable','on');
        set(handles.signal_type2,'Enable','on');
        set(handles.show_psd,'Enable','on');
        datalist=cell(size(nirsfilelist,1),1);
         for fileidx=1:size(nirsfilelist,1)
            datalist{fileidx,1}=nirsfilelist(fileidx).name;
         end
         DISPLAY_DATA.rawdata=importdata(fullfile(pathnm,datalist{1,1}));
    end
else
    if size(procfilelist,1)>0
        datalist=cell(size(procfilelist,1)); 
        set(handles.signal_type1,'String',SIGNAL_TYPE2);
        set(handles.signal_type2,'String',SIGNAL_TYPE3);
        set(handles.signal_type1,'Value',1);
        set(handles.signal_type2,'Value',1);
        set(handles.display_datalist,'Value',1);
        set(handles.signal_type1,'Enable','on');
        set(handles.signal_type2,'Enable','on');
        set(handles.show_psd,'Enable','on');
        for fileidx=1:size(procfilelist,1)
            datalist{fileidx,1}=procfilelist(fileidx).name;
        end
    end
end
%set the input datalist.
if ~isempty(datalist)
    set(handles.display_datalist,'String',datalist);
    DISPLAY_DATA=importdata(strcat(pathnm,'\',datalist{1}));
else 
    msgbox('The selected input directory has no nirs or proc data.','warn'); 
     set(handles.signal_type1,'Value',1);
    set(handles.signal_type2,'Value',1);
    set(handles.display_datalist,'Value',1);
    set(handles.display_datalist,'String',{'None'});
    set(handles.signal_type1,'String',SIGNAL_TYPE1);
    set(handles.signal_type2,'String',SIGNAL_TYPE3);
    set(handles.signal_type1,'Enable','off');
    set(handles.signal_type2,'Enable','off');
    set(handles.show_psd,'Enable','off'); 
    DISPLAY_DATA=[];
end
  fc_NIRS_plotSDG(hObject, eventdata, handles);
   


% --- Executes on selection change in display_datalist.
function display_datalist_Callback(hObject, eventdata, handles)
% hObject    handle to display_datalist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SIGNAL_TYPE2;
datapath=get(handles.input_directory,'String');
sublist=get(handles.display_datalist,'String');
selectValue=get(handles.display_datalist,'Value');
showsignal=zeros(4,1);
if isempty(sublist)
return;
end
subname=sublist{selectValue,1};
global DISPLAY_DATA;
if ~isempty(strfind(subname,'.proc'))
DISPLAY_DATA=importdata(fullfile(datapath,subname));
end
if ~isempty(strfind(subname,'.nirs'))
    DISPLAY_DATA.rawdata=importdata(fullfile(datapath,subname));
    DISPLAY_DATA.SD=DISPLAY_DATA.rawdata.SD;
end
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
fc_NIRS_plotSDG(hObject, eventdata, handles);
fc_NIRS_plotData(hObject, eventdata, handles);


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


% --- Executes during object creation, after setting all properties.
function axesSDG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axesSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axesSDG


% --- Executes on mouse press over axes background.
function axesSDG_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axesSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fc_NIRS_AxesSDG_buttondown(hObject, eventdata, handles)


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.clearflag==0)
clear global SIGNAL_TYPE1;
clear global SIGNAL_TYPE2;
clear global SIGNAL_TYPE3;
clear global SIGNAL_TYPE4;
clear global DISPLAY_STATE;
clear global DISPLAY_DATA;
end
%is exist rawdata;
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
