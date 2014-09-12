function []=FC_NIRS_Precessing(hObject, eventdata, handles)
%Intensity2OD
%handles=guihandles(GUI_DATA.handles);
mkdir('precessedData');
hpf=str2num(get(handles.hpf_text,'String'));
lpf=str2num(get(handles.lpf_text,'String'));
workpath=GUI_DATA.plotstate.workpath;
sublist=get(handles.display_directory,'String');
n=get(handles.display_directory,'Value');
plot_subject=sublist{n};

%precessing the current subject
if get(handles.check_current,'Value')>0;
    SD=GUI_DATA.currentData.SD;
    d=GUI_DATA.currentData.d;
    fs=GUI_DATA.currentData.t;
    ppf=[6.0 6.0];
    %detrend
    d=spm_detrend(d,1);
    [dc, dod] = restNIRS_Intensity2Conc( d, SD, fs, hpf, lpf, ppf );
    %
    %procResult.SD=SD;
    %procResult.d=d;
    %procResult.t=RawData.t;
    %procResult.s=RawData.s;
    GUI_DATA.currentData.dc=dc;
    GUI_DATA.currentData.dod=dod;
    procResult.RawData=RawData;
    procResult.dc=dc;
    procResult.dod=dod;
    %HbO,HbR,HbT data;
    Conc.HbO=squeeze(dc(:,1,:));
    Conc.HbR=squeeze(dc(:,2,:));
    Conc.HbT=squeeze(dc(:,3,:));
    %corr_matrix
    Corr_matrix.HbO=corr(Conc.HbO);
    Corr_matrix.HbR=corr(Conc.HbR);
    Corr_matrix.HbT=corr(Conc.HbT);
    Conc.t=RawData.t;
%     save(strcat(workpath,'\','precessedData\',sublist{i}(1:end-5),'.mat'),'procResult');
%     save(strcat(workpath,'\','precessedData\',sublist{i}(1:end-5),'Conc.mat'),'Conc');
%     save(strcat(workpath,'\','precessedData\',sublist{i}(1:end-5),'Corr_matrix.mat'),'Corr_matrix');
    %
end

%set(handles.conc_type,'Enable','on');
set(handles.radio_Conc,'Enable','on');
%group precessing
% clear i;

if get(handles.check_group,'Value')>0
    %display the workstate
    h=waitbar(0,'Please wait...');
    length=size(sublist,1);
    networkMatrix=cell(length,3);
    for i=1:size(sublist,1)
        %Intensity2Con
        RawData=importdata(strcat(workpath,'\RawData\',sublist{i}));
        SD=RawData.SD;
        d=RawData.d;
        fs=RawData.t;
        ppf=[6.0 6.0];
        %detrend
        d=spm_detrend(d,1);
        [dc, dod] = restNIRS_Intensity2Conc( d, SD, fs, hpf, lpf, ppf );
        %
        %procResult.SD=SD;
        %procResult.d=d;
        %procResult.t=RawData;
        procResult.RawData=RawData;
        procResult.dc=dc;
        procResult.dod=dod;
        procResult.HbO=squeeze(dc(:,1,:));
        procResult.HbR=squeeze(dc(:,2,:));
        procResult.HbT=squeeze(dc(:,3,:));
        %HbO,HbR,HbT data;
        Conc.HbO=squeeze(dc(:,1,:));
        Conc.HbR=squeeze(dc(:,2,:));
        Conc.HbT=squeeze(dc(:,3,:));
        %corr_matrix
        Corr_matrix.HbO=corr(Conc.HbO);
        Corr_matrix.HbR=corr(Conc.HbR);
        Corr_matrix.HbT=corr(Conc.HbT);
        
        %  networkMatrix=cell(length,3);
        networkMatrix{i,1}=Corr_matrix.HbO;
        networkMatrix{i,2}=Corr_matrix.HbR;
        networkMatrix{i,3}=Corr_matrix.HbT;
        Conc.t=RawData.t;
        waitbar(i/ length,h,strcat(sublist{i},' is finished'));
%         if exist(strcat(workpath,'\','precessedData\',sublist{i}(1:end-5),'.mat'),'file')
%             choice=questdlg(strcat('There already exist the   ',sublist{i},''',s processed result.Do you want to cover it?'),...
%                 'Warning','Yes','No','Yes');
%             switch choice
%                 case 'Yes'
                    save(strcat(workpath,'\','precessedData\',sublist{i}(1:end-5),'.mat'),'procResult');
                    save(strcat(workpath,'\','precessedData\',sublist{i}(1:end-5),'Conc.mat'),'Conc');
                    save(strcat(workpath,'\','precessedData\',sublist{i}(1:end-5),'Corr_matrix.mat'),'Corr_matrix');
                
%                 case 'No'
%                     return
%             end
            save(strcat(workpath,'\','precessedData\',sublist{i}(1:end-5),'.proc'),'procResult');
       %     save(strcat(workpath,'\','precessedData\',sublist{i}(1:end-5),'Conc.mat'),'Conc');
        %    save(strcat(workpath,'\','precessedData\',sublist{i}(1:end-5),'Corr_matrix.mat'),'Corr_matrix');
%         end
    end
    mkdir('networkMatrix');
    save(strcat(workpath,'\','networkMatrix\','networkMatrix.mat'),'networkMatrix.mat')
    close(h);
end