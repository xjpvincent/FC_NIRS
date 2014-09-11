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
    rawdata=inputdata.rawdata;
    outdata.procOD.dod=nirs_MotionCorrect_Spline(rawdata.d,rawdata.t, ...
        tMotion, tMask, STDEVthresh, AMPthresh, p);
    outdata.procOD.t=rawdata.t;
    return
elseif ~isprocConc(var_name)
    outdata.procOD.dod=nirs_MotionCorrect_Spline(outdata.procOD.dod,...
    outdata.procOD.t, tMotion, tMask, STDEVthresh, AMPthresh, p);
else
    outdata.procConc.HbO=nirs_MotionCorrect_Spline(outdata.procConc.HbO,...
        outdata.procConc.t, tMotion, tMask, STDEVthresh, AMPthresh, p);
    outdata.procConc.HbR=nirs_MotionCorrect_Spline(outdata.procConc.HbR,...
        outdata.procConc.t, tMotion, tMask, STDEVthresh, AMPthresh, p);
    outdata.procConc.HbT=nirs_MotionCorrect_Spline(outdata.procConc.HbT,...
        outdata.procConc.t, tMotion, tMask, STDEVthresh, AMPthresh, p);
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

%is exist procOD;
function [r]=isprocOD(var_name)
r=0;
x=strfind(var_name,'procOD');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
    end
end
%is exist procConc
function [r]=isprocConc(var_name)
r=0;
x=strfind(var_name,'procConc');
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