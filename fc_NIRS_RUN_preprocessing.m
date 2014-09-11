function [ output_args ] = fc_NIRS_RUN_preprocessing(hObject, eventdata, handles, varargin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global PARA_LIST;
callist=get(handles.CalListbox,'String');
input_directory=get(handles.input_directory,'String');
display_datalist=get(handles.display_datalist,'String');
output_directory=get(handles.output_directory,'String');
%selectValue=get(handles.CalListbox,'Value');
if isempty(display_datalist)
    for tmp=1:5
    set(handles.display_datalist,'BackgroundColor',[1 0 0]);
    pause(0.1);
    set(handles.display_datalist,'BackgroundColor',[1 1 1]);
    pause(0.1);
    end
    return;
end
if isempty(callist)
    for tmp=1:5
    set(handles.CalListbox,'BackgroundColor',[1 0 0]);
    pause(0.1);
    set(handles.CalListbox,'BackgroundColor',[1 1 1]);
    pause(0.1);
    end
    return;
end

 h=waitbar(0,'Please wait...');
 %writing log file;
  if ~(exist(output_directory,'dir')==7)
        mkdir(fullfile(output_directory));
   end
 fid=fopen(fullfile(output_directory,filesep,...
     'processing.log'),'w');
 fprintf(fid,'%s\n',strcat('Data file directory:',input_directory));
 fprintf(fid,'%s\n',strcat('Result file directory:',output_directory)); 
 
 
for sub=1:size(display_datalist,1)
   subname=display_datalist{sub,1};
   datapath=fullfile(strcat(input_directory,filesep,subname));
   procResult=[];
   raw=importdata(datapath);
   procResult.rawdata=raw;
   procResult.SD=raw.SD;
   for mindex=1:size(callist,1)
       for i=1:size(PARA_LIST,1)
           if ~isempty(strfind(PARA_LIST{i,1}.name,callist{mindex,1}))
               fprintf(fid,'%s\n',strcat(datestr(now,31)));
               if ~isempty(strfind(PARA_LIST{i}.name,'MotionCorrect_Spline'))
                   para=PARA_LIST{i,1}.para;
                   fprintf(fid,'%s',strcat('->execute ',PARA_LIST{i,1}.name,'; ',...
                   PARA_LIST{i,1}.para_info),':'); 
                   fprintf(fid,'%s',strcat('STDEVthresh:-->',num2str(para.STDEVthresh),...
                       'AMPthresh:--->',num2str(para.AMPthresh),...
                       ';','tMotion:-->',num2str(para.tMotion),';',...
                       'tMask:-->',num2str(para.tMask),';',...
                       'p:-->',num2str(para.p),';')); 
               
               else
               fprintf(fid,'%s',strcat('->execute: ',PARA_LIST{i,1}.name,'; ',...
               PARA_LIST{i,1}.para_info),':',PARA_LIST{i,1}.para);              
               end
               method_function=str2func(PARA_LIST{i,1}.func);
               para=PARA_LIST{i,1}.para;
               procResult=method_function(procResult,para);
               fprintf(fid,'%s\n','down.');
               %set(handles.
               break;
           end
       end
   end
   %
   outpath=fullfile(strcat(output_directory,filesep,subname(1:end-4),'proc'));
   if ~(exist(output_directory,'dir')==7)
        mkdir(fullfile(output_directory));
   end
   save (outpath, 'procResult');
   waitbar(sub/ size(display_datalist,1),h,...
       strcat(display_datalist{sub},' is finished'));
end
std=fclose(fid);
close(h);
end

