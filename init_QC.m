function init_QC(hObject,handles)
% hObject    handle to popupmenu1 (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

%
global GUI_DATA;
%import sublist from the current directory;
GUI_DATA;
fig_qc=guihandles(GUI_DATA.fig_qc);
sublist=GUI_DATA.plotstate.workpath;
nirsfile=dir(strcat(sublist,'\RawData\*.nirs'));
nirslist=cell(1,length(nirsfile));
for i=1:length(nirsfile)
    nirslist{i}=nirsfile(i).name;
end
set(fig_qc.raw_sublist,'String',nirslist);