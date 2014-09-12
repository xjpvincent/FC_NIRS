function qc_restNIRS_AxesSDG_buttondown(hObject, eventdata, handles)

global GUI_DATA;
%fig_processing=guihandles(GUI_DATA.fig_processing);
if isempty(GUI_DATA.RawData.SD) 
    return;
end

pos = get(handles.axesSDG,'CurrentPoint');

h = hObject;
while ~strcmpi(get(h,'Type'),'figure')
    h = get(h,'parent');
end

mouseevent = get(h,'selectiontype');

SD = GUI_DATA.RawData.SD;

%find the closest optode
rmin = ( (pos(1,1)-SD.SrcPos(1,1))^2 + (pos(1,2)-SD.SrcPos(1,2))^2 )^0.5 ;
idxMin = 1;
SrcMin = 1;
for idx=1:SD.nSrcs
    ropt = ( (pos(1,1)-SD.SrcPos(idx,1))^2 + (pos(1,2)-SD.SrcPos(idx,2))^2 )^0.5 ;
    if ropt<rmin
        idxMin = idx;
        rmin = ropt;
    end
end
for idx=1:SD.nDets
    ropt = ( (pos(1,1)-SD.DetPos(idx,1))^2 + (pos(1,2)-SD.DetPos(idx,2))^2 )^0.5 ;
    if ropt<rmin
        idxMin = idx;
        SrcMin = 0;
        rmin = ropt;
    end
end

% copied from cw6_plotLst
idxLambda = 1;  %GUI_DATA.plotstate.displayLambda;
if SrcMin
    lst = find( SD.MeasList(:,1)==idxMin & SD.MeasList(:,4)==idxLambda );
else
    lst = find( SD.MeasList(:,2)==idxMin & SD.MeasList(:,4)==idxLambda );
end


if strcmp(mouseevent,'normal')
    % modify the global variables
    GUI_DATA.plotstate.plotLst_SrcMin = SrcMin;
    GUI_DATA.plotstate.plotLst_idxMin = idxMin;
    
    if SrcMin
        GUI_DATA.plotstate.plotLst = lst;
        GUI_DATA.plotstate.plot = [idxMin*ones(length(lst),1) SD.MeasList(lst,2)];
    else
        GUI_DATA.plotstate.plotLst = lst;
        GUI_DATA.plotstate.plot = [SD.MeasList(lst,1) idxMin*ones(length(lst),1)];
    end
elseif strcmp(mouseevent,'extend')
    if SrcMin
        GUI_DATA.plotstate.plotLst(end+[1:length(lst)]) = lst;
        GUI_DATA.plotstate.plot(end+[1:length(lst)],:) = [idxMin*ones(length(lst),1) SD.MeasList(lst,2)];
    else
        GUI_DATA.plotstate.plotLst(end+[1:length(lst)]) = lst;
        GUI_DATA.plotstate.plot(end+[1:length(lst)],:) = [SD.MeasList(lst,1) idxMin*ones(length(lst),1)];
    end
end

%plot SDG and the selected Data;
plotSDG(hObject, eventdata, handles)
displayData(hObject, eventdata, handles);

