function [out_arg]=fc_NIRS_plotPSD(hObject, eventdata, handles)
%add by xjp;14/6/1
%display corresponding  signal type;
%DISPLAY.signal_type2global DISPLAY_DATA;
global DISPLAY_DATA;
global DISPLAY_STATE;
if isfield(handles,'axesDisplayPSD');
    axes(handles.axesDisplayPSD);
else 
    figure('color',[1 1 1]);
end
if isempty(DISPLAY_DATA)
    return;
end

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
        xjp_plotPSDSelectedCh(display_data,display_t,plotLst,lst);
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

function h=xjp_plotPSDSelectedCh(signal,t,plotLst,lst)
global DISPLAY_STATE;
hold on
Fs=1/abs(t(1)-t(2));
for ii=length(lst):-1:1
    x=signal( :, plotLst(lst(ii)));
    [psdestx,Fxx] = periodogram(x,rectwin(length(x)),length(x),Fs);
   % h=plot(Fxx,10*log10(psdestx)); grid on;
    h=plot(Fxx,psdestx); grid on;
    set(gca,'yscale','log')
    xlabel('Hz');% ylabel('Power/Frequency (dB/Hz)');
    title('Periodogram Power Spectral Density Estimate');
%     max(psdx'-psdestx)
    set(h,'color',DISPLAY_STATE.color(lst(ii),:));
    set(h,'linewidth',1);
end
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

