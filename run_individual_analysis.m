function out_put=run_individual_analysis(hObject, eventdata, handles)
signal_type=zeros(3,1);
global SIGNAL_TYPE;
global CORR_TYPE;
global FC_METHOLD;
signal_type(1,1)=get(handles.checkbox_HbO,'Value');
signal_type(2,1)=get(handles.checkbox_HbR,'Value');
signal_type(3,1)=get(handles.checkbox_HbT,'Value');
SIGNAL_TYPE=signal_type;
if sum(signal_type)==0;
    uiwait(msgbox('There is no selected signal, please check!','Erro'));
    return;
end
%% seed based FC
if get(handles.Buttion_Seedbased,'Value')
    FC_METHOLD(1,1)=1;
    try
        seed=str2num(get(handles.channel_info,'String'));
        seed=[seed seed];
    catch
        uiwait(msgbox('Please check your input seed channel !','Erro'));
        return;
    end
    sublist=get(handles.list_sublist,'String');
    %%pearson corrletaion;
    if get(handles.checkbox_Pcorr,'Value');
        %do
        CORR_TYPE(1,1)=1;
        work_path=get(handles.directory_place,'String');
        
        sublist=get(handles.list_sublist,'String');
        if signal_type(1,1);
            Allsubject_HbO=cell(size(sublist,1),1);
        end
        if signal_type(2,1);
            Allsubject_HbR=cell(size(sublist,1),1);
        end
        if signal_type(3,1);
            Allsubject_HbT=cell(size(sublist,1),1);
        end
        for i=1:size(sublist,1)
            subject=sublist{i};
            tmp=load(strcat(work_path,'\processedData\',subject,'ProcData.mat'));
            if signal_type(1,1);
                seed_timeseries=mean(tmp.procResult.HbO(:,seed)');
                seed_timeseries=seed_timeseries';
                corr_map=corr(tmp.procResult.HbO,seed_timeseries);
                Allsubject_HbO{i,1}=corr_map;
                save(strcat('FC_result\',subject,'seed_HbO.mat'),'corr_map');
            end
            if signal_type(2,1);
                seed_timeseries=mean(tmp.procResult.HbR(:,seed)');
                seed_timeseries=seed_timeseries';
                corr_map=corr(tmp.procResult.HbR,seed_timeseries);
                Allsubject_HbR{i,1}=corr_map;
                save(strcat('FC_result\',subject,'seed_HbR.mat'),'corr_map')
            end
            if signal_type(3,1);
                seed_timeseries=mean(tmp.procResult.HbT(:,seed)');
                seed_timeseries=seed_timeseries';
                corr_map=corr(tmp.procResult.HbT,seed_timeseries);
                Allsubject_HbT{i,1}=corr_map;
                save(strcat('FC_result\',subject,'seed_HbT.mat'),'corr_map')
            end
        end
        
        if signal_type(1,1);
            save(strcat('FC_result\','ALlsubjectseed_HbO.mat'),'Allsubject_HbO');
        end
        if signal_type(2,1);
            save(strcat('FC_result\','ALlsubjectseed_HbR.mat'),'Allsubject_HbR');
        end
        if signal_type(3,1);
            save(strcat('FC_result\','ALlsubjectseed_HbT.mat'),'Allsubject_HbT');
        end
        
    end
    %% coss-correlation
    if get(handles.checkbox_Ccorr,'Value');
        CORR_TYPE(2,1)=1;
        %do
        work_path=get(handles.directory_place,'String');
        
        sublist=get(handles.list_sublist,'String');
        if signal_type(1,1);
            
            Allsubject_HbO=cell(size(sublist,1),1);
        end
        if signal_type(2,1);
            Allsubject_HbR=cell(size(sublist,1),1);
        end
        if signal_type(3,1);
            Allsubject_HbT=cell(size(sublist,1),1);
        end
        for i=1:size(sublist,1)
            subject=sublist{i};
            tmp=load(strcat(work_path,'\processedData\',subject,'ProcData.mat'));
            if signal_type(1,1);
                seed_timeseries=mean(tmp.procResult.HbO(:,seed)');
                seed_timeseries=seed_timeseries';
                corr_map=zeros(size(tmp.procResult.HbO,1),1);
                for ich=1:size(corr_map,1)
                     corr_map(ich,1)= max(xcorr(tmp.procResult.HbO(1:50:end,ich),seed_timeseries,...
                    10,'coef'));
                end
                corr_map=corr(tmp.procResult.HbO,seed_timeseries);
                Allsubject_HbO{i,1}=corr_map;
                save(strcat('FC_result\',subject,'seed_HbO.mat'),'corr_map');
            end
            if signal_type(2,1);
                seed_timeseries=mean(tmp.procResult.HbR(:,seed)');
                seed_timeseries=seed_timeseries';
               for ich=1:size(corr_map,1)
                     corr_map(ich,1)= max(xcorr(tmp.procResult.HbR(1:50:end,ich),seed_timeseries,...
                    10,'coef'));
                end
                Allsubject_HbR{i,1}=corr_map;
                save(strcat('FC_result\',subject,'seed_HbR.mat'),'corr_map')
            end
            if signal_type(3,1);
                seed_timeseries=mean(tmp.procResult.HbT(:,seed)');
                seed_timeseries=seed_timeseries';
                for ich=1:size(corr_map,1)
                     corr_map(ich,1)= max(xcorr(tmp.procResult.HbT(1:50:end,ich),seed_timeseries,...
                    10,'coef'));
                end
                Allsubject_HbT{i,1}=corr_map;
                save(strcat('FC_result\',subject,'seed_HbT.mat'),'corr_map')
            end
        end
        
        if signal_type(1,1);
            save(strcat('FC_result\','ALlsubject_seed_HbO.mat'),'Allsubject_HbO');
        end
        if signal_type(2,1);
            save(strcat('FC_result\','ALlsubject_seed_HbR.mat'),'Allsubject_HbR');
        end
        if signal_type(3,1);
            save(strcat('FC_result\','ALlsubject_seed_HbT.mat'),'Allsubject_HbT');
        end
        
    end
    
    
    
    
 
end
%% whole brain FC
if get(handles.Buttion_wholebrain,'Value')
    FC_METHOLD(2,1)=1;
    sublist=get(handles.list_sublist,'String');
    %%
    if get(handles.checkbox_Pcorr,'Value');
        %do
        CORR_TYPE(1,1)=1;
        work_path=get(handles.directory_place,'String');
        sublist=get(handles.list_sublist,'String');
        if signal_type(1,1);
            Allsubject_HbO=cell(size(sublist,1),1);
        end
        if signal_type(2,1);
            Allsubject_HbR=cell(size(sublist,1),1);
        end
        if signal_type(3,1);
            Allsubject_HbT=cell(size(sublist,1),1);
        end
        for i=1:size(sublist,1)
            subject=sublist{i};
            tmp=load(strcat(work_path,'\processedData\',subject,'ProcData.mat'));
            if signal_type(1,1);
                %                 seed_timeseries=mean(tmp.procResult.HbO(:,seed)');
                %                 seed_timeseries=seed_timeseries';
                corr_map=corr(tmp.procResult.HbO);
                Allsubject_HbO{i,1}=corr_map;
                save(strcat('FC_result\',subject,'wholebrain_HbO.mat'),'corr_map');
            end
            if signal_type(2,1);
                %                seed_timeseries=mean(tmp.procResult.HbR(:,seed)');
                %                 seed_timeseries=seed_timeseries';
                corr_map=corr(tmp.procResult.HbR);
                Allsubject_HbR{i,1}=corr_map;
                save(strcat('FC_result\',subject,'wholebrain_HbR.mat'),'corr_map')
            end
            if signal_type(3,1);
                %                 seed_timeseries=mean(tmp.procResult.HbT(:,seed)');
                %                 seed_timeseries=seed_timeseries';
                corr_map=corr(tmp.procResult.HbT);
                Allsubject_HbT{i,1}=corr_map;
                save(strcat('FC_result\',subject,'wholebrain_HbT.mat'),'corr_map')
            end
        end
        
        if signal_type(1,1);
            save(strcat('FC_result\','Allsubject_whole_HbO.mat'),'Allsubject_HbO');
        end
        if signal_type(2,1);
            save(strcat('FC_result\','Allsubject_whole_HbR.mat'),'Allsubject_HbR');
        end
        if signal_type(3,1);
            save(strcat('FC_result\','Allsubject_whole_HbT.mat'),'Allsubject_HbT');
        end
        
    end
    
    %%%cross-correlation
    if get(handles.checkbox_Pcorr,'Value');
        %do
        %do
        CORR_TYPE(2,1)=1;
        work_path=get(handles.directory_place,'String');
        sublist=get(handles.list_sublist,'String');
        if signal_type(1,1);
            Allsubject_HbO=cell(size(sublist,1),1);
        end
        if signal_type(2,1);
            Allsubject_HbR=cell(size(sublist,1),1);
        end
        if signal_type(3,1);
            Allsubject_HbT=cell(size(sublist,1),1);
        end
        for i=1:size(sublist,1)
            subject=sublist{i};
            tmp=load(strcat(work_path,'\processedData\',subject,'ProcData.mat'));
            if signal_type(1,1);
                %                 seed_timeseries=mean(tmp.procResult.HbO(:,seed)');
                %                 seed_timeseries=seed_timeseries';
               %  figure;imagesc(corr(x(1:50:end,:)))
                corr_map=reshape(max(xcorr(tmp.procResult.HbO(1:50:end,:),...
                    10,'coef')),size(tmp.procResult.HbO,2),size(tmp.procResult.HbO,2));
                Allsubject_HbO{i,1}=corr_map;
                save(strcat('FC_result\',subject,'wholebrain_HbO.mat'),'corr_map');
            end
            if signal_type(2,1);
                %                seed_timeseries=mean(tmp.procResult.HbR(:,seed)');
                %                 seed_timeseries=seed_timeseries';
               corr_map=reshape(max(xcorr(tmp.procResult.HbR(1:50:end,:),...
                    10,'coef')),size(tmp.procResult.HbR,2),size(tmp.procResult.HbR,2));
                Allsubject_HbR{i,1}=corr_map;
                save(strcat('FC_result\',subject,'wholebrain_HbR.mat'),'corr_map')
            end
            if signal_type(3,1);
                %                 seed_timeseries=mean(tmp.procResult.HbT(:,seed)');
                %                 seed_timeseries=seed_timeseries';
               corr_map=reshape(max(xcorr(tmp.procResult.HbT(1:50:end,:),...
                    10,'coef')),size(tmp.procResult.HbT,2),size(tmp.procResult.HbT,2));
                Allsubject_HbT{i,1}=corr_map;
                save(strcat('FC_result\',subject,'wholebrain_HbT.mat'),'corr_map')
            end
        end
        if signal_type(1,1);
            save(strcat('FC_result\','Allsubjects_whole_HbO.mat'),'Allsubject_HbO');
        end
        if signal_type(2,1);
            save(strcat('FC_result\','Allsubjects_whole_HbR.mat'),'Allsubject_HbR');
        end
        if signal_type(3,1);
            save(strcat('FC_result\','Allsubjects_whole_HbT.mat'),'Allsubject_HbT');
        end
    end
    end
end