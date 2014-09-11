function   fc_NIRS_sdgToggleLines(hObject, eventdata, handles)
%This function is called when the user clicks on one of the meausrement
%lines in the SDG window
global DISPLAY_DATA;
global DISPLAY_STATE;
if isempty(DISPLAY_DATA) 
    return;
end

SD      = DISPLAY_DATA.SD;
%handles=guihandles(GUI_DATA.handles);
axesSDG =handles.axesSDG;

idx = eventdata;
try
mouseevent = get(get(get(hObject,'parent'),'parent'),'selectiontype');
catch
    mouseevent = get(get(get(get(hObject,'parent'),'parent'),'parent'),'selectiontype');
end
%change measListAct
h2=get(axesSDG,'children');  %The list of all the lines currently displayed

lst=find(SD.MeasList(:,1)==DISPLAY_STATE.plot(idx,1) &...
    SD.MeasList(:,2)==DISPLAY_STATE.plot(idx,2));

%%%% If mouse right click, make channel data invisible
% Switch the linestyles based on a combination 
% of prune channel and visibility status
if strcmp(mouseevent,'alt')
    if strcmp(get(h2(idx),'linestyle'), '-')
        set(h2(idx),'linestyle','--')
        SD.MeasListVis(lst)=0;
    elseif strcmp(get(h2(idx),'linestyle'), '--')
        set(h2(idx),'linestyle','-')
        SD.MeasListVis(lst)=1;
%     elseif strcmp(get(h2(idx),'linestyle'), ':')
%         set(h2(idx),'linestyle','-')
%         SD.MeasListVis(lst)=1;
%     elseif strcmp(get(h2(idx),'linestyle'), '-.')
%         set(h2(idx),'linestyle','--')
%         SD.MeasListVis(lst)=1;
    end
    
%%%% If mouse nromal left click, prune channel data 
elseif strcmp(mouseevent,'normal')
    if strcmp(get(h2(idx),'linestyle'), '-')
        set(h2(idx),'linestyle','--')
        SD.MeasListAct(lst)=0;
    elseif strcmp(get(h2(idx),'linestyle'), '--')
        set(h2(idx),'linestyle','-')
        SD.MeasListAct(lst)=1;
%     elseif strcmp(get(h2(idx),'linestyle'), ':')
%         set(h2(idx),'linestyle','-')
%         SD.MeasListAct(lst)=0;
%     elseif strcmp(get(h2(idx),'linestyle'), '-.')
%         set(h2(idx),'linestyle','--')
%         SD.MeasListAct(lst)=1;
    end
    
%%%% Exit function for any other mouse event 
else
    return;
end

% if(data_diff(hmr.SD,SD))
%     hmr.fileChanged = 1;
% end

DISPLAY_DATA.SD = SD;
if isfield(handles,'axesDisplayData')|...
        isfield(handles,'axesDisplayTailorData1')|...
        isfield(handles,'axesDisplayTailorData2')
    fc_NIRS_plotData(hObject, eventdata, handles);
end
if isfield(handles,'axesDisplayPSD')
    fc_NIRS_plotPSD(hObject,eventdata,handles);
end
