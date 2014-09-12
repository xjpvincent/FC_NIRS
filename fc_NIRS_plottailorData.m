function [outdata]=fc_NIRS_plottailorData(hObject, eventdata, handles);
global DISPLAY_DATA;
global DISPLAY_STATE;
if isempty(DISPLAY_DATA)
    return;
end
if isfield(handles,'axesDisplayData')
    displayAxes =handles.axesDisplayData;
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

if get(handles.select_Ch,'Value')
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
        xjp_plotSelectedCh(display_data,display_t,plotLst,lst);
    else
        cla %this use to be clf but that crashed
    end
    catch        
    end
end
if get(handles.all_Ch,'Value')
    %display all channels' Data;
    cla
    col=size(display_data,2);    
    xjp_plotTraces(display_data,display_t);
end
clc
%%set startTime, preTime and postTime
if isfield(handles,'edit_startTime')&...
        isfield(handles,'edit_preTime')&...
        isfield(handles,'edit_postTime')

try
startTime=str2num(get(handles.edit_startTime,'String'));
preTime=str2num(get(handles.edit_preTime,'String'));
postTime=str2num(get(handles.edit_postTime,'String'));

axesDisplayTailorData1=handles.axesDisplayTailorData1;
axes(axesDisplayTailorData1);
scale=axis;
line([startTime startTime],[scale(3) scale(4)],...
    'LineStyle','--','Color',[1,0,0]);
line([startTime-preTime startTime-preTime],[scale(3) scale(4)],...
    'LineStyle','--','Color',[0,0,1]);
line([startTime+postTime startTime+postTime],[scale(3) scale(4)],...
    'LineStyle','--','Color',[0,0,1]);
catch
    if isfield(handles,'axesDisplayTailorData2')
    axes(handles.axesDisplayTailorData2)
    cla
    end
    return
end
end

%plot axesDisplayTailorData2
 if isfield( DISPLAY_STATE, 'plotLst' )
if isfield(handles,'axesDisplayTailorData2')
    axes(handles.axesDisplayTailorData2)
    cla
    tindex=find((display_t<(startTime+postTime))...
        &(display_t>(startTime-preTime)));
    xjp_plotSelectedCh(display_data(tindex,:),...
        display_t(tindex),plotLst,lst);
end
 end



function h=xjp_plotSelectedCh(signal,t,plotLst,lst)
global DISPLAY_STATE;
hold on
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








