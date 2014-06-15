function [outdata]=fc_nirs_displaySTD(hObject, eventdata, handles);
global DISPLAY_DATA;
global DISPLAY_STATE;

%%test set
DISLAY_STATE.ch=[1:3];
%%
displayAxes =handles.axesDisplaySTD;
if ~displayAxes
    return;
end
if isempty(DISPLAY_DATA)
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
if DISPLAY_STATE.plotType==0
    if isfield( DISPLAY_STATE, 'ch' )
       ch=DISPLAY_STATE.ch;
        window_length=DISPLAY_STATE.wl;
        stdThre=DISPLAY_STATE.stdEvthresh1;
        
        if ~isempty(ch)
            cla
            axes(displayAxes);
            xjp_plotSelectedChSTD(display_data,display_t,...
                ch,window_length,stdThre);
            
         %   xjp_plotSelectedChSTD(display_data,display_t,lst);
        else
            cla %this use to be clf but that crashed
        end
    end
end
if DISPLAY_STATE.plotType==1
    %display all channels' Data;
    col=size(display_data,2);   
    axes(displayAxes)
    xjp_plotTracesSTD(display_data,display_t);
end
clc

function h=xjp_plotSelectedChSTD(signal,t,ch,window_length,stdThre)
global DISPLAY_STATE;
hold on
for ii=length(ch):-1:1
    sig_std=movingstd(signal(:,ch(ii)),window_length/abs(t(1)-t(2)),'central');
    t1=t(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))));
    sig_std1=sig_std(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))));
   % figure
    h=plot(t1,sig_std1);
    axis auto
    m_std=mean(sig_std);
    s_std=STD(sig_std);
    h1=plot(t,(t>0)*(m_std+stdThre*s_std));
    set(h,'color',DISPLAY_STATE.color(mod(ch(ii),16)+1,:));
    set(h1,'color',DISPLAY_STATE.color(mod(ch(ii),16)+1,:));
    %  set(h,'linewidth',1);
end
grid on;
 line([t(1) t(1)],ylim ,'LineWidth',1,'Color',[.1 .1 .1],'LineStyle','--');
 line([t(end) t(end)],ylim,'LineWidth',1,'Color',[.1 .1 .1],'LineStyle','--');
ylabel('std of timeseries');
xlabel('time');
hold off

function h=xjp_plotTracesSTD(signal,t,window_length,stdThre,traceColors)
std_sig=zeros(size(signal));
for i=1:size(signal,2)
    std_sig(:,i)=movingstd(signal(:,i),window_length/abs(t(1)-t(2)),'central');
    m_std=mean(std_sig(:,i));
    s_std=STD(std_sig(:,i));
    std_sig(:,i)=std_sig(:,i)>(m_std+stdThre*s_std);
end
t1=t(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))));
std_sig1=std_sig(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))),:);
h=imagesc(t1,1:size(signal,2),std_sig1');

