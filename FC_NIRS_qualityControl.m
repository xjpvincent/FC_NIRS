function varargout = FC_NIRS_qualityControl(varargin)
% FC_NIRS_QUALITYCONTROL MATLAB code for FC_NIRS_qualityControl.fig
%      FC_NIRS_QUALITYCONTROL, by itself, creates a new FC_NIRS_QUALITYCONTROL or raises the existing
%      singleton*.
%
%      H = FC_NIRS_QUALITYCONTROL returns the handle to a new FC_NIRS_QUALITYCONTROL or the handle to
%      the existing singleton*.
%
%      FC_NIRS_QUALITYCONTROL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FC_NIRS_QUALITYCONTROL.M with the given input arguments.
%
%      FC_NIRS_QUALITYCONTROL('Property','Value',...) creates a new FC_NIRS_QUALITYCONTROL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FC_NIRS_qualityControl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FC_NIRS_qualityControl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FC_NIRS_qualityControl

% Last Modified by GUIDE v2.5 02-Jul-2014 00:01:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FC_NIRS_qualityControl_OpeningFcn, ...
    'gui_OutputFcn',  @FC_NIRS_qualityControl_OutputFcn, ...
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


% --- Executes just before FC_NIRS_qualityControl is made visible.
function FC_NIRS_qualityControl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FC_NIRS_qualityControl (see VARARGIN)

set(hObject,'Position',[346.6 27.6 169.6 53.6]);
% Choose default command line output for FC_NIRS_qualityControl
global DISPLAY_STATE;
global DISPLAY_DATA;
global SIGNAL_TYPE1;
global SIGNAL_TYPE2;
global SIGNAL_TYPE3;
global SIGNAL_TYPE4;
DISPLAY_STATE=[];
DISPLAY_DATA=[];
DISPLAY_STATE.signal_type1=4;
DISPLAY_STATE.signal_type2=1;
DISPLAY_STATE.ch=[];
DISPLAY_STATE.wl=2;
DISPLAY_STATE.stdEvthresh1=3;
DISPLAY_STATE.stdEvthresh2=3;
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

SIGNAL_TYPE1={'proc OD'};
SIGNAL_TYPE2={'raw Data';'proc OD';'raw Conc';'proc Conc'};
SIGNAL_TYPE3={'Wavelength1';'Wavelength2'};
SIGNAL_TYPE4={'HbO';'HbR';'HbT'};
DISPLAT_STATE.stdEvthresh2=3;
set(handles.input_directory,'String',pwd);
set(handles.output_directory,'String',fullfile(pwd,'\qcData'));
nirsfile=dir(fullfile(pwd,'*.proc'));
nirslist=cell(1,length(nirsfile));
for i=1:length(nirsfile)
    nirslist{i}=nirsfile(i).name;
end
set(handles.raw_sublist,'String',nirslist);
if ~isempty(nirslist)
    DISPLAY_DATA=importdata(fullfile(pwd,'\',nirslist{1}));
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
    fc_NIRS_plotstdSDG(hObject, eventdata, handles);
    fc_NIRS_displaySTD(hObject, eventdata, handles);
end
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%plotSDG(hObject, eventdata, handles);
%displayData(hObject, eventdata, handles);

% UIWAIT makes FC_NIRS_qualityControl wait for user response (see UIRESUME)
% uiwait(handles.fig_qc);


% --- Outputs from this function are returned to the command line.
function varargout = FC_NIRS_qualityControl_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in raw_sublist.
function raw_sublist_Callback(hObject, eventdata, handles)
% hObject    handle to raw_sublist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if ~get(hObject,'Value')
%     set(hObject,'Value',1);
%     return;
% end
% if get(hObject,'Value')
global DISPLAY_STATE
set(handles.radio_hbr,'Value',0);
set(handles.radio_hbt,'Value',0);
sublist=get(handles.raw_sublist,'String');
if strcmp(class(sublist),'char')
    if strcmp(sublist,'None')
        msgbox('You haven''t select the subject. Please select a subject you want to display.'...
            ,'Warning','error');
        return
    end
end
if isempty(sublist)
    return;
end

selectValue=sublist{get(handles.raw_sublist,'Value')};
input=get(handles.input_directory,'String');
x=importdata(fullfile(input,selectValue));
global DISPLAY_DATA;
DISPLAY_DATA=x;
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
global SIGNAL_TYPE2;
signal_type=SIGNAL_TYPE2(find(showsignal==1));
set(handles.signal_type1,'String',signal_type);
end_time1=DISPLAY_DATA.rawdata.t(end);

set(handles.end_time1,'String',num2str(end_time1));
end_time2=DISPLAY_DATA.procConc.t(end);
set(handles.end_time2,'String',num2str(end_time2));
%plot four axes;
%plot SDG
fc_NIRS_plotstdSDG(hObject, eventdata, handles)
fc_nirs_displaySTD(hObject, eventdata, handles);
fc_nirs_displayFCMAP(hObject, eventdata, handles);
fc_nirs_displaySNR(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function raw_sublist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to raw_sublist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in select_sublist.
function select_sublist_Callback(hObject, eventdata, handles)
% hObject    handle to select_sublist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%clear the axes;
%clear the axes;
% Hints: contents = cellstr(get(hObject,'String')) returns select_sublist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_sublist


% --- Executes during object creation, after setting all properties.
function select_sublist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_sublist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_hbo.
function radio_hbo_Callback(hObject, eventdata, handles)
% hObject    handle to radio_hbo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_DATA;

if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end

if get(hObject,'Value')
    set(handles.radio_hbr,'Value',0);
    set(handles.radio_hbt,'Value',0);
end
fc_nirs_displayFCMAP(hObject, eventdata, handles);

% axesDisplaySTD=axesDisplaySTD;
%axes(handles.axes_CorrMatrix);


% Hint: get(hObject,'Value') returns toggle state of radio_hbo
% hold off;

% --- Executes on button press in radio_hbr.
function radio_hbr_Callback(hObject, eventdata, handles)
% hObject    handle to radio_hbr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_DATA;
if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end
if get(hObject,'Value')
    set(handles.radio_hbo,'Value',0);
    set(handles.radio_hbt,'Value',0);
end
fc_nirs_displayFCMAP(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radio_hbo
% hold off;
% Hint: get(hObject,'Value') returns toggle state of radio_hbr

% --- Executes on button press in radio_hbt.
function radio_hbt_Callback(hObject, eventdata, handles)
% hObject    handle to radio_hbt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_DATA;

if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end

if get(hObject,'Value')
    set(handles.radio_hbo,'Value',0);
    set(handles.radio_hbr,'Value',0);
end
fc_nirs_displayFCMAP(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radio_hbt


% --- Executes on button press in select2raw.
function select2raw_Callback(hObject, eventdata, handles)
% hObject    handle to select2raw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%clear the axes;
% axesDisplaySTD=handles.axesDisplaySTD;
% axesDisplayDVARS=handles.axesDisplayDVARS;
% axesDisplayTailorData1=handles.axesDisplayTailorData1;
% axesDisplayTailorData2=handles.axesDisplayTailorData2;
% axes_CorrMatrix=handles.axes_CorrMatrix;
% axes_opticalSNR=handles.axes_opticalSNR;
% axesSDG=handles.axesSDG;
% axes(axesDisplaySTD);
% cla;
% axes(axesDisplayDVARS);
% cla;
% axes(axesDisplayTailorData1);
% cla;
% axes(axesDisplayTailorData2);
% cla;
% axes(axes_CorrMatrix);
% cla;
% axes(axes_opticalSNR);
% cla;
% axes(axesSDG);
% cla;
%%%
select_sublist=get(handles.select_sublist,'String');
if ~isempty(select_sublist)
    selectValue=get(handles.select_sublist,'Value');
    raw_sublist=get(handles.raw_sublist,'String');
    raw_sublist=[raw_sublist;select_sublist(selectValue')];
    outpath=get(handles.output_directory,'String');
    %delete the selected file
    delete_file=fullfile(outpath,select_sublist{selectValue'});
    delete(delete_file);
    global DIPSPLAY_DATA;
    DISPLAY_DATA=[];
    %CAL_LIST=[CAL_LIST;methodlist(selectValue')];
    select_sublist(selectValue')=[];
    if isempty(select_sublist)
        set(handles.select_sublist,'Value',0);
    else
        set(handles.select_sublist,'Value',1);
    end
    if isempty(raw_sublist)
        set(handles.raw_sublist,'Value',0);
    else
        set(handles.raw_sublist,'Value',1);
    end
    set(handles.select_sublist,'String',select_sublist);
    set(handles.raw_sublist,'String',raw_sublist);
    
end



% --- Executes on button press in radiobutton_HbO.
function radiobutton_HbO_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_HbO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end
if get(hObject,'Value')
    set(handles.radiobutton_HbR,'Value',0);
    set(handles.radiobutton_HbT,'Value',0);
    set(handles.radiobutton_OD,'Value',0);
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_HbO


% --- Executes on button press in radiobutton_HbR.
function radiobutton_HbR_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_HbR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end
set(handles.radiobutton_HbO,'Value',0);
set(handles.radiobutton_HbT,'Value',0);
set(handles.radiobutton_OD,'Value',0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_HbR


% --- Executes on button press in radiobutton_HbT.
function radiobutton_HbT_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_HbT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end
set(handles.radiobutton_HbR,'Value',0);
set(handles.radiobutton_HbO,'Value',0);
set(handles.radiobutton_OD,'Value',0);

% Hint: get(hObject,'Value') returns toggle state of radiobutton_HbT


% --- Executes on button press in radiobutton_OD.
function radiobutton_OD_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end
set(handles.radiobutton_HbR,'Value',0);
set(handles.radiobutton_HbT,'Value',0);
set(handles.radiobutton_HbO,'Value',0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_OD


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





% --- Executes on button press in raw2select.
function raw2select_Callback(hObject, eventdata, handles)
% hObject    handle to raw2select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% n=get(handles.raw_sublist,'Value');
% rawlist=get(handles.raw_sublist,'String');
% %selected subject;
% %selected_subject=rawlist{n};
% %l=length(rawlist);
% %delete the selected subject in the sublist list;
% datatype=class(rawlist);
% if strcmp(datatype,'char')
%     if strcmp(rawlist,'None')
%         return;
%     else
%         selected_subject=rawlist;
%         tmplist='None';
%     end
% else
%     if length(rawlist)>1
%         selected_subject=rawlist{n};
%         if n==1
%             %   tmplist(end+1,:)=;
%             tmplist= rawlist(n+1,end);
%         elseif  n==length(rawlist)
%             tmplist=rawlist(1:n-1);
%         else
%             tmplist=rawlist(1:n-1);
%             tmplist(end+1,end+length(rawlist)-n)=rawlist(n+1:end);
%         end
%     else
%         selected_subject=rawlist{1};
%         tmplist='None';
%     end
%
% end
% %
% set(handles.raw_sublist,'Value',1);
% set(handles.raw_sublist,'String',tmplist);
%

%add the selected subject to the selected list;
% selectlist=get(handles.raw_sublist,'String');
% datatype=class(selectlist);
% if(strcmp(datatype,'char'))
%     if strcmp(selectlist,'None')
%         set(handles.select_sublist,'String',selected_subject);
%     else
%         tmp=cell(1,1);
%         tmp{1}=selectlist;
%         tmp{end+1}=selected_subject;
%         selectlist=tmp;
%         set(handles.select_sublist,'String',selectlist);
%     end
% else
%     if strcmp(selectlist{1},'None')
%         set(handles.select_sublist,'String',selected_subject);
%     else
%     selectlist{end+1}=selected_subject;
%     set(handles.select_sublist,'String',selectlist);
%     end
% end
% raw_sublist=get(handles.raw_sublist,'String');
% if ~isempty(raw_sublist)
%     selectValue=get(handles.raw_sublist,'Value');
%     select_sublist=get(handles.select_sublist,'String');
%     select_sublist=[select_sublist;raw_sublist(selectValue')];
%     %CAL_LIST=[CAL_LIST;methodlist(selectValue')];
%     %copy the file
%     input=get(handles.input_directory,'String');
%     output=get(handles.output_directory,'String');
%     sublist=get(handles.select_sublist,'String');
%     output_directory=fullfile(output);
%    if ~(exist(output_directory,'dir')==7)
%         mkdir(fullfile(output_directory));
%    end
%     copyfile(fullfile(input,raw_sublist{selectValue'}),...
%         fullfile(output,raw_sublist{selectValue'}));
%     %end
%     raw_sublist(selectValue')=[];
%     if isempty(raw_sublist)
%         set(handles.raw_sublist,'Value',0);
%     else
%         set(handles.raw_sublist,'Value',1);
%     end
%      if isempty(select_sublist)
%         set(handles.select_sublist,'Value',0);
%     else
%         set(handles.select_sublist,'Value',1);
%     end
%     set(handles.raw_sublist,'String',raw_sublist);
%     set(handles.select_sublist,'String',select_sublist);
%
% end
% %call the TailorData window;
selectlist=get(handles.raw_sublist,'String');
if isempty(selectlist)
    return;
    %father_handles=handles;
end
father_handles=handles;
FC_NIRS_qcTailorData(father_handles);

% --- Executes during object creation, after setting all properties.
function axes_CorrMatrix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_CorrMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_CorrMatrix


% --- Executes on mouse press over axes background.
function axesSDG_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axesSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_NIRS_AxesSDG_buttondown(hObject, eventdata, handles)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set the pushbutton disable;



% set(hObject,'Enable','off');
% drawnow;
% input=get(handles.input_directory,'String');
% output=get(handles.output_directory,'String');
% if ~(exist(output,'dir')==7)
%     mkdir(fullfile(output));
% end
% sublist=get(handles.select_sublist,'String');
% h=waitbar(0,'Please wait...');
% for i=1:size(sublist,1)
%     try
%         tmp=sublist{i};
%     catch
%         close(h);
% %set the pushbutton Enable;
%         set(hObject,'Enable','on');
%         return;
%     end
%     copyfile(fullfile(input,sublist{i,1}),...
%          fullfile(output,sublist{i,1}));
%     waitbar(i/size(sublist,1),h,strcat(sublist{i},' is finished'));
% end
% close(h);
% %set the pushbutton Enable;
% set(hObject,'Enable','on');
% drawnow;



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


% --- Executes on button press in choose_directory.
function choose_directory_Callback(hObject, eventdata, handles)
% hObject    handle to choose_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
select_inputDirectory(hObject, eventdata, handles);
fc_NIRS_plotstdSDG(hObject, eventdata, handles);
fc_NIRS_displaySTD(hObject, eventdata, handles);

function select_inputDirectory(hObject, eventdata, handles)
input_directory=get(handles.input_directory,'String');
pathnm = uigetdir(input_directory, 'Pick the new directory' );
if pathnm==0
    return;
end
set(handles.input_directory,'String',pathnm)
%probe the existing file.
nirsfilelist=dir(strcat(pathnm,'\','*.proc'));
%procfilelist=dir(strcat(pathnm,'\','*.proc'));
datalist=[];
if size(nirsfilelist,1)>0
    for fileidx=1:size(nirsfilelist,1)
        datalist{fileidx,1}=nirsfilelist(fileidx).name;
    end
end
%set the input datalist.
%set(handles.
set(handles.raw_sublist,'String',datalist);
input=get(handles.input_directory,'String');
if ~isempty(datalist)
    x=importdata(fullfile(input,datalist{1,1}));
    global DISPLAY_DATA;
    DISPLAY_DATA=x;
end
end_time1=DISPLAY_DATA.rawdata.t(end);
set(handles.end_time1,'String',num2str(end_time1));
end_time2=DISPLAY_DATA.procConc.t(end);
set(handles.end_time2,'String',num2str(end_time2));
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
global SIGNAL_TYPE2;
signal_type=SIGNAL_TYPE2(find(showsignal==1));
set(handles.signal_type1,'String',signal_type);


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in wavelength.
function wavelength_Callback(hObject, eventdata, handles)
% hObject    handle to wavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
DISPLAY_STATE.signal_type2=get(hObject,'Value');
fc_nirs_displaySTD(hObject, eventdata, handles);
fc_nirs_displayDVARS(hObject, eventdata, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns wavelength contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wavelength


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


% --- Executes on button press in radio_OD.
function radio_OD_Callback(hObject, eventdata, handles)
% hObject    handle to radio_OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
if get(hObject,'Value')
    set(handles.conc_type,'Enable','off');
    set(handles.conc_type,'Value',1);
    %   set(handles.radio_OD,'Enable','off');
    set(handles.wavelength,'Enable','on');
    set(handles.wavelength,'Value',1);
    set(handles.radio_Conc,'Value',0);
    DISPLAY_STATE.signal_type1=1;
    DISPLAY_STATE.signal_type2=1;
    fc_nirs_displaySTD(hObject, eventdata, handles);
else
    set(hObject,'Value',1);
end

% Hint: get(hObject,'Value') returns toggle state of radio_OD


% --- Executes on button press in radio_Conc.
function radio_Conc_Callback(hObject, eventdata, handles)
% hObject    handle to radio_Conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
if get(hObject,'Value')
    set(handles.conc_type,'Enable','on');
    set(handles.conc_type,'Value',1);
    %set(handles.radio_OD,'Enable','off');
    set(handles.wavelength,'Enable','off');
    set(handles.wavelength,'Value',1);
    set(handles.radio_OD,'Value',0);
    DISPLAY_STATE.signal_type1=4;
    DISPLAY_STATE.signal_type2=1;
    displaySTD(hObject, eventdata, handles);
else
    set(hObject,'Value',1);
end

% Hint: get(hObject,'Value') returns toggle state of radio_Conc


% --- Executes on selection change in conc_type.
function conc_type_Callback(hObject, eventdata, handles)
% hObject    handle to conc_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
DISPLAY_STATE.signal_type2=get(hObject,'Value');
fc_nirs_displaySTD(hObject, eventdata, handles);
fc_nirs_displayDVARS(hObject, eventdata, handles);
%displayDVARS(hObject, eventdata, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns conc_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from conc_type


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


% --- Executes on button press in radio_selected.
function radio_selected_Callback(hObject, eventdata, handles)
% hObject    handle to radio_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
value=get(hObject,'Value');
if value
    set(handles.radio_all,'Value',0);
    GUI_DATA.plotstate.plotType=1;
else
    set(hObject,'Value',1);
end
plotSDG(hObject, eventdata, handles)
displayData(hObject, eventdata, handles);
displaySTD(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radio_selected


% --- Executes on button press in radio_all.
function radio_all_Callback(hObject, eventdata, handles)
% hObject    handle to radio_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value=get(hObject,'Value');
if value
    set(handles.radio_selected,'Value',0);
else
    set(hObject,'Value',1);
end

% Hint: get(hObject,'Value') returns toggle state of radio_all


% --- Executes during object deletion, before destroying properties.
function fig_qc_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to fig_qc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global all;

% --- Executes during object creation, after setting all properties.
function axesSDG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axesSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axesSDG



function windowlength_Callback(hObject, eventdata, handles)
% hObject    handle to windowlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;

DISPLAY_STATE.wl=str2num(get(hObject,'String'));
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of windowlength as text
%        str2double(get(hObject,'String')) returns contents of windowlength as a double


% --- Executes during object creation, after setting all properties.
function windowlength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stdEvthresh1_Callback(hObject, eventdata, handles)
% hObject    handle to stdEvthresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
DISPLAY_STATE.stdEvthresh1=str2num(get(hObject,'String'));
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of stdEvthresh1 as text
%        str2double(get(hObject,'String')) returns contents of stdEvthresh1 as a double


% --- Executes during object creation, after setting all properties.
function stdEvthresh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdEvthresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tal.
function tal_Callback(hObject, eventdata, handles)
% hObject    handle to tal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton20.
function radiobutton20_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end
if get(hObject,'Value')
    set(handles.radiobutton21,'Value',0);
end
fc_nirs_displaySNR(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radiobutton20
%plot([0:50],ones(1,51)*(m_opticalSNR+500));

% --- Executes on button press in radiobutton21.
function radiobutton21_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end

if get(hObject,'Value')
    set(handles.radiobutton20,'Value',0);
end
fc_nirs_displaySNR(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radiobutton21



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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
wl=get(handles.windowlength,'String');
stdEvthresh1=get(handles.stdEvthresh1,'String');
DISPLAY_STATE.wl=str2num(wl);
DISPLAY_STATE.stdEvthresh1=str2num(stdEvthresh1);
fc_nirs_displaySTD(hObject, eventdata, handles)
% --- Executes on button press in motionartifact_togglebutton1.
function motionartifact_togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to motionartifact_togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_DATA;
global DISPLAY_STATE;
set(handles.raw_sublist,'Enable','on');
set(hObject,'Value',1);
set(handles.SNR_togglebutton2,'Value',0);
set(handles.pannel_SNR,'Visible','off');
set(handles.pannel_MotionArtifact,'Visible','on');
% set(handles.pannel_tailorData,'Visible','off');
%set DISPLA£ß£Ä£Á£Ô£Á
sublist=get(handles.raw_sublist,'String');
%if there is no sublist ,then return do nothing;
if get(handles.raw_sublist,'Value')<1
    return;
end
if isempty(sublist)
    return;
end
if strcmp(class(sublist),'char')
    if strcmp(sublist,'None')
        msgbox('You haven''t select the subject. Please select a subject you want to display.'...
            ,'Warning','error');
        return
    end
end
selectValue=sublist{get(handles.raw_sublist,'Value')};
input=get(handles.input_directory,'String');
x=importdata(fullfile(input,selectValue));
DISPLAY_DATA=x;
%set plot state
DISPLAY_STATE.plotType=0;
fc_NIRS_plotstdSDG(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of motionartifact_togglebutton1


% --- Executes on button press in SNR_togglebutton2.
function SNR_togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to SNR_togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.raw_sublist,'Enable','on');
set(hObject,'Value',1);
set(handles.motionartifact_togglebutton1,'Value',0);
position1=get(handles.pannel_MotionArtifact,'Position');
position2=get(handles.pannel_SNR,'Position');
position=[position1(1)  position1(2)+abs(position1(4)-position2(4))/2 position2(3:4)];
set(handles.pannel_SNR,'Visible','on');
set(handles.pannel_SNR,'Position',position1);
set(handles.pannel_MotionArtifact,'Visible','off');


%set DISPLAY_DATA
%set DISPLA£ß£Ä£Á£Ô£Á
sublist=get(handles.raw_sublist,'String');
if strcmp(class(sublist),'char')
    if strcmp(sublist,'None')
        msgbox('You haven''t select the subject. Please select a subject you want to display.'...
            ,'Warning','error');
        return
    end
end
%if selected no value or the selected sublist is empty return;
if get(handles.raw_sublist,'Value')<1
    return;
end
if isempty(sublist)
    return;
end
selectValue=sublist{get(handles.raw_sublist,'Value')};
input=get(handles.input_directory,'String');
x=importdata(fullfile(input,selectValue));
global DISPLAY_DATA;
DISPLAY_DATA=x;
%set plot state
global DISPLAY_STATE;
DISPLAY_STATE.plotType=0;

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input_directory=get(handles.input_directory,'String');
FC_NIRS_displayTimeseries(input_directory);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input_directory=get(handles.input_directory,'String');
FC_NIRS_displayTimeseries(input_directory,1);

% --- Executes on button press in choose_outdirectory.
function choose_outdirectory_Callback(hObject, eventdata, handles)
% hObject    handle to choose_outdirectory (see GCBO)
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



function choosed_ch_Callback(hObject, eventdata, handles)
% hObject    handle to choosed_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of choosed_ch as text
%        str2double(get(hObject,'String')) returns contents of choosed_ch as a double


% --- Executes during object creation, after setting all properties.
function choosed_ch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choosed_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stdEvthresh2_Callback(hObject, eventdata, handles)
% hObject    handle to stdEvthresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stdEvthresh2 as text
%        str2double(get(hObject,'String')) returns contents of stdEvthresh2 as a double


% --- Executes during object creation, after setting all properties.
function stdEvthresh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdEvthresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAT_STATE;
DISPLAT_STATE.stdEvthresh2=str2num(get(handles.stdEvthresh2,'String'));
fc_nirs_displayDVARS(hObject, eventdata, handles);

function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to choosed_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of choosed_ch as text
%        str2double(get(hObject,'String')) returns contents of choosed_ch as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choosed_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to windowlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windowlength as text
%        str2double(get(hObject,'String')) returns contents of windowlength as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to stdEvthresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stdEvthresh1 as text
%        str2double(get(hObject,'String')) returns contents of stdEvthresh1 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdEvthresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to stdEvthresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stdEvthresh2 as text
%        str2double(get(hObject,'String')) returns contents of stdEvthresh2 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stdEvthresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton23.
function radiobutton23_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
if get(hObject,'Value');
    DISPLAY_STATE.plotType=1;
else
    DISPLAY_STATE.plotType=0;
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton23


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
fc_nirs_displaySTD(hObject, eventdata, handles);


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
fc_nirs_displaySTD(hObject, eventdata, handles);
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


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
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
% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_DATA;
out_directory=get(handles.output_directory,'String');
sublist=get(handles.select_sublist,'String');
selectValue=get(handles.select_sublist,'Value');
if ~strcmp(class(sublist),'cell')
    return ;
end
selectName=sublist{selectValue};
savepath=fullfile(out_directory,selectName);

save(savepath,'DISPLAY_DATA');


% --- Executes on key press with focus on edit_startTime and none of its controls.
function edit_startTime_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_startTime (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in radiobutton24.
function radiobutton24_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
if get(hObject,'Value')
    set(handles.radiobutton25,'Value',0);
    DISPLAY_STATE.plotType=0;
else
    set(hObject,'Value',1);
    DISPLAY_STATE.ployType=0;
end
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radiobutton24


% --- Executes on button press in radiobutton25.
function radiobutton25_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DISPLAY_STATE;
if get(hObject,'Value')
    set(handles.radiobutton24,'Value',0);
    DISPLAY_STATE.plotType=1;
else
    set(hObject,'Value',1);
    DISPLAY_STATE.ployType=1;
end
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radiobutton25



function start_time1_Callback(hObject, eventdata, handles)
% hObject    handle to start_time1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of start_time1 as text
%        str2double(get(hObject,'String')) returns contents of start_time1 as a double


% --- Executes during object creation, after setting all properties.
function start_time1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_time1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in signal_type2.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to signal_type2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns signal_type2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from signal_type2


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signal_type2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in signal_type1.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to signal_type1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns signal_type1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from signal_type1


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signal_type1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axesstdSDG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axesstdSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axesstdSDG


% --- Executes on mouse press over axes background.
function axesstdSDG_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axesstdSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_NIRS_AxesstdSDG_buttondown(hObject, eventdata, handles);



function end_time1_Callback(hObject, eventdata, handles)
% hObject    handle to end_time1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_nirs_displaySTD(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of end_time1 as text
%        str2double(get(hObject,'String')) returns contents of end_time1 as a double


% --- Executes during object creation, after setting all properties.
function end_time1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_time1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function start_time2_Callback(hObject, eventdata, handles)
% hObject    handle to start_time2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_nirs_displayFCMAP(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of start_time2 as text
%        str2double(get(hObject,'String')) returns contents of start_time2 as a double


% --- Executes during object creation, after setting all properties.
function start_time2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_time2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function end_time2_Callback(hObject, eventdata, handles)
% hObject    handle to end_time2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc_nirs_displayFCMAP(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of end_time2 as text
%        str2double(get(hObject,'String')) returns contents of end_time2 as a double


% --- Executes during object creation, after setting all properties.
function end_time2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_time2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in all2select.
function all2select_Callback(hObject, eventdata, handles)
% hObject    handle to all2select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectlist=get(handles.raw_sublist,'String');
if isempty(selectlist)
    return;
    %father_handles=handles;
end
parent_handles=handles;
FC_NIRS_qcTailorAllData(parent_handles);
