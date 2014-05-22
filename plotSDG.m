function plotSDG(hObject, eventdata, handles)
%==========================================================================
% This function is used to 
%
%
% NOTE, 
%
%
% Syntax: function gretna_batch_preprocessing(Data_path, File_filter, Order)
%
% Inputs:
%     
% Outputs:
%
% Jingping, NKLCNL, BNU, BeiJing, 2014/5/3, xjpvincent@gmail.com
%==========================================================================
global GUI_DATA;
%clear gca;
if isempty(GUI_DATA.currentData)
    return;
end

SD=GUI_DATA.currentData.SD;
%handles=guihandles(GUI_DATA.handles);
axesSDG=handles.axesSDG;
axis(axesSDG, [SD.xmin SD.xmax SD.ymin SD.ymax]);
axis(axesSDG, 'image')
set(axesSDG,'xticklabel','')
set(axesSDG,'yticklabel','')
set(axesSDG,'ygrid','off')
axes(axesSDG);
lst=find(SD.MeasList(:,1)>0);
ml=SD.MeasList(lst,:);
lstML = find(ml(:,4)==1); %cw6info.displayLambda);

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
% 
% if isfield(procResult,'SD')
%     if isfield(procResult.SD,'MeasListActAuto')
%         lst2 = find(procResult.SD.MeasListActAuto(lstML)==0);
%         for ii=1:length(lst2)
%             h = line( [SD.SrcPos(ml(lstML(lst2(ii)),1),1) SD.DetPos(ml(lstML(lst2(ii)),2),1)], ...
%                 [SD.SrcPos(ml(lstML(lst2(ii)),1),2) SD.DetPos(ml(lstML(lst2(ii)),2),2)] );
%             set(h,'color',[1 1 .85]*1);
%             set(h,'linewidth',6);
%             set(h,'ButtonDownFcn',get(axesSDG,'ButtonDownFcn'));
%         end
%     end
% end
% 
% 

% 
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
% cw6_sdgToggleLines()
plotstate=GUI_DATA.plotstate;
if isfield( plotstate, 'plot' )
    if ~isempty(plotstate.plot)
        if plotstate.plot(1,1)~=0
            plotstate.color(end:size(plotstate.plot,1),:)=0;
            for idx=size(plotstate.plot,1):-1:1
                h = line( [SD.SrcPos(plotstate.plot(idx,1),1) SD.DetPos(plotstate.plot(idx,2),1)], ...
                    [SD.SrcPos(plotstate.plot(idx,1),2) SD.DetPos(plotstate.plot(idx,2),2)] );
                set(h,'color',plotstate.color(idx,:));
                set(h,'ButtonDownFcn',sprintf('rest_NIRS_sdgToggleLines(gcbo,[%d],guidata(gcbo))',idx));
                set(h,'linewidth',2);
                if isfield(plotstate,'plotLst') && ...
                   (~SD.MeasListAct(plotstate.plotLst(idx)) & ~SD.MeasListVis(plotstate.plotLst(idx)))
                    set(h,'linewidth',2);
                    set(h,'linestyle','-.');
                else               
                    if isfield(plotstate,'plotLst') && ~SD.MeasListAct(plotstate.plotLst(idx))
                        set(h,'linewidth',2);
                        set(h,'linestyle','--');
                    end
                    if isfield(plotstate,'plotLst') && ~SD.MeasListVis(plotstate.plotLst(idx))
                        set(h,'linewidth',1);
                        set(h,'linestyle',':');
                    end
                end
            end
        end
    end
end
