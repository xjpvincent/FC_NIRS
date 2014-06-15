function [outdata]=displayDVARS(hObject, eventdata, handles);
global GUI_DATA;
if isempty(GUI_DATA.currentData)
    return;
end
window_length=100;
windowlength=10;
%get the handles of fig_processing
%fig_processing=guihandles(GUI_DATA.fig_processing);
displayAxes =handles.axesDisplayDVARS;
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
                    std=movingstd(squeeze(d( :, plotLst(lst(ii)), plotOD)),window_length,'central');%squeeze(d( :, plotLst(lst(ii)), plotOD));
                    h=plot(GUI_DATA.currentData.t,...
                        std);
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
                    cla;
                    hbo=squeeze(GUI_DATA.currentData.dc(:,conc,:));
                    %             h=plot(GUI_DATA.currentData.t,...
                    hbo=diff(hbo);
                    root_square=sqrt(mean([hbo.*hbo]'));
                    m_s=mean(root_square);
                    v_s=VAR(root_square);
                    h1=plot([GUI_DATA.currentData.t(2:end)],root_square');
                    hold on;
                    plot([GUI_DATA.currentData.t],[ones(length(GUI_DATA.currentData.t),1)].*(m_s+2*v_s),'--r');
        end
    end
    
title('DVARS');

