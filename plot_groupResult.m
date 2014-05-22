function plot_groupResult(hObject, eventdata, handles)
workpath=handles.workplace;
% subjects=handles.sublist;
fc_type=handles.fc_type;
SD=handles.SD;
axes(handles.groupResult);
signal_type=get(handles.popupmenu_signalType,'String');
signal_selected=get(handles.popupmenu_signalType,'Value');
sig=signal_type{signal_selected};
%%seedbased
if strcmp(fc_type,'seed')
    if get(handles.checkbox_R,'Value');
        tmp=load(strcat('FC_result\',fc_type,'_groupMap_',sig,'_R'));
        strname=fieldnames(tmp);
        [map]=fc_map(SD,getfield(tmp,strname{1}));
        imagesc(map);
    elseif get(handles.checkbox_Z,'Value');
        tmp=load(strcat('FC_result\',fc_type,'_groupMap_',sig,'_Z'));
        strname=fieldnames(tmp);
        [map]=fc_map(SD,getfield(tmp,strname{1}));
        imagesc(map);
    elseif get(handles.checkbox_Z2R,'Value')
        tmp=load(strcat('FC_result\',fc_type,'_groupMap_',sig,'_Z2R'));
        strname=fieldnames(tmp);
        [map]=fc_map(SD,getfield(tmp,strname{1}));
        imagesc(map);
    elseif get(handles.checkbox_T,'Value')
        tmp=load(strcat('FC_result\',fc_type,'_groupMap_',sig,'_T'));
        strname=fieldnames(tmp);
        [map]=fc_map(SD,getfield(tmp,strname{1}));
        imagesc(map);
    end
end

%%
if strcmp(fc_type,'whole')
    if get(handles.checkbox_R,'Value');
        tmp=load(strcat('FC_result\',fc_type,'_groupMap_',sig,'_R'));
        strname=fieldnames(tmp);
        imagesc(getfield(tmp,strname{1}));
    elseif get(handles.checkbox_Z,'Value');
        tmp=load(strcat('FC_result\',fc_type,'_groupMap_',sig,'_Z'));
        strname=fieldnames(tmp);
        imagesc(getfield(tmp,strname{1}));
    elseif get(handles.checkbox_Z2R,'Value')
        tmp=load(strcat('FC_result\',fc_type,'_groupMap_',sig,'_Z2R'));
        strname=fieldnames(tmp);
        imagesc(getfield(tmp,strname{1}));
    elseif get(handles.checkbox_T,'Value')
        tmp=load(strcat('FC_result\',fc_type,'_groupMap_',sig,'_T'));
        strname=fieldnames(tmp);
        imagesc(getfield(tmp,strname{1}));
    end
end
colorbar;
