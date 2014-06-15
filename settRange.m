function settRange(hObject,eventdata,handles);
global GUI_DATA;
fig_processing=guihandles(GUI_DATA.fig_processing);
if ~isempty(GUI_DATA.currentData)
    t=GUI_DATA.currentData.t;
    tRange=str2num(get(fig_processing.data_tRange,'String'));
    if size(tRange,2)==2
        
        if tRange(1)>tRange(2)
            errordlg('The time range you input,the start time point is larger then the end point! Plese check.');
            set(hObject,'String',strcat('[',num2str([0 0]),']'));
            return;
        end
        if tRange(1)<t(1)||tRange(2)>t(end)
            %          errordlg('The time range you input is erro! Plese check.');
            %          set(hObject,'String',strcat('[',num2str([0 0]),']'));
            return;
        end
      
    else
        errordlg('Your input maybe wrong.Plese check.');
        set(hObject,'String',strcat('[',num2str([0 0]),']'));
    end
end
GUI_DATA.plotstate.tRange=tRange;
displayData();

