function [outdata]=fc_NIRS_plotData(hObject, eventdata, handles);
global DISPLAY_DATA;
global DISPLAY_STATE;
if isempty(DISPLAY_DATA)
    return;
end
%get the handles of fig_processing
%fig_processing=guihandles(GUI_DATA.fig_processing);
displayAxes =handles.axesDisplayData;
if ~displayAxes
    return;
end
sclConc = 1e6; % convert Conc from Molar to uMolar
axes(displayAxes)
DISPLAY_STATE=DISPLAY_STATE;

%

%add by xjp;14/6/1
%display corresponding  signal type;
%DISPLAY.signal_type2
signal_type1=DISPLAY_STATE.signal_type1;
signal_type2=DISPLAY_STATE.signal_type2;
%
display_data=[];
display_t=[];
switch signal_type1
    case 1
        %raw od
        display_data=DISPLAY_DATA.rawdata.d;
        display_data=display_data(:,1+(signal_type2-1)*...
            size(DISPLAY_DATA.rawdata.d,2)/2:size(DISPLAY_DATA.rawdata.d,2)/2+...
            (signal_type2-1)*size(DISPLAY_DATA.rawdata.d,2)/2);
        display_t=DISPLAY_DATA.rawdata.t;
        
    case 2;
        %normalization od
        display_data=DISPLAY_DATA.procOD.dod;
        display_data=display_data(:,1+(signal_type2-1)*...
            size(DISPLAY_DATA.procOD.dod,2)/2:size(DISPLAY_DATA.procOD.dod,2)/2+...
            (signal_type2-1)*size(DISPLAY_DATA.procOD.dod,2)/2);
        display_t=DISPLAY_DATA.procOD.t;
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
                display_data=DISPLAY_DATA.procConc.HbO;
                display_t=DISPLAY_DATA.procConc.t;
                %HbR
            case 2
                display_data=DISPLAY_DATA.procConc.HbR;
                display_t=DISPLAY_DATA.procConc.t;
                %HbT
            case 3
                display_data=DISPLAY_DATA.procConc.HbT;
                display_t=DISPLAY_DATA.procConc.t;
        end
end
%get the selected channels, lst;
%
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
        
        
        
        xjp_plotSelectedCh(display_data,display_t,plotLst,lst);
    else
        cla %this use to be clf but that crashed
    end
    catch
        
    end
end
if DISPLAY_STATE.plotType==1
    %display all channels' Data;
    col=size(display_data,2);
    
    xjp_plotTraces(display_data,display_t);
end

clc

%% display HbO signal
%conc=1
%
%  if conc>0
%     if ndims(GUI_DATA.currentData.dc)==3
%         lst2 = [];
%         lst3 = find(GUI_DATA.currentData.SD.MeasList(:,4)==1);
%         for ii=1:length(lst);
%             lst2(ii) = find(GUI_DATA.currentData.SD.MeasList(lst3,1)==GUI_DATA.currentData.SD.MeasList(lst(ii),1) & ...
%                 GUI_DATA.currentData.SD.MeasList(lst3,2)==GUI_DATA.currentData.SD.MeasList(lst(ii),2) );
%         end
%         plotLst = lst2;
%     else
%         plotLst = lst;
%     end
%     lst = find(GUI_DATA.currentData.SD.MeasListAct(plotLst)==1);
%     if ~isempty(lst)
%         cla
%         hold on
%         for ii=length(lst):-1:1
%             hbo=squeeze(GUI_DATA.currentData.dc(:,conc,:));
%             h=plot(GUI_DATA.currentData.t,...
%                 hbo( :, plotLst(lst(ii))) );
%             set(h,'color',GUI_DATA.DISPLAY_STATE.color(lst(ii),:));
%             set(h,'linewidth',2);
%         end
%         hold off
%
%     else
%         cla %this use to be clf but that crashed
%     end
%  end
% end
%
% end
% if plotType==2
%      if (plotOD>0&&conc==0)
%           d=GUI_DATA.currentData.d;
%         d=reshape(d,size(d,1),size(d,2)/2,2);
%          h=xjp_plotTraces(squeeze(d( :, :, plotOD)),...
%              GUI_DATA.currentData.t);
%
%      end
%      if(conc>0)
%          conc_sig=squeeze(GUI_DATA.currentData.dc(:,conc,:));
%          h=xjp_plotTraces(conc_sig,   GUI_DATA.currentData.t);
%      end
% end
% %xlim( cw6info.time([firstR cw6info.nRecords]) )
% set(gca,'ygrid','on')
% %
% tRange=GUI_DATA.DISPLAY_STATE.tRange;
% if ~isempty(tRange)
%  ylim=get(handles.axesDisplayData,'ylim');
%  line([tRange(1) tRange(1)],ylim ,'LineWidth',1,'Color',[.1 .1 .1],'LineStyle','--');
%  line([tRange(2) tRange(2)],ylim,'LineWidth',1,'Color',[.1 .1 .1],'LineStyle','--');
% end
% GUI_DATA.DISPLAY_STATE.tRange=[];
%
% %%plot all channel signal;
%

%
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




