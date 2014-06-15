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

% Last Modified by GUIDE v2.5 15-Jun-2014 16:52:45

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

% Choose default command line output for FC_NIRS_qualityControl
global DISPLAY_STATE;
global DISPLAY_DATA;
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
selectValue=sublist{get(handles.raw_sublist,'Value')};
input=get(handles.input_directory,'String');
x=importdata(fullfile(input,selectValue));
global DISPLAY_DATA;
DISPLAY_DATA=x;


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
axes(handles.axes_CorrMatrix);
if isempty(DISPLAY_DATA)
    cla;
    return;
end
c=corr(DISPLAY_DATA.procConc.HbO);
imagesc(c);
colorbar;
else
    cla reset;
end

% axesDisplaySTD=axesDisplaySTD;
%axes(handles.axes_CorrMatrix);


% Hint: get(hObject,'Value') returns toggle state of radio_hbo
% hold off;

% --- Executes on button press in radio_hbr.
function radio_hbr_Callback(hObject, ~, handles)
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
axes(handles.axes_CorrMatrix);
if isempty(DISPLAY_DATA)
    cla;
    return;
end
c=corr(DISPLAY_DATA.procConc.HbR);
imagesc(c);
colorbar;
else
    cla reset;
end
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
axes(handles.axes_CorrMatrix);
if isempty(DISPLAY_DATA)
    cla;
    return;
end
c=corr(DISPLAY_DATA.procConc.HbT);
imagesc(c);
colorbar;
else
    cla reset;
end
% Hint: get(hObject,'Value') returns toggle state of radio_hbt


% --- Executes on button press in select2raw.
function select2raw_Callback(hObject, eventdata, handles)
% hObject    handle to select2raw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
select_sublist=get(handles.select_sublist,'String');
if ~isempty(select_sublist)
    selectValue=get(handles.select_sublist,'Value');
    raw_sublist=get(handles.raw_sublist,'String');
    raw_sublist=[raw_sublist;select_sublist(selectValue')];
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


raw_sublist=get(handles.raw_sublist,'String');
if ~isempty(raw_sublist)
    selectValue=get(handles.raw_sublist,'Value');
    select_sublist=get(handles.select_sublist,'String');
    select_sublist=[select_sublist;raw_sublist(selectValue')];
    %CAL_LIST=[CAL_LIST;methodlist(selectValue')];
    raw_sublist(selectValue')=[];
    if isempty(raw_sublist)
        set(handles.raw_sublist,'Value',0);
    else 
        set(handles.raw_sublist,'Value',1);
    end
     if isempty(select_sublist)
        set(handles.select_sublist,'Value',0);
    else 
        set(handles.select_sublist,'Value',1);
    end
    set(handles.raw_sublist,'String',raw_sublist);
    set(handles.select_sublist,'String',select_sublist);

end

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
restNIRS_AxesSDG_buttondown(hObject, eventdata, handles)
displaySTD(hObject, eventdata, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set the pushbutton disable;
set(hObject,'Enable','off');
drawnow;
input=get(handles.input_directory,'String');
output=get(handles.output_directory,'String');
if ~(exist(output,'dir')==7)
    mkdir(fullfile(output));
end
sublist=get(handles.select_sublist,'String');
h=waitbar(0,'Please wait...');
for i=1:size(sublist,1)
    try
        tmp=sublist{i};
    catch
        close(h);
%set the pushbutton Enable;
        set(hObject,'Enable','on');
        return;
    end
    copyfile(fullfile(input,sublist{i,1}),...
         fullfile(output,sublist{i,1}));
    waitbar(i/size(sublist,1),h,strcat(sublist{i},' is finished'));
end
close(h);
%set the pushbutton Enable;
set(hObject,'Enable','on');
drawnow;



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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
select_inputDirectory(hObject, eventdata, handles);
%fc_NIRS_plotSDG(hObject, eventdata, handles);
    
function select_inputDirectory(hObject, eventdata, handles)
pathnm = uigetdir(cd, 'Pick the new directory' );
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
axes(handles.axies_opticalSNR);
if get(hObject,'Value')
set(handles.radiobutton21,'Value',0);
end
global DISPLAY_DATA;
if isempty(DISPLAY_DATA)
    cla;
    return;
end
sublist=get(handles.raw_sublist,'String');
if strcmp(class(sublist),'char')
    if strcmp(sublist,'None')
    msgbox('You haven''t select the subject. Please select a subject you want to display.','Warning','error');
    return 
    end   
end
d=DISPLAY_DATA.rawdata.d;
v_d=STD(d);
m_d=mean(d);
opticalSNR=m_d./v_d;

cla
plot(opticalSNR(1:end/2),'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10);

m_opticalSNR=mean(opticalSNR(1:end/2));
v_opticalSNR=STD(opticalSNR(1:end/2));
hold on;        
plot([0:50],ones(1,51)*(m_opticalSNR+2*v_opticalSNR),'--b');
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
axes(handles.axies_opticalSNR);
global DISPLAY_DATA;
if isempty(DISPLAY_DATA)
    cla;
    return;
end
sublist=get(handles.raw_sublist,'String');
if strcmp(class(sublist),'char')
    if strcmp(sublist,'None')
    msgbox('You haven''t select the subject. Please select a subject you want to display.','Warning','error');
    return 
    end   
end
d=DISPLAY_DATA.rawdata.d;
v_d=STD(d);
m_d=mean(d);
opticalSNR=m_d./v_d;
cla
plot(opticalSNR(end/2+1:end),'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10);
m_opticalSNR=mean(opticalSNR(47:end));
v_opticalSNR=STD(opticalSNR(47:end));
 hold on; 
 grid on;
plot([0:50],ones(1,51)*(m_opticalSNR+2*v_opticalSNR),'--b');    
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
ch=get(handles.choosed_ch,'String');
wl=get(handles.windowlength,'String');
stdEvthresh1=get(handles.stdEvthresh1,'String');
DISPLAY_STATE.ch=str2num(ch);
DISPLAY_STATE.wl=str2num(wl);
DISPLAY_STATE.stdEvthresh1=str2num(stdEvthresh1);
fc_nirs_displaySTD(hObject, eventdata, handles)
% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Value',1);
set(handles.togglebutton2,'Value',0);
set(handles.pannel_SNR,'Visible','off');
set(handles.pannel_MotionArtifact,'Visible','on');
% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Value',1);
set(handles.togglebutton1,'Value',0);
position1=get(handles.pannel_MotionArtifact,'Position');
position2=get(handles.pannel_SNR,'Position');
position=[position1(1)  position1(2)+abs(position1(4)-position2(4))/2 position2(3:4)];
set(handles.pannel_SNR,'Visible','on');
set(handles.pannel_SNR,'Position',position1);
set(handles.pannel_MotionArtifact,'Visible','off');
% Hint: get(hObject,'Value') returns toggle state of togglebutton2


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
FC_NIRS_displayTimeseries(input_directory);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
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
DISLPLAY_STATE.stdEvthresh2=str2num(get(handles.stdEvthresh2,'String'));
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

% Hint: get(hObject,'Value') returns toggle state of radiobutton23
