function [outdata]=fc_nirs_displaySTD(hObject, eventdata, handles);
global DISPLAY_DATA;
global DISPLAY_STATE;
window_length=DISPLAY_STATE.wl;
stdThre=DISPLAY_STATE.stdEvthresh1;
try 
start_time1=str2num(get(handles.start_time1,'String'));
end_time1=str2num(get(handles.end_time1,'String'));
catch
    display('check out the tRange you input.\n');
    return;
end
if isempty(DISPLAY_DATA)
    return;
end
if isfield(handles,'axesDisplaySTD')
    displayAxes =handles.axesDisplaySTD;
elseif isfield(handles,'axesDisplayTailorData1')&...
        isfield(handles,'axesDisplayTailorData2') 
    displayAxes=handles.axesDisplayTailorData1;
   
end
%get the handles of fig_processing
%fig_processing=guihandles(GUI_DATA.fig_processing);

if ~displayAxes
    return;
end
sclConc = 1e6; % convert Conc from Molar to uMolar
axes(displayAxes)
%add by xjp;14/6/1
%display corresponding  signal type;
%DISPLAY.signal_type2
signal_type1=DISPLAY_STATE.signal_type1;
signal_type2=DISPLAY_STATE.signal_type2;
display_data=[];
display_t=[];
switch signal_type1
    case 1
        %raw od
        display_data=DISPLAY_DATA.RawData.d;
        display_data=display_data(:,1+(signal_type2-1)*...
            size(DISPLAY_DATA.RawData.d,2)/2:size(DISPLAY_DATA.RawData.d,2)/2+...
            (signal_type2-1)*size(DISPLAY_DATA.RawData.d,2)/2);
        display_t=DISPLAY_DATA.RawData.t;
    case 2;
        %normalization od
        display_data=DISPLAY_DATA.OD.dod;
        display_data=display_data(:,1+(signal_type2-1)*...
            size(DISPLAY_DATA.OD.dod,2)/2:size(DISPLAY_DATA.OD.dod,2)/2+...
            (signal_type2-1)*size(DISPLAY_DATA.OD.dod,2)/2);
        display_t=DISPLAY_DATA.OD.t;
    case 3
        %unprocessed Conc;
        switch signal_type2
            %HbO
            case 1
                display_data=DISPLAY_DATA.rawConc.HbO;
                display_t=DISPLAY_DATA.rawConc.t;
                %HbR
            case 2
                display_data=DISPLAY_DATA.rawConc.HbR;
                display_t=DISPLAY_DATA.rawConc.t;
                %HbT
                
            case 3
                display_data=DISPLAY_DATA.rawConc.HbT;
                display_t=DISPLAY_DATA.rawConc.t;
        end
    case 4
        %processed Conc
        switch signal_type2
            %HbO
            case 1
                display_data=DISPLAY_DATA.Conc.HbO;
                display_t=DISPLAY_DATA.Conc.t;
                %HbR
            case 2
                display_data=DISPLAY_DATA.Conc.HbR;
                display_t=DISPLAY_DATA.Conc.t;
                %HbT
            case 3
                display_data=DISPLAY_DATA.Conc.HbT;
                display_t=DISPLAY_DATA.Conc.t;
        end
end
%get the selected channels, lst;

if ~isfield(DISPLAY_DATA.SD,'MeasListAct')
    DISPLAY_DATA.SD.MeasListAct=ones(size(DISPLAY_DATA.SD.MeasList,1));
end

if DISPLAY_STATE.plotType==0
    if isfield( DISPLAY_STATE, 'plotLst' )
        lst = DISPLAY_STATE.plotLst;
        lst2 = [];
        lst3 = find(DISPLAY_DATA.SD.MeasList(:,4)==1);
        for ii=1:length(lst);
            lst2(ii) = find(DISPLAY_DATA.SD.MeasList(lst3,1)==DISPLAY_DATA.SD.MeasList(lst(ii),1) & ...
                DISPLAY_DATA.SD.MeasList(lst3,2)==DISPLAY_DATA.SD.MeasList(lst(ii),2) );
        end
        plotLst = lst2;
        lst = find(DISPLAY_DATA.SD.MeasListAct(plotLst)==1);
    end
    %detect error
    try
    if ~isempty(lst)
        cla              
        %xjp_plotSelectedCh(display_data,display_t,plotLst,lst);
        tindex=find(display_t>=start_time1&display_t<=end_time1);
        xjp_plotSelectedChSTD(display_data(tindex,:),display_t(tindex),plotLst,...
            lst,window_length,stdThre);
         %this use to be clf but that crashed
    end
    catch        
    end
end
if DISPLAY_STATE.plotType==1
    %display all channels' Data;
    cla 
     tindex=find(display_t>=start_time1&display_t<=end_time1);
    xjp_plotTracesSTD(display_data(tindex,:),display_t(tindex),...
    window_length,stdThre);
end





function h=xjp_plotSelectedCh(signal,t,plotLst,lst)
global DISPLAY_STATE;
hold on
axis auto
for ii=length(lst):-1:1
    h=plot(t,...
        signal( :, plotLst(lst(ii))));
    set(h,'color',DISPLAY_STATE.color(lst(ii),:));
  %  set(h,'linewidth',1);
end
grid on;
hold off
function h=xjp_plotTraces(signal,   time,traceColors)
channel = 1:size(signal,2);
kk=1;
for ch=1:size(signal,2);
    % signal(:,ch) = signal(:,ch)+max(max(signal(:,ch-1)))-min(min(signal(:,ch)));%+max(max(signal(:,ch)));
    signal(:,ch)=premnmx(signal(:,ch))+kk;
    kk=kk+1;
end
if(exist('traceColors'))
    for ii=1:length(channel)
        h=plot(time, signal(:,channel(ii)),'color',traceColors(ii,:));
        hold on;
    end
else
    h= plot(time,signal(:,channel));
end



function h=xjp_plotSelectedChSTD(signal,t,plotLst,lst,window_length,stdThre)
global DISPLAY_STATE;

for ii=length(lst):-1:1
    sig_std=movingstd(signal(:,plotLst(lst(ii))),round(window_length/abs(t(1)-t(2))),'central');
    t1=t(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))));
    sig_std1=sig_std(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))));
   % figure
    h=plot(t1,sig_std1);
    hold on;
    axis auto
    m_std=mean(sig_std);
    s_std=std(sig_std);
    
    h1=plot(t,(t>0)*(m_std+stdThre*s_std));
    set(h,'color',DISPLAY_STATE.color(lst(ii),:));
    set(h1,'color',DISPLAY_STATE.color(lst(ii),:));
    %  set(h,'linewidth',1);
    hold on
end
grid on;
 line([t(1) t(1)],ylim ,'LineWidth',1,'Color',[.1 .1 .1],'LineStyle','--');
 line([t(end) t(end)],ylim,'LineWidth',1,'Color',[.1 .1 .1],'LineStyle','--');
ylabel('std of timeseries');
xlabel('time');
hold off

function h=xjp_plotTracesSTD(signal,t,window_length,stdThre,traceColors)
cla
std_sig=zeros(size(signal));
for i=1:size(signal,2)
    std_sig(:,i)=movingstd(signal(:,i),round(window_length/abs(t(1)-t(2))),'central');
    m_std=mean(std_sig(:,i));
    s_std=std(std_sig(:,i));
    std_sig(:,i)=std_sig(:,i)>(m_std+stdThre*s_std);
end
t1=t(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))));
std_sig1=std_sig(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))),:);
h=imagesc(t1,1:size(signal,2),std_sig1');

