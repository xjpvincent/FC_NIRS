function [ outdata ] = fc_nirs_OD2Conc( inputdata,ppf )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
var_name=fieldnames(inputdata);
% for nidx=1:size(var_name)
%     if isempty(strfind(var_name{nidx},'nomalizedOD')
%        %have no nomalizedOD; 
%     end
%     
%     
%     
% end
outdata=inputdata;
SD=inputdata.SD;
nWav = length(SD.Lambda);
ml = SD.MeasList;
if ~isprocOD(var_name)
    %covert od 2 conc
    dod = Intensity2OD( inputdata.rawdata.d );
    outdata.procOD.dod=dod;
    outdata.procOD.t=inputdata.rawdata.t;
end
dc=OD2Conc(outdata.procOD.dod,outdata.SD,ppf);
HbO=squeeze(dc(:,1,:));
HbR=squeeze(dc(:,2,:));
HbT=squeeze(dc(:,3,:));
procConc.HbO=HbO;
procConc.HbR=HbR;
procConc.HbT=HbT;
procConc.t=outdata.procOD.t;
outdata.procConc=procConc;

% dc = hmrOD2Conc( dod, SD, ppf )
%
% UI NAME:
% OD_to_Conc
%
% dc = hmrOD2Conc( dod, SD, ppf )
% Convert OD to concentrations
%
% INPUTS:
% dod: the change in OD (#time points x #channels)
% SD:  the SD structure
% ppf: partial pathlength factors for each wavelength. If there are 2
%      wavelengths of data, then this is a vector ot 2 elements.
%      Typical value is ~6 for each wavelength if the absorption change is 
%      uniform over the volume of tissue measured. To approximate the
%      partial volume effect of a small localized absorption change within
%      an adult human head, this value could be as small as 0.1.
%
% OUTPUTS:
% dc: the concentration data (#time points x 3 x #SD pairs
%     3 concentrations are returned (HbO, HbR, HbT)
%
% reference:
function dc = OD2Conc( dod, SD, ppf )

nWav = length(SD.Lambda);
ml = SD.MeasList;

if length(ppf)~=nWav
    errordlg('The length of PPF must match the number of wavelengths in SD.Lambda');
    dc = zeros(size(dod,1),3,length(find(ml(:,4)==1)));
    return
end

nTpts = size(dod,1);

e = GetExtinctions( SD.Lambda );
e = e(:,1:2);
einv = inv( e'*e )*e';

lst = find( ml(:,4)==1 );
for idx=1:length(lst)
    idx1 = lst(idx);
    idx2 = find( ml(:,4)>1 & ml(:,1)==ml(idx1,1) & ml(:,2)==ml(idx1,2) );
    rho = norm(SD.SrcPos(ml(idx1,1),:)-SD.DetPos(ml(idx1,2),:));
    dc(:,:,idx) = ( einv * (dod(:,[idx1 idx2'])./(ones(nTpts,1)*rho*ppf))' )';
end
dc(:,3,:) = dc(:,1,:) + dc(:,2,:);

% UI NAME:
% Intensity_to_OD 
%
% Converts internsity (raw data) to optical density
%
% INPUT
% d - intensity data (#time points x #data channels
%
% OUTPUT
% dod - the change in optical density

%Reference:
%to Homer2.
%
function dod = Intensity2OD( d )
% convert to dod
dm = mean(abs(d),1);
nTpts = size(d,1);
dod = -log(abs(d)./(ones(nTpts,1)*dm));

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
