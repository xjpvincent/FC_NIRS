function varargout = fc_analysis(varargin)
% FC_ANALYSIS MATLAB code for fc_analysis.fig
%      FC_ANALYSIS, by itself, creates a new FC_ANALYSIS or raises the existing
%      singleton*.
%
%      H = FC_ANALYSIS returns the handle to a new FC_ANALYSIS or the handle to
%      the existing singleton*.
%
%      FC_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FC_ANALYSIS.M with the given input arguments.
%
%      FC_ANALYSIS('Property','Value',...) creates a new FC_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fc_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fc_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fc_analysis

% Last Modified by GUIDE v2.5 14-May-2014 23:39:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fc_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @fc_analysis_OutputFcn, ...
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


% --- Executes just before fc_analysis is made visible.
function fc_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fc_analysis (see VARARGIN)

set(handles.directory_place,'String',cd);

% Choose default command line output for fc_analysis
handles.output = hObject;
plotSDG(hObject, eventdata, handles);
displayData(hObject, eventdata, handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fc_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fc_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function seed_channel_Callback(hObject, eventdata, handles)
% hObject    handle to seed_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seed_channel as text
%        str2double(get(hObject,'String')) returns contents of seed_channel as a double


% --- Executes during object creation, after setting all properties.
function seed_channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seed_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_HbO.
function checkbox_HbO_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_HbO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_HbO


% --- Executes on button press in checkbox_HbR.
function checkbox_HbR_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_HbR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_HbR


% --- Executes on button press in checkbox_HbT.
function checkbox_HbT_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_HbT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_HbT


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 fc_analysis_change_directory( hObject, eventdata, handles );

% --- Executes on selection change in display_directory.
function display_directory_Callback(hObject, eventdata, handles)
% hObject    handle to display_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=get(handles.display_directory,'Value');
filelist=get(handles.display_directory,'String');
directory=get(handles.directory_place,'String');
try
subject=filelist{n};
catch
    return
end
datapath=strcat(directory,'\','processedData\',subject);
load(datapath);
GUI_DATA.currentData=procResult.rawdata;
GUI_DATA.currentData.dc=procResult.dc;
GUI_DATA.currentData.dod=procResult.dod;

corr_hbo=corr(procResult.HbO);
[map]=fc_map(procResult.rawdata.SD,corr_hbo);
axes(handles.fc_map1);
imagesc(map);



% if strcmp(plot_subject,GUI_DATA.plotstate.selectedsubject)
%     return
% end
%updata the global variable's 
% GUI_DATA.plotstate.selectedsubject=plot_subject;
% imported_data = importdata(strcat(GUI_DATA.plotstate.workpath,'\','RawData\',plot_subject));
% GUI_DATA.rawdata=imported_data;
% GUI_DATA.rawdata.SD.MeasListVis=GUI_DATA.rawdata.SD.MeasListAct;
% GUI_DATA.currentData=imported_data;
% GUI_DATA.currentData.SD.MeasListVis=GUI_DATA.rawdata.SD.MeasListAct;



%Update the displays

plotSDG(hObject, eventdata, handles);
displayData(hObject, eventdata, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns display_directory contents as cell array
%        contents{get(hObject,'Value')} returns selected item from display_directory


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

seedbased_FCmap(hObject, eventdata, handles);
channel=get(handles.seed_channel,'String');
num=str2num(channel);


workpath=get(handles.directory_place,'String');
sublist=get(handles.display_directory,'String');
datapath=strcat(directory,'\','processedData\',subject);
load(datapath);
corr_hbo=corr(procResult.HbO);

fc_matrix=zeros(46,46);
for i=1:length(sublist)
    datapath=strcat(directory,'\','processedData\',subject);
    load(datapath);
    if get(handles.checkbox_HbO,'Value');
        fc_matrix=fc_matrix+corr(procResult.HbO);
    elseif get(handles.checkbox_HbR,'Value');
        fc_matrix=fc_matrix+corr(procResult.HbR);
    elseif get(handlse.checkbox_HbT,'Value');
        fc_matrix=fc_matrix+corr(procResult.HbT);
    else
        return;
    end
    
end
fc_matrix=fc_matrix/length(sublist);



% --- Executes on mouse press over axes background.
function axesSDG_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axesSDG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
