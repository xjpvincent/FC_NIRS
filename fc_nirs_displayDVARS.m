function [outdata]=fc_nirs_displayDVARS(hObject, eventdata, handles);
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
stdEvthresh2=DISPLAY_STATE.stdEvthresh2;
%get the selected channels, lst;
diff_data=diff(display_data);
root_square=sqrt(mean([diff_data.*diff_data]'));
m_s=mean(root_square);
v_s=STD(root_square);
axes(handles.axesDisplayDVARS);
 h1=plot([display_t(2:end)],root_square');
 hold on;
 plot([display_t],[ones(length(display_t),1)].*(m_s+stdEvthresh2*v_s),'--r');
 hold off;
clc
