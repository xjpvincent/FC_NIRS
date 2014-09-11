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
