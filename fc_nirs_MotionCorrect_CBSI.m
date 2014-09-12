function [ outdata] = fc_nirs_MotionCorrect_CBSI(inputdata,para)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
% end
var_name=fieldnames(inputdata);
if (isprocConc(var_name))
    outdata=inputdata;
    outdata.dcCbsi = nirs_MotionCorrectCbsi(outdata.Conc,4);
else
    disp('CBSI method must have Conc data£¬ please check the input set');
    
end
end

%is exist Conc
function [r]=isprocConc(var_name)
r=0;
x=strfind(var_name,'Conc');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
    end
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% function dcCbsi = hmrMotionCorrectCbsi(dc,SD,flagSkip)
%
% UI NAME:
% Cbsi_Motion_Correction
%
% Perform a correlation-based signal improvement of the concentration
% changes in order to correct for motion artifacts.  
% The algorithm follows the procedure described by
% Cui et al.,NeuroImage, 49(4), 3039-46 (2010).
%
% INPUTS:
% dc:    Concentration changes (it works with HbO and HbR)
% SD:    SD structure
% flagSkip:  Skip this function if flagSkip=1. Otherwise execute function. 
%            Default is to execute function if this does not exist.
% 
%
% OUTPUTS:
% dcSpline:  dc after correlation-based signal improvement correction, same
%            size as dc (Channels that are not in the active ml remain unchanged)
%
% LOG:
% created 10-17-2012, S. Brigadoi
% modify 2014/8/19. J.P Xu
%
function dcCbsi = nirs_MotionCorrectCbsi(Conc,flagSkip)
if ~exist('flagSkip')
    flagSkip = 0;
end
if flagSkip==1
    dcCbsi = Conc;
    return;
end
%mlAct = SD.MeasListAct; % prune bad channels
lstAct = 1:size(Conc.HbO,2);
dcCbsi = Conc;
for ii = 1:length(lstAct)
    idx_ch = lstAct(ii);
    dc_oxy = Conc.HbO(:,idx_ch)-mean(Conc.HbO(:,idx_ch),1);
    dc_deoxy = Conc.HbR(:,idx_ch)-mean(Conc.HbR(:,idx_ch),1);
    sd_oxy = std(dc_oxy,0,1);
    sd_deoxy = std(dc_deoxy,0,1);
    alfa = sd_oxy/sd_deoxy;
    dcCbsi.HbO(:,idx_ch) = 0.5*(dc_oxy-alfa*dc_deoxy);
    dcCbsi.HbR(:,idx_ch) = -(1/alfa)*dcCbsi.HbO(:,idx_ch);
    dcCbsi.HbT(:,idx_ch) =  dcCbsi.HbO(:,idx_ch) + dcCbsi.HbR(:,idx_ch);
end
end
