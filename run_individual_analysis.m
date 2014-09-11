function out_put=run_individual_analysis(hObject, eventdata, handles)
global ANALYSIS_PARA;
signal_type=ANALYSIS_PARA.signal_type;
if sum(signal_type)==0;
    uiwait(msgbox('There is no selected signal, please check!','Erro'));
    return;
end
input_directory=get(handles.input_directory,'String');
output_directory=get(handles.output_directory,'String');
if ~(exist(output_directory,'dir')==7)
        mkdir(fullfile(output_directory));
end
%% seed based FC
%set the corr method
fc_function=str2func(...
    ANALYSIS_PARA.corr_type{ANALYSIS_PARA.corr_choose}.func);

if strcmp(ANALYSIS_PARA.fc_method,'seed-based')
    seed=ANALYSIS_PARA.seed;
    if isempty(seed)
        return;
    end
    sublist=get(handles.sublist,'String');
    if isempty(sublist)
        return;
    end
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
        tmp=importdata(fullfile(input_directory,filesep,subject));
        if signal_type(1,1);
            if length(seed)>1
            seed_timeseries=mean(tmp.procConc.HbO(:,seed)');
            seed_timeseries=seed_timeseries';
            else
                seed_timeseries=tmp.procConc.HbO(:,seed);
            end
         
            corr_map=fc_function(tmp.procConc.HbO,seed_timeseries,ANALYSIS_PARA.fc_method);
            Allsubject_HbO{i,1}=corr_map;
            save(fullfile(output_directory,filesep,strcat(subject(1:end-5),'seed_HbO.mat')),'corr_map');
        end
        if signal_type(2,1);
            if length(seed)>1
                seed_timeseries=mean(tmp.procConc.HbR(:,seed)');
                seed_timeseries=seed_timeseries';
            else
                seed_timeseries=tmp.procConc.HbR(:,seed);
            end
            corr_map=fc_function(tmp.procConc.HbR,seed_timeseries,ANALYSIS_PARA.fc_method);
            Allsubject_HbR{i,1}=corr_map;
            save(fullfile(output_directory,filesep,strcat(subject(1:end-5),'seed_HbR.mat')),'corr_map')
        end
        if signal_type(3,1);
            if length(seed)>1
                seed_timeseries=mean(tmp.procConc.HbT(:,seed)');
                seed_timeseries=seed_timeseries';
            else
                seed_timeseries=tmp.procConc.HbT(:,seed);
            end
            corr_map=fc_function(tmp.procConc.HbT,seed_timeseries,ANALYSIS_PARA.fc_method);
            Allsubject_HbT{i,1}=corr_map;
            save(fullfile(output_directory,filesep,strcat(subject(1:end-5),'seed_HbT.mat')),'corr_map')
        end
    end
       if signal_type(1,1);
            save(fullfile(output_directory,filesep,'Allsubjects_seed_HbO.mat'),'Allsubject_HbO');
        end
        if signal_type(2,1);
            save(fullfile(output_directory,filesep,'Allsubjects_seed_HbR.mat'),'Allsubject_HbR');
        end
        if signal_type(3,1);
            save(fullfile(output_directory,filesep,'Allsubjects_seed_HbT.mat'),'Allsubject_HbT');
        end
end


%% whole brain FC
if strcmp(ANALYSIS_PARA.fc_method,'whole-brain')
    sublist=get(handles.sublist,'String');
    if isempty(sublist)
        return;
    end
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
        tmp=importdata(fullfile(input_directory,filesep,subject));
        if signal_type(1,1);
            corr_map=fc_function(tmp.procConc.HbO,[],ANALYSIS_PARA.fc_method);
            Allsubject_HbO{i,1}=corr_map;
            save(fullfile(output_directory,filesep,strcat(subject(1:end-5),'wholebrain_HbO.mat')),'corr_map');
        end
        if signal_type(2,1);
            corr_map=fc_function(tmp.procConc.HbR,[],ANALYSIS_PARA.fc_method);
            Allsubject_HbR{i,1}=corr_map;
            save(fullfile(output_directory,filesep,strcat(subject(1:end-5),'wholebrain_HbR.mat')),'corr_map')
        end
        if signal_type(3,1);
            corr_map=fc_function(tmp.procConc.HbT,[],ANALYSIS_PARA.fc_method);
            Allsubject_HbT{i,1}=corr_map;
            save(fullfile(output_directory,filesep,strcat(subject(1:end-5),'wholebrain_HbT.mat')),'corr_map')
        end
    end
    
    if signal_type(1,1);
        save(fullfile(output_directory,filesep,'Allsubjects_whole_HbO.mat'),'Allsubject_HbO');
    end
    if signal_type(2,1);
        save(fullfile(output_directory,filesep,'Allsubjects_whole_HbR.mat'),'Allsubject_HbR');
    end
    if signal_type(3,1);
        save(fullfile(output_directory,filesep,'Allsubjects_whole_HbT.mat'),'Allsubject_HbT');
    end
end

function fc_map=fc_pearson(x,y,fc_method)
if strcmp(fc_method,'seed-based')
    fc_map=corr(x,y);
end
if strcmp(fc_method,'whole-brain')
    fc_map=corr(x);
end
function fc_map=fc_cross(x,y,fc_method)
if strcmp(fc_method,'seed-based')
    fc_map=corr(x,y);
end
if strcmp(fc_method,'whole-brain')
    fc_map=corr(x);
end
function fc_map=fc_spearman(x,y,fc_method)
if strcmp(fc_method,'seed-based')
    fc_map=corr(x,y,'type','Spearman');
end
if strcmp(fc_method,'whole-brain')
    fc_map=corr(x,'type','Spearman');
end
