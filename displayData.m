function [outdata]=displayData(hObject, eventdata, handles);
global GUI_DATA;
if isempty(GUI_DATA.currentData)
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
plotstate=GUI_DATA.plotstate;
currentData=GUI_DATA.currentData;
plotType=plotstate.plotType;

%%plot t
% DISPLAY DATA
   conc=GUI_DATA.plotstate.Conc;
   %conc=1;
   plotOD=GUI_DATA.plotstate.plotOD;
if plotType==1


if isfield( plotstate, 'plotLst' )
    % transform list for concentration data
    lst = plotstate.plotLst;
    %     if ndims(hmr.y)==3
    %modify
    %%display OD signal
    if (plotOD>0&&conc==0) 
    if ndims(GUI_DATA.currentData.d)==2
        d=GUI_DATA.currentData.d;
        d=reshape(d,size(d,1),size(d,2)/2,2);
        lst2 = [];
        lst3 = find(GUI_DATA.currentData.SD.MeasList(:,4)==1);
        for ii=1:length(lst);
            lst2(ii) = find(GUI_DATA.currentData.SD.MeasList(lst3,1)==GUI_DATA.currentData.SD.MeasList(lst(ii),1) & ...
                GUI_DATA.currentData.SD.MeasList(lst3,2)==GUI_DATA.currentData.SD.MeasList(lst(ii),2) );
        end
        plotLst = lst2;
    else
        plotLst = lst;
    end
    lst = find(GUI_DATA.currentData.SD.MeasListAct(plotLst)==1);
    if ~isempty(lst)
        cla
        hold on
        for ii=length(lst):-1:1
            h=plot(GUI_DATA.currentData.t,...
                squeeze(d( :, plotLst(lst(ii)), plotOD)));
            set(h,'color',GUI_DATA.plotstate.color(lst(ii),:));
            set(h,'linewidth',2);
        end
        hold off
        
    else
   
        cla %this use to be clf but that crashed
    end
    end
   %% display HbO signal
   %conc=1
  
 if conc>0
    if ndims(GUI_DATA.currentData.dc)==3
        lst2 = [];
        lst3 = find(GUI_DATA.currentData.SD.MeasList(:,4)==1);
        for ii=1:length(lst);
            lst2(ii) = find(GUI_DATA.currentData.SD.MeasList(lst3,1)==GUI_DATA.currentData.SD.MeasList(lst(ii),1) & ...
                GUI_DATA.currentData.SD.MeasList(lst3,2)==GUI_DATA.currentData.SD.MeasList(lst(ii),2) );
        end
        plotLst = lst2;
    else
        plotLst = lst;
    end
    lst = find(GUI_DATA.currentData.SD.MeasListAct(plotLst)==1);
    if ~isempty(lst)
        cla
        hold on
        for ii=length(lst):-1:1
            hbo=squeeze(GUI_DATA.currentData.dc(:,conc,:));
            h=plot(GUI_DATA.currentData.t,...
                hbo( :, plotLst(lst(ii))) );
            set(h,'color',GUI_DATA.plotstate.color(lst(ii),:));
            set(h,'linewidth',2);
        end
        hold off
        
    else
        cla %this use to be clf but that crashed
    end
 end
end

end
if plotType==2
     if (plotOD>0&&conc==0) 
          d=GUI_DATA.currentData.d;
        d=reshape(d,size(d,1),size(d,2)/2,2);
         h=xjp_plotTraces(squeeze(d( :, :, plotOD)),...
             GUI_DATA.currentData.t);
         
     end
     if(conc>0)
         conc_sig=squeeze(GUI_DATA.currentData.dc(:,conc,:));
         h=xjp_plotTraces(conc_sig,   GUI_DATA.currentData.t);
     end
end
%xlim( cw6info.time([firstR cw6info.nRecords]) )
set(gca,'ygrid','on')
%
tRange=GUI_DATA.plotstate.tRange;
if ~isempty(tRange)
 ylim=get(handles.axesDisplayData,'ylim');
 line([tRange(1) tRange(1)],ylim ,'LineWidth',1,'Color',[.1 .1 .1],'LineStyle','--');
 line([tRange(2) tRange(2)],ylim,'LineWidth',1,'Color',[.1 .1 .1],'LineStyle','--');
end
GUI_DATA.plotstate.tRange=[];

%%plot all channel signal;


 % %      
function h=xjp_plotTraces(signal,   time)
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




