function fc_nirs_displayFCMAP(hObject, eventdata, handles);
global DISPLAY_DATA;
if isempty(DISPLAY_DATA)
    cla;
    return;
end
try
start_time2=str2num(get(handles.start_time2,'String'));
end_time2=str2num(get(handles.end_time2,'String'));
catch
    display('please check the tRange you input');
end
tRange=DISPLAY_DATA.procConc.t;
tindex=find(tRange>=start_time2&tRange<=end_time2);
axes(handles.axes_CorrMatrix);
if get(handles.radio_hbo,'Value');
c=corr(DISPLAY_DATA.procConc.HbO(tindex,:));
imagesc(c);
end
if get(handles.radio_hbr,'Value');
c=corr(DISPLAY_DATA.procConc.HbR(tindex,:));
imagesc(c);
end
if get(handles.radio_hbt,'Value');
c=corr(DISPLAY_DATA.procConc.HbT(tindex,:));
imagesc(c);
% else
end
title('Signal Correlation','FontSize',14);
xlabel('channel');
ylabel('channel');
colorbar;
