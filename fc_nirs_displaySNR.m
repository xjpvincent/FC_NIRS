function fc_nirs_displaySNR(hObject, eventdata, handles);

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
tRange=DISPLAY_DATA.rawdata.t;
tindex=find(tRange>=start_time2&tRange<=end_time2);
d=DISPLAY_DATA.rawdata.d(tindex,:);

v_d=std(d);
m_d=mean(d);
opticalSNR=m_d./v_d;
axes(handles.axes_opticalSNR);
cla
% if get(handles.radiobutton20,'Value');
% plot(log(opticalSNR(1:end/2).*opticalSNR(end/2+1:end)),'--rs','LineWidth',2,...
%                 'MarkerEdgeColor','k',...
%                 'MarkerFaceColor','g',...
%                 'MarkerSize',7);
% end
% if get(handles.radiobutton21,'Value')
plot(log(opticalSNR(1:end/2).*opticalSNR(end/2+1:end)),'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',7);
% end
xlabel('channel');
ylabel('SNR');
title('Signal to Noise rate','FontSize',14);
