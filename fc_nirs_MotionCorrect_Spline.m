function [outdata] = fc_nirs_MotionCorrect_Spline( inputdata, para )
%
%00
%
%
% OUTPUT:
% 
%
% need to modified 
outdata=inputdata;
tMotion=str2num(para.tMotion);
tMask=str2num(para.tMask);
STDEVthresh=str2num(para.STDEVthresh);
AMPthresh=str2num(para.AMPthresh);
p=str2num(para.p);
SD=inputdata.SD;
[tInc,tIncCh] = hmrMotionArtifactByChannel(inputdata.rawdata.d,...
         inputdata.rawdata.t, SD, [],tMotion, tMask, STDEVthresh, 100);
% for j=1:92;
%     tInc(:,j)=tInc(:,1);
% end
outdata.procOD.dod= hmrMotionCorrectSpline(inputdata.procOD.dod, inputdata.procOD.t, SD, tIncCh, p);

% var_name=fieldnames(inputdata);
% if ~isprocOD(var_name)
%     rawdata=inputdata.rawdata;
%     outdata.procOD.dod=nirs_MotionCorrect_Spline(inputdata.rawdata.d,...
%         rawdata.t, SD, tMotion, tMask, STDEVthresh, AMPthresh,p);
%     outdata.procOD.t=rawdata.t;
%     return
% elseif ~isprocConc(var_name)
%     outdata.procOD.dod=nirs_MotionCorrect_Spline(inputdata.procOD.dod,...
%     fs, SD, tMotion, tMask, STDEVthresh, AMPthresh,p);
%    
% else
% %     outdata.procConc.HbO=nirs_MotionCorrect_Spline(outdata.procConc.HbO,...
% %         outdata.procConc.t, SD, tMotion, tMask, STDEVthresh, AMPthresh,p);
% %     outdata.procConc.HbR=nirs_MotionCorrect_Spline(outdata.procConc.HbR,...
% %         outdata.procConc.t, SD, tMotion, tMask, STDEVthresh, AMPthresh,p);
% %     outdata.procConc.HbT=nirs_MotionCorrect_Spline(outdata.procConc.HbT,...
% %         outdata.procConc.t, SD, tMotion, tMask, STDEVthresh, AMPthresh,p);
%  rawdata=inputdata.rawdata;
%     outdata.procOD.dod=nirs_MotionCorrect_Spline(inputdata.rawdata.d,...
%         rawdata.t, SD, tMotion, tMask, STDEVthresh, AMPthresh,p);
%     outdata.procOD.t=rawdata.t;
%     return
% end


function [y] = nirs_MotionCorrect_Spline(x, fs, SD, tMotion, tMask, STDEVthresh, AMPthresh, p )
%add by xjp
%hmrMotionArtifact and hmrMotionCorrectSpline reference to Homer2;
%
tInc = hmrMotionArtifact(x, fs, SD,  tMotion, tMask, STDEVthresh, AMPthresh)
y = hmrMotionCorrectSpline(x, t, SD, tInc, p);
;

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