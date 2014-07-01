function fc_NIRS_AxestailorSDG_buttondown(hObject, eventdata, handles)

global DISPLAY_DATA;
global DISPLAY_STATE;
%handles=guihandles(GUI_DATA.handles);
if isempty(DISPLAY_DATA.SD) 
    return;
end

pos = get(handles.axestailorSDG,'CurrentPoint');

h = hObject;
while ~strcmpi(get(h,'Type'),'figure')
    h = get(h,'parent');
end

mouseevent = get(h,'selectiontype');

SD = DISPLAY_DATA.SD;

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
    DISPLAY_STATE.plotLst_SrcMin = SrcMin;
    DISPLAY_STATE.plotLst_idxMin = idxMin;
    
    if SrcMin
       DISPLAY_STATE.plotLst = lst;
       DISPLAY_STATE.plot = [idxMin*ones(length(lst),1) SD.MeasList(lst,2)];
    else
        DISPLAY_STATE.plotLst = lst;
        DISPLAY_STATE.plot = [SD.MeasList(lst,1) idxMin*ones(length(lst),1)];
    end
elseif strcmp(mouseevent,'extend')
    if SrcMin
        DISPLAY_STATE.plotLst(end+[1:length(lst)]) = lst;
        DISPLAY_STATE.plot(end+[1:length(lst)],:) = [idxMin*ones(length(lst),1) SD.MeasList(lst,2)];
    else
        DISPLAY_STATE.plotLst(end+[1:length(lst)]) = lst;
        DISPLAY_STATE.plot(end+[1:length(lst)],:) = [SD.MeasList(lst,1) idxMin*ones(length(lst),1)];
    end
end
%plotSDG(hObject, eventdata, handles);
%displayData(hObject, eventdata, handles);
%   fc_NIRS_plotSDG(hObject, eventdata, handles);
%   if isfield(handles,'axesDisplayData')|...
%         isfield(handles,'axesDisplayTailorData1') |...
%           isfield(handles,'axesDisplayTailorData2') 
%       fc_NIRS_plotData(hObject, eventdata, handles);
%   end
%   if isfield(handles,'axesDisplayPSD')
%       fc_NIRS_plotPSD(hObject,eventdata,handles);
%   end
fc_NIRS_plottailorSDG(hObject, eventdata, handles);
fc_NIRS_plottailorData(hObject, eventdata, handles);

