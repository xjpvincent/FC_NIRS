% ---------------------------------------------------------------------
function s = initGUI_DATA(hObject,varargin)

% Set the figure renderer. Some renderers aren't compatible 
% with certain OSs or graphics cards. Homer2_UI uses the figure renderer 
% when displaying patches. Allow user to set the renderer that is best 
% for the host system. 
% 

s = struct(...
           'RawData',[], ...
           'work_state',[],... 
           'object_state',[],...
           'plot_state',[]...
          );
%      s.fig_processing=hObject;
%set plot state;
s.plotstate.color=[0 0 1; 
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
s.plotstate.plotType=1;
s.plotstate.linestyle={'-',':','--'};
s.plotstate.plotlist=[];
s.plotstate.plotOD=1;
s.plotstate.Conc=0;
s.plotstate.RawData=1;
s.plotstate.workpath=cd;
s.plotstate.selectedsubject=[];
s.plotstate.plotpath=[];
s.plotstate.plot=[];
s.plotstate.tRange=[];
s.procResult=[];
s.currentData=[];
%s.plotstate.con=0;