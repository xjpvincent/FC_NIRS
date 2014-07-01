function [ outdata ] = fc_nirs_Intensity2OD( inputdata,para )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%para=str2num(para);
outdata=inputdata;
outdata.procOD.dod=hmrIntensity2OD(inputdata.rawdata.d);
outdata.procOD.t=inputdata.rawdata.t;
function dod = hmrIntensity2OD( d )
%Reference: homer2
% convert to dod
dm = mean(abs(d),1);
nTpts = size(d,1);
dod = -log(abs(d)./(ones(nTpts,1)*dm));