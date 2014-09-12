function fc_NIRS_plottailorSDG(hObject, eventdata, handles)
%==========================================================================
% This function is used to plot Sourser and Decter position 
%
% NOTE:
%       When call this function must have global variable DISPLAY_DATA;
%
% Syntax: fc_NIRS_plotSDG(hObject, eventdata, handles)
%
% Jingping, NKLCNL, BNU, BeiJing, 2014/5/3, xjpvincent@gmail.com
%==========================================================================
global DISPLAY_DATA;
global DISPLAY_STATE;
%clear gca;
if isempty(DISPLAY_DATA)
    axes(handles.axestailorSDG)
    cla;
    return;
end

SD=DISPLAY_DATA.SD;
line_color=[0 0 1; 
             0 1 0;
             1 0 0;
             1 .5 0;
             1 0 1;
             0 1 1;
             0.5 0.5 1;
             0.5 1 0.5;
             1 0.5 0.5;
             1 0.5 1;
             0.5 1 1;
             0 0 0;
             0.2 0.2 0.2;
             0.4 0.4 0.4;
             0.6 0.6 0.6;
             0.8 0.8 0.8];

%handles=guihandles(GUI_DATA.handles);
axesSDG=handles.axestailorSDG;

xymin=min([SD.SrcPos ;SD.DetPos]);
xymax=max([SD.SrcPos ; SD.DetPos]);
axis(axesSDG, [xymin(1) xymax(1) xymin(2) xymax(2)]);





axis(axesSDG, 'image')
set(axesSDG,'xticklabel','')
set(axesSDG,'yticklabel','')
set(axesSDG,'ygrid','off')
axes(axesSDG);
lst=find(SD.MeasList(:,1)>0);
ml=SD.MeasList(lst,:);
lstML = find(ml(:,4)==1); 
lst2 = find(SD.MeasListAct(lstML)==0);
for ii=1:length(lst2)
    h = line( [SD.SrcPos(ml(lstML(lst2(ii)),1),1) SD.DetPos(ml(lstML(lst2(ii)),2),1)], ...
        [SD.SrcPos(ml(lstML(lst2(ii)),1),2) SD.DetPos(ml(lstML(lst2(ii)),2),2)] );
    set(h,'color',[1 1 1]*.85);
    set(h,'linewidth',4);
    set(h,'ButtonDownFcn',get(axesSDG,'ButtonDownFcn'));
end

lst2 = find(SD.MeasListAct(lstML)==1);
for ii=1:length(lst2)
    h = line( [SD.SrcPos(ml(lstML(lst2(ii)),1),1) SD.DetPos(ml(lstML(lst2(ii)),2),1)], ...
        [SD.SrcPos(ml(lstML(lst2(ii)),1),2) SD.DetPos(ml(lstML(lst2(ii)),2),2)] );
    set(h,'color',[1 1 1]*.85);
    set(h,'linewidth',4);
    set(h,'ButtonDownFcn',get(axesSDG,'ButtonDownFcn'));
end

% ADD SOURCE AND DETECTOR LABELS
for idx=1:SD.nSrcs
    if ~isempty(find(SD.MeasList(:,1)==idx))
        h = text( SD.SrcPos(idx,1), SD.SrcPos(idx,2), sprintf('%c', 64+idx), 'fontweight','bold' );
        set(h,'ButtonDownFcn',get(axesSDG,'ButtonDownFcn'));
    end
end
for idx=1:SD.nDets
    if ~isempty(find(SD.MeasList(:,2)==idx))
        h = text( SD.DetPos(idx,1), SD.DetPos(idx,2), sprintf('%d', idx), 'fontweight','bold' );
        set(h,'ButtonDownFcn',get(axesSDG,'ButtonDownFcn'));
    end
end

%plot param;
% DRAW PLOT LINES
% THESE LINES HAVE TO BE THE LAST
% ITEMS ADDED TO THE AXES
% FOR CHANNEL TOGGLING TO WORK WITH
% plotstate=DISPLAY_DATA.plotstate;
DISPLAY_STATE=DISPLAY_STATE;
if isfield( DISPLAY_STATE, 'plot' )
    if ~isempty(DISPLAY_STATE.plot)
        if DISPLAY_STATE.plot(1,1)~=0
            DISPLAY_STATE.color(end:size(DISPLAY_STATE.plot,1),:)=0;
            for idx=size(DISPLAY_STATE.plot,1):-1:1
                h = line( [SD.SrcPos(DISPLAY_STATE.plot(idx,1),1) SD.DetPos(DISPLAY_STATE.plot(idx,2),1)], ...
                    [SD.SrcPos(DISPLAY_STATE.plot(idx,1),2) SD.DetPos(DISPLAY_STATE.plot(idx,2),2)] );
                set(h,'color',DISPLAY_STATE.color(idx,:));
                set(h,'ButtonDownFcn',sprintf('fc_NIRS_tailorsdgToggleLines(gcbo,[%d],guidata(gcbo))',idx));
                set(h,'linewidth',2);
                
                if ~isfield(SD,'MeasListVis')
                    SD.MeasListVis=SD.MeasListAct;
                end
                
                if isfield(DISPLAY_STATE,'plotLst') && ...
                   (~SD.MeasListAct(DISPLAY_STATE.plotLst(idx)) & ~SD.MeasListVis(DISPLAY_STATE.plotLst(idx)))
                    set(h,'linewidth',2);
                    set(h,'linestyle','-.');
                else               
                    if isfield(DISPLAY_STATE,'plotLst') && ~SD.MeasListAct(DISPLAY_STATE.plotLst(idx))
                        set(h,'linewidth',2);
                        set(h,'linestyle','--');
                    end
                    if isfield(DISPLAY_STATE,'plotLst') && ~SD.MeasListVis(DISPLAY_STATE.plotLst(idx))
                        set(h,'linewidth',1);
                        set(h,'linestyle',':');
                    end
                end
            end
        end
    end
end
%set(gca,'color',[1 1 1]);
%set(gca,'color','none')
% axis off
% set(gca,'color',[1 1 1])
