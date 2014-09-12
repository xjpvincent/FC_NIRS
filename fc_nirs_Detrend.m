function [ outdata ] = fc_nirs_Detrend( inputdata,p )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
var_name=fieldnames(inputdata);
p=str2num(p);
outdata=inputdata;
if ~isprocOD(var_name)
    RawData=inputdata.RawData;
    outdata.OD.dod=nirs_detrend(RawData.d,p);
    outdata.OD.t=RawData.t;
    return
elseif ~isConc(var_name)
    outdata.OD.dod=nirs_detrend(outdata.OD.dod,p);
else
    outdata.Conc.HbO=nirs_detrend(outdata.Conc.HbO,p);
    outdata.Conc.HbR=nirs_detrend(outdata.Conc.HbR,p);
    outdata.Conc.HbT=nirs_detrend(outdata.Conc.HbT,p);
end


function y = nirs_detrend(x,p)
% Polynomial detrending over columns
% FORMAT y = spm_detrend(x,p)
% x   - data matrix
% p   - order of polynomial [default: 0]
% 
% y   - detrended data matrix
%__________________________________________________________________________
%  removes linear and nonlinear trends 
% matrices.
[m n] = size(x);
if ~m || ~n
    y = [];
    return
end
if nargin == 1
    p = 0;
end

% centre columns
%--------------------------------------------------------------------------
if ~p
    for i = 1:n
        y(:,i) = x(:,i) - mean(x(:,i));
    end
    return
end

% polynomial adjustment
%--------------------------------------------------------------------------
G     = zeros(m,p+1);
for i = 0:p
    d = (1:m).^i;
    G(:,i+1) = d(:);
end
y     = x - G*(pinv(full(G))*x);


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
function [r]=isConc(var_name)
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
