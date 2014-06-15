function plot_individualResult(hObject, eventdata, handles,datapath)
%display the FC result 
%add by xjp.
subjects=handles.sublist;
fc_type=handles.fc_type;
SD=handles.SD;
axes(handles.individualResult);
%output_directory=get(handles.out_directory,'String');

%%seedbased
if strcmp(fc_type,'seed')
    if get(handles.checkbox_HbO,'Value');
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx}(1:end-5);
        tmp=load(fullfile(datapath,strcat(subject,fc_type,'_HbO.mat')));
        [map]=fc_map(SD,tmp.corr_map);
        imagesc(map);
    elseif get(handles.checkbox_HbR,'Value');
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx}(1:end-5);
         tmp=load(fullfile(datapath,strcat(subject,fc_type,'_HbR.mat')));
        [map]=fc_map(SD,tmp.corr_map);
        imagesc(map);
    elseif get(handles.checkbox_HbT,'Value')
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx}(1:end-5);
         tmp=load(fullfile(datapath,strcat(subject,fc_type,'_HbT.mat')));
        [map]=fc_map(SD,tmp.corr_map);
        imagesc(map);
    end
end

%%
if strcmp(fc_type,'whole')
  if get(handles.checkbox_HbO,'Value');
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx}(1:end-5);
        tmp=load(fullfile(datapath,'\',strcat(subject,fc_type,'_HbO.mat')));
       % [map]=fc_map(SD,tmp.corr_map);
        imagesc(tmp.corr_map);
    elseif get(handles.checkbox_HbR,'Value');
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx}(1:end-5);
         tmp=load(fullfile(datapath,'\',strcat(subject,fc_type,'_HbR.mat')));
       imagesc(tmp.corr_map);
    elseif get(handles.checkbox_HbT,'Value')
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx}(1:end-5);
         tmp=load(fullfile(datapath,'\',strcat(subject,fc_type,'_HbT.mat')));
        imagesc(tmp.corr_map);
    end
end
colorbar;
