function [h]=plot_CorrMatrix(hObjects)
global GUI_DATA;
fig_qc=guihandles(GUI_DATA.fig_qc);
workpath=GUI_DATA.plotstate.workpath;
sublist=get(fig_qc.raw_sublist,'String');
selected_sub=sublist{get(fig_qc.raw_sublist,'Value')};
load(strcat(workpath,'\PrecessedData\',selected_sub(1:end-5),'Corr_matrix.mat'));
% if ~isfield(fig_qc,'axes_CorrMatrix')
%     return;
% end
% axes_CorrMatrix=fig_qc.axes_CorrMatrix;
% axes(axes_CorrMatrix);
axes4=fig_qc.axes4;
axes(axes4);

%plot(Corr_matrix.HbO);
h=plot(rand(4,45));
%colorbar;

end