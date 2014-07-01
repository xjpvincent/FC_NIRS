function [outdata] = fc_nirs_BandpassFilt( inputdata, band )

%
% UI NAME:
% Bandpass_Filter
%
% y2 = hmrBandpassFilt( y, fs, hpf, lpf )
% Perform a bandpass filter
%
% INPUT:
% y - data to filter #time points x #channels of data
% fs - sample frequency (Hz). If length(fs)>1 then this is assumed to be a time
%      vector from which fs is estimated
% hpf - high pass filter frequency (Hz)
%       Typical value is 0 to 0.02.
% lpf - low pass filter frequency (Hz)
%       Typical value is 0.5 to 3.
%
% OUTPUT:
% y2 - filtered data
% convert t to fs
% assume fs is a time vector if length>1
% 
%
% need to modified   
band=str2num(band);
hpf=band(1);
lpf=band(2);
var_name=fieldnames(inputdata);
outdata=inputdata;
if ~isprocOD(var_name)
    rawdata=inputdata.rawdata;
    outdata.procOD.dod=nirs_BandpassFilt(rawdata.d,rawdata.t, hpf, lpf);
    outdata.procOD.t=rawdata.t;
    return
elseif ~isprocConc(var_name)
    outdata.procOD.dod=nirs_BandpassFilt(outdata.procOD.dod,...
    outdata.procOD.t, hpf, lpf);
else
    outdata.procConc.HbO=nirs_BandpassFilt(outdata.procConc.HbO,...
        outdata.procConc.t, hpf, lpf);
    outdata.procConc.HbR=nirs_BandpassFilt(outdata.procConc.HbR,...
        outdata.procConc.t, hpf, lpf);
    outdata.procConc.HbT=nirs_BandpassFilt(outdata.procConc.HbT,...
        outdata.procConc.t, hpf, lpf);
end



function [y2,ylpf] = nirs_BandpassFilt( y, fs, hpf, lpf )
if length(fs)>1
    fs = 1/(fs(2)-fs(1));
end

% low pass filter
FilterType = 1;
FilterOrder = 3;
%[fa,fb]=butter(FilterOrder,lpf*2/fs);
if FilterType==1 | FilterType==5
    [fb,fa] = MakeFilter(FilterType,FilterOrder,fs,lpf,'low');
elseif FilterType==4
%    [fb,fa] = MakeFilter(FilterType,FilterOrder,fs,lpf,'low',Filter_Rp,Filter_Rs);
else
%    [fb,fa] = MakeFilter(FilterType,FilterOrder,fs,lpf,'low',Filter_Rp);
end
ylpf=filtfilt(fb,fa,y);


% high pass filter
FilterType = 1;
FilterOrder = 5;
if FilterType==1 | FilterType==5
    [fb,fa] = MakeFilter(FilterType,FilterOrder,fs,hpf,'high');
elseif FilterType==4
%    [fb,fa] = MakeFilter(FilterType,FilterOrder,fs,hpf,'high',Filter_Rp,Filter_Rs);
else
%    [fb,fa] = MakeFilter(FilterType,FilterOrder,fs,hpf,'high',Filter_Rp);
end

if FilterType~=5
    y2=filtfilt(fb,fa,ylpf); 
else
    y2 = ylpf;
end

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