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
if get(handles.radiobutton20,'Value');
plot(opticalSNR(1:end/2),'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10);
end
if get(handles.radiobutton21,'Value')
plot(opticalSNR(end/2+1:end),'--rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10);
end
% m_opticalSNR=mean(opticalSNR(1:end/2));
% v_opticalSNR=std(opticalSNR(1:end/2));
% hold on;        
% plot([0:50],ones(1,51)*(m_opticalSNR+2*v_opticalSNR),'--b');
% axes(handles.axes_opticalSNR);
% global DISPLAY_DATA;
% if isempty(DISPLAY_DATA)
%     cla;
%     return;
% end
% sublist=get(handles.raw_sublist,'String');
% if strcmp(class(sublist),'char')
%     if strcmp(sublist,'None')
%     msgbox('You haven''t select the subject. Please select a subject you want to display.','Warning','error');
%     return 
%     end   
% end
% d=DISPLAY_DATA.rawdata.d;
% v_d=STD(d);
% m_d=mean(d);
% opticalSNR=m_d./v_d;
% cla
% plot(opticalSNR(end/2+1:end),'--rs','LineWidth',2,...
%                 'MarkerEdgeColor','k',...
%                 'MarkerFaceColor','g',...
%                 'MarkerSize',10);
% m_opticalSNR=mean(opticalSNR(47:end));
% v_opticalSNR=STD(opticalSNR(47:end));
%  hold on; 
%  grid on;
% plot([0:50],ones(1,51)*(m_opticalSNR+2*v_opticalSNR),'--b');    