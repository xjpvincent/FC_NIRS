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
for sub=1:size(display_datalist,1)
   subname=display_datalist{sub,1};
   datapath=fullfile(strcat(input_directory,'/',subname));
   procResult=[];
   raw=importdata(datapath);
   procResult.rawdata=raw;
   procResult.SD=raw.SD;
   for mindex=1:size(callist,1)
       for i=1:size(PARA_LIST,1)
           if ~isempty(strfind(PARA_LIST{i,1}.name,callist{mindex,1}))
               method_function=str2func(PARA_LIST{i,1}.func);
               para=PARA_LIST{i,1}.para;
               procResult=method_function(procResult,str2num(para));
               %set(handles.
               break;
           end
       end
   end
   %
   outpath=fullfile(strcat(output_directory,'/',subname(1:end-4),'proc'));
   if ~(exist(output_directory,'dir')==7)
        mkdir(fullfile(output_directory));
   end
   save (outpath, 'procResult');
   waitbar(sub/ size(display_datalist,1),h,...
       strcat(display_datalist{sub},' is finished'));
end
close(h);
end

