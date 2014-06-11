function out_put=run_group_analysis(hObject, eventdata, handles)

maptype=zeros(4,1);
if get(handles.checkbox_R,'Value');
    maptype(1,1)=1;
end
if get(handles.checkbox_Z,'Value');
    maptype(2,1)=1;
end
if get(handles.checkbox_Z2R,'Value');
    maptype(3,1)=1;
end
if get(handles.checkbox_T,'Value');
    maptype(4,1)=1;
end
signal_type(1,1)=get(handles.checkbox_HbO,'Value');
signal_type(2,1)=get(handles.checkbox_HbR,'Value');
signal_type(3,1)=get(handles.checkbox_HbT,'Value');

if sum(signal_type)==0;
    uiwait(msgbox('You haven''t  select the map type , please check!','Erro'));
    return;
end

output_directory=get(handles.out_directory,'String');

if get(handles.Buttion_Seedbased,'Value')
    %do Seed based FC group analysis
    sublist=get(handles.list_sublist,'String');
    %% HbO seed based FC analysis;
    if signal_type(1,1);
        tmp=load(fullfile(output_directory,'\','Allsubjects_seed_HbO.mat'));               
        if maptype(1,1)==1;
           seed_groupMap_HbO_R=tmp.Allsubject_HbO{1,1};
           for sidx=2:size(tmp.Allsubject_HbO,1)
               seed_groupMap_HbO_R=seed_groupMap_HbO_R+tmp.Allsubject_HbO{sidx,1};
               %group_map_R;
           end
           seed_groupMap_HbO_R=seed_groupMap_HbO_R./size(tmp.Allsubject_HbO,1);
           save(fullfile(output_directory,'\','seed_groupMap_HbO_R.mat'),'seed_groupMap_HbO_R');
          %maptype(1,1)=1;
        end
        if maptype(2,1)==1
          seed_groupMap_HbO_Z=fisherz(tmp.Allsubject_HbO{1,1});
           for sidx=2:size(tmp.Allsubject_HbO,1)
               seed_groupMap_HbO_Z=seed_groupMap_HbO_Z+fisherz(tmp.Allsubject_HbO{sidx,1});
               %group_map_R;
           end
           seed_groupMap_HbO_Z=seed_groupMap_HbO_Z./size(tmp.Allsubject_HbO,1);
           save(fullfile(output_directory,'\','seed_groupMap_HbO_Z.mat'),'seed_groupMap_HbO_Z');
          %maptype(1,1)=1;
         
        end
        if  maptype(3,1)==1;
           seed_groupMap_HbO_Z2R=fisherz(tmp.Allsubject_HbO{1,1});
           for sidx=2:size(tmp.Allsubject_HbO,1)
               seed_groupMap_HbO_Z2R=seed_groupMap_HbO_Z2R+fisherz(tmp.Allsubject_HbO{sidx,1});
               %group_map_R;
           end
           seed_groupMap_HbO_Z2R=ifisherz(seed_groupMap_HbO_Z2R./size(tmp.Allsubject_HbO,1));
           save(fullfile(output_directory,'\','seed_groupMap_HbO_Z2R.mat'),'seed_groupMap_HbO_Z2R');
          %maptype(1,1)=1;
        end
        
        
        if  maptype(4,1)==1;
            z_value=zeros(size(tmp.Allsubject_HbO,1),size(tmp.Allsubject_HbO{1,1},1));
            for sidx=1:size(tmp.Allsubject_HbO,1)
               z_value(sidx,:)=[fisherz(tmp.Allsubject_HbO{sidx,1})]';
               %group_map_R;
            end
           [a b c d]=ttest(z_value);
           seed_groupMap_HbO_T=[d.tstat]';
           %seed_groupMap_HbO_T=seed_groupMap_HbO_Z2R./size(tmp.Allsubject_HbO,1);
           save(fullfile(output_directory,'\','seed_groupMap_HbO_T.mat'),'seed_groupMap_HbO_T');
          %maptype(1,1)=1;
        end
    end
    %% HbR signal seed based analysis£»
    if signal_type(2,1);
        tmp=load(fullfile(output_directory,'\','Allsubjects_seed_HbR.mat'));               
        if maptype(1,1)==1;
           seed_groupMap_HbR_R=tmp.Allsubject_HbR{1,1};
           for sidx=2:size(tmp.Allsubject_HbR,1)
               seed_groupMap_HbR_R=seed_groupMap_HbR_R+tmp.Allsubject_HbR{sidx,1};
               %group_map_R;
           end
           seed_groupMap_HbR_R=seed_groupMap_HbR_R./size(tmp.Allsubject_HbR,1);
           save(fullfile(output_directory,'\','seed_groupMap_HbR_R.mat'),'seed_groupMap_HbR_R');
          %maptype(1,1)=1;
        end
        if maptype(2,1)==1
          seed_groupMap_HbR_Z=fisherz(tmp.Allsubject_HbR{1,1});
           for sidx=2:size(tmp.Allsubject_HbR,1)
               seed_groupMap_HbR_Z=seed_groupMap_HbR_Z+fisherz(tmp.Allsubject_HbR{sidx,1});
               %group_map_R;
           end
           seed_groupMap_HbR_Z=seed_groupMap_HbR_Z./size(tmp.Allsubject_HbR,1);
           save(fullfile(output_directory,'\','seed_groupMap_HbR_Z.mat'),'seed_groupMap_HbR_Z');
          %maptype(1,1)=1;
         
        end
        if  maptype(3,1)==1;
           seed_groupMap_HbR_Z2R=fisherz(tmp.Allsubject_HbR{1,1});
           for sidx=2:size(tmp.Allsubject_HbR,1)
               seed_groupMap_HbR_Z2R=seed_groupMap_HbR_Z2R+fisherz(tmp.Allsubject_HbR{sidx,1});
               %group_map_R;
           end
           seed_groupMap_HbR_Z2R=ifisherz(seed_groupMap_HbR_Z2R./size(tmp.Allsubject_HbR,1));
           save(fullfile(output_directory,'\','seed_groupMap_HbR_Z2R.mat'),'seed_groupMap_HbR_Z2R');
          %maptype(1,1)=1;
        end
        
        
        if  maptype(4,1)==1;
            z_value=zeros(size(tmp.Allsubject_HbR,1),size(tmp.Allsubject_HbR{1,1},1));
            for sidx=1:size(tmp.Allsubject_HbR,1)
               z_value(sidx,:)=[fisherz(tmp.Allsubject_HbR{sidx,1})]';
               %group_map_R;
            end
           [a b c d]=ttest(z_value);
           seed_groupMap_HbR_T=[d.tstat]';
           %seed_groupMap_HbR_T=seed_groupMap_HbR_Z2R./size(tmp.Allsubject_HbR,1);
           save(fullfile(output_directory,'\','seed_groupMap_HbR_T.mat'),'seed_groupMap_HbR_T');
          %maptype(1,1)=1;
        end 
    end
    %% HbT signal seed based analysis£»
    if signal_type(3,1)==1;
   
        tmp=load(fullfile(output_directory,'\','Allsubjects_seed_HbT.mat'));               
        if maptype(1,1)==1;
           seed_groupMap_HbT_R=tmp.Allsubject_HbT{1,1};
           for sidx=2:size(tmp.Allsubject_HbT,1)
               seed_groupMap_HbT_R=seed_groupMap_HbT_R+tmp.Allsubject_HbT{sidx,1};
               %group_map_R;
           end
           seed_groupMap_HbT_R=seed_groupMap_HbT_R./size(tmp.Allsubject_HbT,1);
           save(fullfile(output_directory,'\','seed_groupMap_HbT_R.mat'),'seed_groupMap_HbT_R');
          %maptype(1,1)=1;
        end
        if maptype(2,1)==1
          seed_groupMap_HbT_Z=fisherz(tmp.Allsubject_HbT{1,1});
           for sidx=2:size(tmp.Allsubject_HbT,1)
               seed_groupMap_HbT_Z=seed_groupMap_HbT_Z+fisherz(tmp.Allsubject_HbT{sidx,1});
               %group_map_R;
           end
           seed_groupMap_HbT_Z=seed_groupMap_HbT_Z./size(tmp.Allsubject_HbT,1);
           save(fullfile(output_directory,'\','seed_groupMap_HbT_Z.mat'),'seed_groupMap_HbT_Z');
          %maptype(1,1)=1;
         
        end
        if  maptype(3,1)==1;
           seed_groupMap_HbT_Z2R=fisherz(tmp.Allsubject_HbT{1,1});
           for sidx=2:size(tmp.Allsubject_HbT,1)
               seed_groupMap_HbT_Z2R=seed_groupMap_HbT_Z2R+fisherz(tmp.Allsubject_HbT{sidx,1});
               %group_map_R;
           end
           seed_groupMap_HbT_Z2R=ifisherz(seed_groupMap_HbT_Z2R./size(tmp.Allsubject_HbT,1));
           save(fullfile(output_directory,'\','seed_groupMap_HbT_Z2R.mat'),'seed_groupMap_HbT_Z2R');
          %maptype(1,1)=1;
        end
        
        
        if  maptype(4,1)==1;
            z_value=zeros(size(tmp.Allsubject_HbT,1),size(tmp.Allsubject_HbT{1,1},1));
            for sidx=1:size(tmp.Allsubject_HbT,1)
               z_value(sidx,:)=[fisherz(tmp.Allsubject_HbT{sidx,1})]';
               %group_map_R;
            end
           [a b c d]=ttest(z_value);
           seed_groupMap_HbT_T=[d.tstat]';
           %seed_groupMap_HbT_T=seed_groupMap_HbT_Z2R./size(tmp.Allsubject_HbT,1);
           save(fullfile(output_directory,'\','seed_groupMap_HbT_T.mat'),'seed_groupMap_HbT_T');
          %maptype(1,1)=1;
    end
    end
end


%%%%%
if get(handles.Buttion_wholebrain,'Value')
    % do Whole-Brain FC group analysis

    sublist=get(handles.list_sublist,'String');
    %% HbO whole brain FC analysis;
    if signal_type(1,1);
        tmp=load(fullfile(output_directory,'\','Allsubjects_whole_HbO.mat'));               
        if maptype(1,1)==1;
           whole_groupMap_HbO_R=tmp.Allsubject_HbO{1,1};
           for sidx=2:size(tmp.Allsubject_HbO,1)
               whole_groupMap_HbO_R=whole_groupMap_HbO_R+tmp.Allsubject_HbO{sidx,1};
               %group_map_R;
           end
           whole_groupMap_HbO_R=whole_groupMap_HbO_R./size(tmp.Allsubject_HbO,1);
           save(fullfile(output_directory,'\','whole_groupMap_HbO_R.mat'),'whole_groupMap_HbO_R');
          %maptype(1,1)=1;
        end
        if maptype(2,1)==1
          whole_groupMap_HbO_Z=fisherz(tmp.Allsubject_HbO{1,1});
           for sidx=2:size(tmp.Allsubject_HbO,1)
               whole_groupMap_HbO_Z=whole_groupMap_HbO_Z+fisherz(tmp.Allsubject_HbO{sidx,1});
               %group_map_R;
           end
           whole_groupMap_HbO_Z=whole_groupMap_HbO_Z./size(tmp.Allsubject_HbO,1);
           save(fullfile(output_directory,'\','whole_groupMap_HbO_Z.mat'),'whole_groupMap_HbO_Z');
          %maptype(1,1)=1;
         
        end
        if  maptype(3,1)==1;
           whole_groupMap_HbO_Z2R=fisherz(tmp.Allsubject_HbO{1,1});
           for sidx=2:size(tmp.Allsubject_HbO,1)
               whole_groupMap_HbO_Z2R=whole_groupMap_HbO_Z2R+fisherz(tmp.Allsubject_HbO{sidx,1});
               %group_map_R;
           end
           whole_groupMap_HbO_Z2R=ifisherz(whole_groupMap_HbO_Z2R./size(tmp.Allsubject_HbO,1));
           save(fullfile(output_directory,'\','whole_groupMap_HbO_Z2R.mat'),'whole_groupMap_HbO_Z2R');
          %maptype(1,1)=1;
        end
        
        
        if  maptype(4,1)==1;
            z_value=zeros(size(tmp.Allsubject_HbO,1),size(tmp.Allsubject_HbO{1,1},1));
            for sidx=1:size(tmp.Allsubject_HbO,1)
               z_value(sidx,:)=[fisherz(tmp.Allsubject_HbO{sidx,1})]';
               %group_map_R;
            end
           [a b c d]=ttest(z_value);
           whole_groupMap_HbO_T=[d.tstat]';
           %whole_groupMap_HbO_T=whole_groupMap_HbO_Z2R./size(tmp.Allsubject_HbO,1);
           save(fullfile(output_directory,'\','whole_groupMap_HbO_T.mat'),'whole_groupMap_HbO_T');
          %maptype(1,1)=1;
        end
    end
    %% HbR signal seed based analysis£»
    if signal_type(2,1);
        tmp=load(fullfile(output_directory,'\','ALlsubjects_whole_HbR.mat'));               
        if maptype(1,1)==1;
           whole_groupMap_HbR_R=tmp.Allsubject_HbR{1,1};
           for sidx=2:size(tmp.Allsubject_HbR,1)
               whole_groupMap_HbR_R=whole_groupMap_HbR_R+tmp.Allsubject_HbR{sidx,1};
               %group_map_R;
           end
           whole_groupMap_HbR_R=whole_groupMap_HbR_R./size(tmp.Allsubject_HbR,1);
           save(fullfile(output_directory,'\','whole_groupMap_HbR_R.mat'),'whole_groupMap_HbR_R');
          %maptype(1,1)=1;
        end
        if maptype(2,1)==1
          whole_groupMap_HbR_Z=fisherz(tmp.Allsubject_HbR{1,1});
           for sidx=2:size(tmp.Allsubject_HbR,1)
               whole_groupMap_HbR_Z=whole_groupMap_HbR_Z+fisherz(tmp.Allsubject_HbR{sidx,1});
               %group_map_R;
           end
           whole_groupMap_HbR_Z=whole_groupMap_HbR_Z./size(tmp.Allsubject_HbR,1);
           save(fullfile(output_directory,'\','whole_groupMap_HbR_Z.mat'),'whole_groupMap_HbR_Z');
          %maptype(1,1)=1;
         
        end
        if  maptype(3,1)==1;
           whole_groupMap_HbR_Z2R=fisherz(tmp.Allsubject_HbR{1,1});
           for sidx=2:size(tmp.Allsubject_HbR,1)
               whole_groupMap_HbR_Z2R=whole_groupMap_HbR_Z2R+fisherz(tmp.Allsubject_HbR{sidx,1});
               %group_map_R;
           end
           whole_groupMap_HbR_Z2R=ifisherz(whole_groupMap_HbR_Z2R./size(tmp.Allsubject_HbR,1));
           save(fullfile(output_directory,'\','whole_groupMap_HbR_Z2R.mat'),'whole_groupMap_HbR_Z2R');
          %maptype(1,1)=1;
        end
        
        
        if  maptype(4,1)==1;
            z_value=zeros(size(tmp.Allsubject_HbR,1),size(tmp.Allsubject_HbR{1,1},1));
            for sidx=1:size(tmp.Allsubject_HbR,1)
               z_value(sidx,:)=[fisherz(tmp.Allsubject_HbR{sidx,1})]';
               %group_map_R;
            end
           [a b c d]=ttest(z_value);
           whole_groupMap_HbR_T=[d.tstat]';
           %whole_groupMap_HbR_T=whole_groupMap_HbR_Z2R./size(tmp.Allsubject_HbR,1);
           save(fullfile(output_directory,'\','whole_groupMap_HbR_T.mat'),'whole_groupMap_HbR_T');
          %maptype(1,1)=1;
        end 
    end
    %% HbT signal seed based analysis£»
    if signal_type(3,1)==1;
   
        tmp=load(fullfile(output_directory,'\','ALlsubjects_whole_HbT.mat'));               
        if maptype(1,1)==1;
           whole_groupMap_HbT_R=tmp.Allsubject_HbT{1,1};
           for sidx=2:size(tmp.Allsubject_HbT,1)
               whole_groupMap_HbT_R=whole_groupMap_HbT_R+tmp.Allsubject_HbT{sidx,1};
               %group_map_R;
           end
           whole_groupMap_HbT_R=whole_groupMap_HbT_R./size(tmp.Allsubject_HbT,1);
           save(fullfile(output_directory,'\','whole_groupMap_HbT_R.mat'),'whole_groupMap_HbT_R');
          %maptype(1,1)=1;
        end
        if maptype(2,1)==1
          whole_groupMap_HbT_Z=fisherz(tmp.Allsubject_HbT{1,1});
           for sidx=2:size(tmp.Allsubject_HbT,1)
               whole_groupMap_HbT_Z=whole_groupMap_HbT_Z+fisherz(tmp.Allsubject_HbT{sidx,1});
               %group_map_R;
           end
           whole_groupMap_HbT_Z=whole_groupMap_HbT_Z./size(tmp.Allsubject_HbT,1);
           save(fullfile(output_directory,'\','whole_groupMap_HbT_Z.mat'),'whole_groupMap_HbT_Z');
          %maptype(1,1)=1;
         
        end
        if  maptype(3,1)==1;
           whole_groupMap_HbT_Z2R=fisherz(tmp.Allsubject_HbT{1,1});
           for sidx=2:size(tmp.Allsubject_HbT,1)
               whole_groupMap_HbT_Z2R=whole_groupMap_HbT_Z2R+fisherz(tmp.Allsubject_HbT{sidx,1});
               %group_map_R;
           end
           whole_groupMap_HbT_Z2R=ifisherz(whole_groupMap_HbT_Z2R./size(tmp.Allsubject_HbT,1));
           save(fullfile(output_directory,'\','whole_groupMap_HbT_Z2R.mat'),'whole_groupMap_HbT_Z2R');
          %maptype(1,1)=1;
        end
        
        
        if  maptype(4,1)==1;
            z_value=zeros(size(tmp.Allsubject_HbT,1),size(tmp.Allsubject_HbT{1,1},1));
            for sidx=1:size(tmp.Allsubject_HbT,1)
               z_value(sidx,:)=[fisherz(tmp.Allsubject_HbT{sidx,1})]';
               %group_map_R;
            end
           [a b c d]=ttest(z_value);
           whole_groupMap_HbT_T=[d.tstat]';
           %whole_groupMap_HbT_T=whole_groupMap_HbT_Z2R./size(tmp.Allsubject_HbT,1);
           save(fullfile(output_directory,'\','whole_groupMap_HbT_T.mat'),'whole_groupMap_HbT_T');
          %maptype(1,1)=1;
    end
    end
end

function[z]=fisherz(r)
%FISHERZ Fisher's Z-transform.
%   Z = FISHERZ(R) returns the Fisher's Z-transform of the correlation
%   coefficient R.
%r=r(:);
z=.5.*log((1+r)./(1-r));

function[r]=ifisherz(z)
%IFISHERZ Inverse Fisher's Z-transform.
%   R = IFISHERZ(Z) re-transforms Z into the correlation coefficient R.
%z=z(:);
r=(exp(2*z)-1)./(exp(2*z)+1);

