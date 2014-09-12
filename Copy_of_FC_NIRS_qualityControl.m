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

% Last Modified by GUIDE v2.5 22-May-2014 22:13:42

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
global GUI_DATA;
GUI_DATA.plotstate.Conc=1;
GUI_DATA.plotstate.plotOD=0;
set(handles.directory_place,'String',cd);
if isfield(GUI_DATA.plotstate,'plot')
   % GUI_DATA.plotstate=rmfield(GUI_DATA.plotstate,'plot');
   GUI_DATA.plotstate.plot=[];
end
GUI_DATA.fig_qc=hObject;
%GUI_DATA.fig_qc=hObject;
init_QC(hObject, handles);
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
plotSDG(hObject, eventdata, handles);
displayData(hObject, eventdata, handles);

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

global GUI_DATA;
% if ~get(hObject,'Value')
%     set(hObject,'Value',1);
%     return;
% end
% if get(hObject,'Value')
set(handles.radio_hbr,'Value',0);
set(handles.radio_hbt,'Value',0);
workpath=GUI_DATA.plotstate.workpath;
sublist=get(handles.raw_sublist,'String');
if strcmp(class(sublist),'char')
    if strcmp(sublist,'None')
    msgbox('You haven''t select the subject. Please select a subject you want to display.'...
        ,'Warning','error');
    return 
    end   
end
selected_sub=sublist{get(handles.raw_sublist,'Value')};
x=load(strcat(workpath,'\processedData\',selected_sub(1:end-5),'procData.mat')); 
GUI_DATA.RawData=x.procResult.RawData;
GUI_DATA.currentData.dc=x.procResult.dc;
GUI_DATA.currentData.dod=x.procResult.dod;
GUI_DATA.currentData.SD=x.procResult.RawData.SD;
GUI_DATA.currentData.t=x.procResult.RawData.t;


% else
%     cla reset;
% end


% Hints: contents = cellstr(get(hObject,'String')) returns raw_sublist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from raw_sublist


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
global GUI_DATA;
if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end
if get(hObject,'Value')
set(handles.radio_hbr,'Value',0);
set(handles.radio_hbt,'Value',0);
workpath=GUI_DATA.plotstate.workpath;
sublist=get(handles.raw_sublist,'String');
if strcmp(class(sublist),'char')
    if strcmp(sublist,'None')
    msgbox('You haven''t select the subject. Please select a subject you want to display.','Warning','error');
    
    return 
    end   
end
selected_sub=sublist{get(handles.raw_sublist,'Value')};
x=load(strcat(workpath,'\PrecessedData\',selected_sub(1:end-5),'Corr_matrix.mat'));   
axes(handles.axes_CorrMatrix);
imagesc(x.Corr_matrix.HbO);
colorbar;
else
    cla reset;
end

% axesDisplaySTD=axesDisplaySTD;
%axes(handles.axes_CorrMatrix);


% Hint: get(hObject,'Value') returns toggle state of radio_hbo
% hold off;

% --- Executes on button press in radio_hbr.
function radio_hbr_Callback(hObject, eventdata, handles)
% hObject    handle to radio_hbr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;

if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end

if get(hObject,'Value')
set(handles.radio_hbo,'Value',0);
set(handles.radio_hbt,'Value',0);
workpath=GUI_DATA.plotstate.workpath;
sublist=get(handles.raw_sublist,'String');
selected_sub=sublist{get(handles.raw_sublist,'Value')};
x=load(strcat(workpath,'\PrecessedData\',selected_sub(1:end-5),'Corr_matrix.mat'));   
axes(handles.axes_CorrMatrix);
imagesc(x.Corr_matrix.HbR);
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
global GUI_DATA;

if ~get(hObject,'Value')
    set(hObject,'Value',1);
    return;
end

if get(hObject,'Value')
set(handles.radio_hbo,'Value',0);
set(handles.radio_hbr,'Value',0);
workpath=GUI_DATA.plotstate.workpath;
sublist=get(handles.raw_sublist,'String');
selected_sub=sublist{get(handles.raw_sublist,'Value')};
x=load(strcat(workpath,'\PrecessedData\',selected_sub(1:end-5),'Corr_matrix.mat'));   
axes(handles.axes_CorrMatrix);
imagesc(x.Corr_matrix.HbT);
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
n=get(handles.select_sublist,'Value');
rawlist=get(handles.select_sublist,'String');
%selected subject;
%selected_subject=rawlist{n};
%l=length(rawlist);
%delete the selected subject in the sublist list;
datatype=class(rawlist);
if strcmp(datatype,'char')
    if strcmp(rawlist,'None')
        return;
    else
        selected_subject=rawlist;
        tmplist='None';
    end
else
    if length(rawlist)>1
        selected_subject=rawlist{n};
        if n==1
            %   tmplist(end+1,:)=;
            tmplist= rawlist(n+1,end);
        elseif  n==length(rawlist)
            tmplist=rawlist(1:n-1);
        else
            tmplist=rawlist(1:n-1);
            tmplist(end+1,end+length(rawlist)-n)=rawlist(n+1:end);
        end
    else
        selected_subject=rawlist{1};
        tmplist='None';
    end
    
end
%
set(handles.select_sublist,'Value',1);
set(handles.select_sublist,'String',tmplist);


%add the selected subject to the selected list;
selectlist=get(handles.raw_sublist,'String');
datatype=class(selectlist);
if(strcmp(datatype,'char'))
    if strcmp(selectlist,'None')
        set(handles.raw_sublist,'String',selected_subject);
        
    else
        tmp=cell(1,1);
        tmp{1}=selectlist;
        tmp{end+1}=selected_subject;
        selectlist=tmp;
        set(handles.raw_sublist,'String',selectlist);
    end
else
    if strcmp(selectlist{1},'None')
        set(handles.raw_sublist,'String',selected_subject);
    else
    selectlist{end+1}=selected_subject;
    set(handles.raw_sublist,'String',selectlist);
    end
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
n=get(handles.raw_sublist,'Value');
rawlist=get(handles.raw_sublist,'String');
%selected subject;
%selected_subject=rawlist{n};
%l=length(rawlist);
%delete the selected subject in the sublist list;
datatype=class(rawlist);
if strcmp(datatype,'char')
    if strcmp(rawlist,'None')
        return;
    else
        selected_subject=rawlist;
        tmplist='None';
    end
else
    if length(rawlist)>1
        selected_subject=rawlist{n};
        if n==1
            %   tmplist(end+1,:)=;
            tmplist= rawlist(n+1,end);
        elseif  n==length(rawlist)
            tmplist=rawlist(1:n-1);
        else
            tmplist=rawlist(1:n-1);
            tmplist(end+1,end+length(rawlist)-n)=rawlist(n+1:end);
        end
    else
        selected_subject=rawlist{1};
        tmplist='None';
    end
    
end
%
set(handles.raw_sublist,'Value',1);
set(handles.raw_sublist,'String',tmplist);


%add the selected subject to the selected list;
selectlist=get(handles.select_sublist,'String');
datatype=class(selectlist);
if(strcmp(datatype,'char'))
    if strcmp(selectlist,'None')
        set(handles.select_sublist,'String',selected_subject);
    else
        tmp=cell(1,1);
        tmp{1}=selectlist;
        tmp{end+1}=selected_subject;
        selectlist=tmp;
        set(handles.select_sublist,'String',selectlist);
    end
else
    if strcmp(selectlist{1},'None')
        set(handles.select_sublist,'String',selected_subject);
    else
    selectlist{end+1}=selected_subject;
    set(handles.select_sublist,'String',selectlist);
    end
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
  
global GUI_DATA;
workpath=GUI_DATA.plotstate.workpath;
outpath=strcat(workpath,'\','Data_after_QC');
mkdir(strcat(workpath,'\','QCedData'));
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
    
    copyfile(strcat(workpath,'\processedData\',...
         tmp(1:end-5),'Conc.mat'),...
         strcat(workpath,'\QCedData\',...
         tmp(1:end-5),'Conc.mat'));
    waitbar(i/size(sublist,1),h,strcat(sublist{i},' is finished'));
end
close(h);
%set the pushbutton Enable;
set(hObject,'Enable','on');
drawnow;



function directory_place_Callback(hObject, eventdata, handles)
% hObject    handle to directory_place (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of directory_place as text
%        str2double(get(hObject,'String')) returns contents of directory_place as a double


% --- Executes during object creation, after setting all properties.
function directory_place_CreateFcn(hObject, eventdata, handles)
% hObject    handle to directory_place (see GCBO)
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
 qc_change_directory( hObject, eventdata, handles )


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
global GUI_DATA;
if get(hObject,'Value')
    set(handles.conc_type,'Enable','off');
    set(handles.conc_type,'Value',1);
 %   set(handles.radio_OD,'Enable','off');
    set(handles.wavelength,'Enable','on');
    set(handles.wavelength,'Value',1);
    set(handles.radio_Conc,'Value',0);
    GUI_DATA.plotstate.plotstate.Conc=1;
    plotSDG(hObject, eventdata, handles)
   displayData(hObject, eventdata, handles);
   displaySTD(hObject, eventdata, handles);
else
    set(hObject,'Value',1);
end

% Hint: get(hObject,'Value') returns toggle state of radio_OD


% --- Executes on button press in radio_Conc.
function radio_Conc_Callback(hObject, eventdata, handles)
% hObject    handle to radio_Conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
if get(hObject,'Value')
    set(handles.conc_type,'Enable','on');
    set(handles.conc_type,'Value',1);
    %set(handles.radio_OD,'Enable','off');
    set(handles.wavelength,'Enable','off');
    set(handles.wavelength,'Value',1);
    set(handles.radio_OD,'Value',0);
    GUI_DATA.plotstate.Conc=1;
    plotSDG(hObject, eventdata, handles)
    displayData(hObject, eventdata, handles);
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
global GUI_DATA;
 GUI_DATA.plotstate.Conc=get(hObject,'Value');
plotSDG(hObject, eventdata, handles)
displayData(hObject, eventdata, handles);
displaySTD(hObject, eventdata, handles);
displayDVARS(hObject, eventdata, handles);
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
global GUI_DATA;
value=get(hObject,'Value');
if value
    set(handles.radio_selected,'Value',0);
    GUI_DATA.plotstate.plotType=2;
else
    set(hObject,'Value',1);
end

plotSDG(hObject, eventdata, handles)
displayData(hObject, eventdata, handles);
displaySTD(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radio_all


% --- Executes during object deletion, before destroying properties.
function fig_qc_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to fig_qc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_DATA;
clear GUI_DATA;


% --- Executes during object creation, after setting all properties.
function axesSDG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axesSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axesSDG



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
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

global GUI_DATA;
workpath=GUI_DATA.plotstate.workpath;
sublist=get(handles.raw_sublist,'String');
if strcmp(class(sublist),'char')
    if strcmp(sublist,'None')
    msgbox('You haven''t select the subject. Please select a subject you want to display.','Warning','error');
    return 
    end   
end
selected_sub=sublist{get(handles.raw_sublist,'Value')};

x=load(strcat(workpath,'\processedData\',selected_sub(1:end-5),'procData.mat'));   
d=x.procResult.RawData.d;
v_d=VAR(d);
m_d=mean(d);
opticalSNR=m_d./v_d;
axes(handles.axies_opticalSNR);
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

global GUI_DATA;
workpath=GUI_DATA.plotstate.workpath;
sublist=get(handles.raw_sublist,'String');
if strcmp(class(sublist),'char')
    if strcmp(sublist,'None')
    msgbox('You haven''t select the subject. Please select a subject you want to display.','Warning','error');
    return 
    end   
end
selected_sub=sublist{get(handles.raw_sublist,'Value')};

x=load(strcat(workpath,'\processedData\',selected_sub(1:end-5),'procData.mat'));   
d=x.procResult.RawData.d;
v_d=VAR(d);
m_d=mean(d);
opticalSNR=m_d./v_d;
axes(handles.axies_opticalSNR);
cla
plot(opticalSNR(end/2+1:end),'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10);
m_opticalSNR=mean(opticalSNR(47:end));
v_opticalSNR=STD(opticalSNR(47:end));
 hold on; 
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
set(handles.pannel_SNR,'Position',position);
set(handles.pannel_MotionArtifact,'Visible','off');
% Hint: get(hObject,'Value') returns toggle state of togglebutton2
