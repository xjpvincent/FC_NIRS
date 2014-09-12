function [outdata] = fc_nirs_MotionCorrect_Spline( inputdata, para )

tMotion=str2num(para.tMotion);
tMask=str2num(para.tMask);
STDEVthresh=str2num(para.STDEVthresh);
AMPthresh=str2num(para.AMPthresh);
p=str2num(para.p);

% end
var_name=fieldnames(inputdata);
outdata=inputdata;
if ~isprocOD(var_name)
    RawData=inputdata.RawData;
    outdata.OD.dod=nirs_MotionCorrect_Spline(RawData.d,RawData.t, ...
        tMotion, tMask, STDEVthresh, AMPthresh, p);
    outdata.OD.t=RawData.t;
    return
elseif ~isprocConc(var_name)
    outdata.OD.dod=nirs_MotionCorrect_Spline(outdata.OD.dod,...
    outdata.OD.t, tMotion, tMask, STDEVthresh, AMPthresh, p);
else
    outdata.Conc.HbO=nirs_MotionCorrect_Spline(outdata.Conc.HbO,...
        outdata.Conc.t, tMotion, tMask, STDEVthresh, AMPthresh, p);
    outdata.Conc.HbR=nirs_MotionCorrect_Spline(outdata.Conc.HbR,...
        outdata.Conc.t, tMotion, tMask, STDEVthresh, AMPthresh, p);
    outdata.Conc.HbT=nirs_MotionCorrect_Spline(outdata.Conc.HbT,...
        outdata.Conc.t, tMotion, tMask, STDEVthresh, AMPthresh, p);
end


function [y] = nirs_MotionCorrect_Spline(x, t, tMotion, tMask, STDEVthresh, AMPthresh, p )
%add by xjp
%hmrMotionArtifact and hmrMotionCorrectSpline reference to Homer2;
%
[tInc,tIncCh] = fc_nirs_hmrMotionArtifactByChannel(x, t , [],tMotion, tMask, STDEVthresh, AMPthresh);
% figure;
% imagesc(tIncCh')
% % tmp=ones(size(tIncCh));
% tmp(1333:1334,:)=0;
y = fc_nirs_hmrMotionCorrectSpline(x, t, tIncCh, p);

%is exist OD;
function [r]=isprocOD(var_name)
r=0;
x=strfind(var_name,'OD');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
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

function [r]=israwConc(var_name)
r=0;
x=strfind(var_name,'rawConc');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
    end
end