function [ output_args ] = change_directory( hObject, eventdata, handles )

%==========================================================================
% This function is used to 
%
%
% NOTE, ensure that your images are not initialized by these predefined
% characters to avoid potential errors.
%
%
% Syntax: function gretna_batch_preprocessing(Data_path, File_filter, Order)
%
% Inputs:
%       Data_path:
%                   The directory & filename of a .txt file that contains
%                   the directory of those files to be processed (can be
%                   obtained by gretna_gen_data_path.m).
%       File_filter:
%                   The prefix of those files to be processed.
%       Order:
%                   The order of processing steps (e.g., [6 3 1] means
%                   performing Temporal filtering first, then Spatial
%                   normalization and final Slice timing).
% Outputs:
%
% Jingping, NKLCNL, BNU, BeiJing, 2014/5/3, xjpvincent@gmail.com
%==========================================================================
global GUI_DATA;
%handles=GUI_DATA.handles;
%handles=guihandles(GUI_DATA.handles);
% ParentDir=uigetdir(pwd , 'Pick parent directory of dataset');
% Change directory
pathnm = uigetdir(cd, 'Pick the new directory' );
if pathnm==0
    return;
end
cd(pathnm);
%set work path
GUI_DATA.plotstate.workpath=pathnm;
%check whether exist FileFold 'RawData';
if ~isdir('RawData')
    uiwait(msgbox('There is no RawData directory in the currently directory, please check your data','Erro'));
    return;
end
%check whether exist nirs file;
if length(dir('RawData\*.nirs'))<1
    uiwait(msgbox('Your RawData Folder has no nirs file, please check it ','Warning'));
    return
end
nirsfile=dir('RawData\*.nirs');
nirslist=cell(1,length(nirsfile));
for i=1:length(nirsfile)
    nirslist{i}=nirsfile(i).name;
end
set(handles.display_directory,'String',nirslist);
GUI_DATA.plotstate.selectedsubject=nirslist{1};
%
%change_directory(hObject, eventdata,handles);
% %import data 
% 
imported_data = importdata(strcat(pathnm,'\','RawData\',nirslist{1}));
GUI_DATA.rawdata=imported_data;
GUI_DATA.rawdata.SD.MeasListVis=GUI_DATA.rawdata.SD.MeasListAct;
GUI_DATA.currentData=imported_data;
GUI_DATA.currentData.SD.MeasListVis=GUI_DATA.rawdata.SD.MeasListAct;

%set wavelength
lambda=GUI_DATA.currentData.SD.Lambda;
set(handles.directory_place,'String',pathnm);
set(handles.wavelength,'String',...
    {strcat('Wavelength 1 (',num2str(lambda(1)),'nm£©'),...
    strcat('Wavelength 2 (',num2str(lambda(2)),'nm£©')})
  setObject(hObject, eventdata, handles);
  GUI_DATA.plotstate.plotOD=1;
  plotSDG(hObject, eventdata, handles);
  displayData(hObject, eventdata, handles);
  
end



