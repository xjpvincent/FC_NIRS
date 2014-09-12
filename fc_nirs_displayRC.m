function [outdata]=fc_nirs_displayRC(hObject, eventdata, handles);
global DISPLAY_DATA;
global DISPLAY_STATE;


DISLAY_STATE.ch=[1:3];
if ~isfield(handles,'axesDisplayRC')
    return;
end
displayAxes =handles.axesDisplayRC;
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
HbO=DISPLAY_DATA.Conc.HbO;
HbR=DISPLAY_DATA.Conc.HbR;
display_t=DISPLAY_DATA.Conc.t;
wl=DISPLAY_STATE.wl2;
