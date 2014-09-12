function [ outdata ] = fc_nirs_tRange(inputdata,tRange )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%tRange=str2num(tRange);
tRange=str2num(tRange);
var_name=fieldnames(inputdata);
outdata=inputdata;
if length(tRange<3);
if ~isprocOD(var_name)
    RawData=inputdata.RawData;
    t=RawData.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.OD.dod=RawData.d(tindex,:);
    outdata.OD.t=t(tindex)-tRange(1);
    %outdata.OD.dod=nirs_detrend(RawData.d,p);
    %outdata.OD.t=RawData.t;
    return
elseif ~isprocConc(var_name)
    t=outdata.OD.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.OD.dod=outdata.OD.dod(tindex,:);
    outdata.OD.t=t(tindex)-tRange(1);    
else
    t=outdata.Conc.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.Conc.HbO=outdata.Conc.HbO(tindex,:);
    outdata.Conc.HbR=outdata.Conc.HbR(tindex,:);
    outdata.Conc.HbT=outdata.Conc.HbT(tindex,:);
    outdata.Conc.t=t(tindex)-tRange(1);  
end
elseif length(tRange>=3)
    if ~isprocOD(var_name)
    RawData=inputdata.RawData;
    t=RawData.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.OD.dod=RawData.d(tindex,:);
    outdata.OD.t=t(tindex)-tRange(1);
    %outdata.OD.dod=nirs_detrend(RawData.d,p);
    %outdata.OD.t=RawData.t;
    return
    elseif ~isprocConc(var_name)
    t=outdata.OD.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.OD.dod=outdata.OD.dod(tindex,:);
    outdata.OD.t=t(tindex)-tRange(1);    
    else
    t=outdata.Conc.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.Conc.HbO=outdata.Conc.HbO(tindex,:);
    outdata.Conc.HbR=outdata.Conc.HbR(tindex,:);
    outdata.Conc.HbT=outdata.Conc.HbT(tindex,:);
    outdata.Conc.t=t(tindex)-tRange(1);  
end
    
end

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