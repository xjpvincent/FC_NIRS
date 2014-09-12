function   qc_rest_NIRS_sdgToggleLines(hObject, eventdata, handles)
%This function is called when the user clicks on one of the meausrement
%lines in the SDG window
global GUI_DATA;
if isempty(GUI_DATA.RawData.SD) 
    x=0
    return;
end

SD      = GUI_DATA.RawData.SD;
axesSDG =handles.axesSDG;

idx = eventdata;

mouseevent = get(get(get(hObject,'parent'),'parent'),'selectiontype');

%change measListAct
h2=get(axesSDG,'children');  %The list of all the lines currently displayed

lst=find(SD.MeasList(:,1)==GUI_DATA.plotstate.plot(idx,1) &...
    SD.MeasList(:,2)==GUI_DATA.plotstate.plot(idx,2));

%%%% If mouse right click, make channel data invisible
% Switch the linestyles based on a combination 
% of prune channel and visibility status
if strcmp(mouseevent,'alt')
    if strcmp(get(h2(idx),'linestyle'), '-')
        set(h2(idx),'linestyle',':')
        SD.MeasListVis(lst)=0;
    elseif strcmp(get(h2(idx),'linestyle'), '--')
        set(h2(idx),'linestyle','-.')
        SD.MeasListVis(lst)=0;
    elseif strcmp(get(h2(idx),'linestyle'), ':')
        set(h2(idx),'linestyle','-')
        SD.MeasListVis(lst)=1;
    elseif strcmp(get(h2(idx),'linestyle'), '-.')
        set(h2(idx),'linestyle','--')
        SD.MeasListVis(lst)=1;
    end
    
%%%% If mouse nromal left click, prune channel data 
elseif strcmp(mouseevent,'normal')
    if strcmp(get(h2(idx),'linestyle'), '-')
        set(h2(idx),'linestyle','--')
        SD.MeasListAct(lst)=0;
    elseif strcmp(get(h2(idx),'linestyle'), '--')
        set(h2(idx),'linestyle','-.')
        SD.MeasListAct(lst)=1;
    elseif strcmp(get(h2(idx),'linestyle'), ':')
        set(h2(idx),'linestyle','-')
        SD.MeasListAct(lst)=0;
    elseif strcmp(get(h2(idx),'linestyle'), '-.')
        set(h2(idx),'linestyle','--')
        SD.MeasListAct(lst)=1;
    end
    
%%%% Exit function for any other mouse event 
else
    return;
end

% if(data_diff(hmr.SD,SD))
%     hmr.fileChanged = 1;
% end

GUI_DATA.currentData.SD = SD;

% if hmr.fileChanged == 1;
%     set(handles.pushbuttonSave,'visible','on');    
% end


%Update the displays

qc_plotSDG(hObject, eventdata, handles);
qc_displayData(hObject, eventdata, handles);

