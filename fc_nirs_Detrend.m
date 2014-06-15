function [ outdata ] = fc_nirs_Detrend( inputdata,p )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
var_name=fieldnames(inputdata);
outdata=inputdata;
if ~isprocOD(var_name)
    rawdata=inputdata.rawdata;
    outdata.procOD.dod=nirs_detrend(rawdata.d,p);
    outdata.procOD.t=rawdata.t;
    return
elseif ~isprocConc(var_name)
    outdata.procOD.dod=nirs_detrend(outdata.procOD.dod,p);
else
    outdata.procConc.HbO=nirs_detrend(outdata.procConc.HbO,p);
    outdata.procConc.HbR=nirs_detrend(outdata.procConc.HbR,p);
    outdata.procConc.HbT=nirs_detrend(outdata.procConc.HbT,p);
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
