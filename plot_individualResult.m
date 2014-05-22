function plot_individualResult(hObject, eventdata, handles)
workpath=handles.workplace;
subjects=handles.sublist;
fc_type=handles.fc_type;
SD=handles.SD;
axes(handles.individualResult);
%%seedbased
if strcmp(fc_type,'seed')
    if get(handles.checkbox_HbO,'Value');
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx};
        tmp=load(strcat('FC_result\',subject,fc_type,'_HbO.mat'));
        [map]=fc_map(SD,tmp.corr_map);
        imagesc(map);
    elseif get(handles.checkbox_HbR,'Value');
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx};
         tmp=load(strcat('FC_result\',subject,fc_type,'_HbR.mat'));
        [map]=fc_map(SD,tmp.corr_map);
        imagesc(map);
    elseif get(handles.checkbox_HbT,'Value')
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx};
         tmp=load(strcat('FC_result\',subject,fc_type,'_HbT.mat'));
        [map]=fc_map(SD,tmp.corr_map);
        imagesc(map);
    end
end

%%
if strcmp(fc_type,'whole')
  if get(handles.checkbox_HbO,'Value');
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx};
        tmp=load(strcat('FC_result\',subject,fc_type,'_HbO.mat'));
       % [map]=fc_map(SD,tmp.corr_map);
        imagesc(tmp.corr_map);
    elseif get(handles.checkbox_HbR,'Value');
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx};
         tmp=load(strcat('FC_result\',subject,fc_type,'_HbR.mat'));
       imagesc(tmp.corr_map);
    elseif get(handles.checkbox_HbT,'Value')
        sidx=get(handles.subjects_list,'Value');
        subject=subjects{sidx};
         tmp=load(strcat('FC_result\',subject,fc_type,'_HbT.mat'));
        imagesc(tmp.corr_map);
    end
end
colorbar;
