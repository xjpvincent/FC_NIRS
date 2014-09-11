% [tInc,tIncCh] = hmrMotionArtifactByChannel(d, fs, SD, tIncMan, tMotion, tMask, STDEVthresh, AMPthresh)
%
% UI NAME:   
% Motion_Artifacts_By_Channel
%
%
% Identifies motion artifacts in an input data matrix d. If any active 
% data channel exhibits a signal change greater than std_thresh or
% amp_thresh, then a segment of data around that time point is marked as a
% motion artifact. The channel-wise motion artifacts are recorded in the
% output matrix tIncCh. If any channel has a motion artifact, it is
% indicated by the vector tInc.
%
%
% INPUTS:
% d: data matrix, timepoints x sd pairs
% fs: sample frequency in Hz. You can send the time vector and fs will be
%     calculated
% SD: Source Detector Structure. The active data channels are indicated in
%     SD.MeasListAct.
% tIncMan: Data that has been manually excluded. 0-excluded. 1-included.
%          Vector same length as d.
% tMotion: Check for signal change indicative of a motion artifact over
%     time range tMotion. Units of seconds.
% tMask: Mark data over +/- tMask seconds around the identified motion 
%     artifact as a motion artifact. Units of seconds.
% STDEVthresh: If the signal d for any given active channel changes by more
%     that stdev_thresh * stdev(d) over the time interval tMotion, then
%     this time point is marked as a motion artifact. The standard deviation is
%     determined for each channel independently.
% AMPthresh: If the signal d for any given active channel changes by more
%     that amp_thresh over the time interval tMotion, then this time point
%     is marked as a motion artifact.
%
%
% OUTPUTS:
% tInc: a vector of length time points with 1's indicating data included
%       and 0's indicate motion artifact
% tIncCh: a matrix with #time points x #channels, with 1's indicating data
%       included and 0's indicating motion artifacts on a channel by
%       channel basis
%
% LOG:
% K. Perdue
% kperdue@nmr.mgh.harvard.edu
% Sept. 23, 2010
% Modified by DAB 3/17/2011 to not act on a single channel by default
% DAB 4/20/2011 added tMotion and tMask and hard coded stdev option.
% DAB 8/4/2011 added amp_thresh to work at same time as std_thresh
%
% TO DO:
% Consider tIncMan

function [tInc,tIncCh] = hmrMotionArtifactByChannel(signal, t,  tIncMan, tMotion, tMask, std_thresh, amp_thresh)
for i=1:size(signal,2)
    std_sig(:,i)=movingstd(signal(:,i),round(tMotion/abs(t(1)-t(2))),'central');
    m_std=mean(std_sig(:,i));
    s_std=std(std_sig(:,i));
    std_sig(:,i)=std_sig(:,i)>(m_std+std_thresh*s_std);
end
t1=t(tMotion/(2*abs(t(1)-t(2))):end-tMotion/(2*abs(t(1)-t(2))));
% tIncCh=std_sig(tMotion/(2*abs(t(1)-t(2))):end-tMotion/(2*abs(t(1)-t(2))),:);
onetmp=ones(size(std_sig));
tIncCh=onetmp(find(std_sig==0));
tInc=0;
% h=imagesc(t1,1:size(signal,2),std_sig1');
% Input processing.  Check required inputs, throw errors if necessary.
