function [map]=fc_map(SD,fc);
MeasList=SD.MeasList;

map=zeros(100,100);
map(find(map==0))=NaN;
xmean=mean(mean([SD.SrcPos(:,1); SD.DetPos(:,1)]));
ymean=mean(mean([SD.SrcPos(:,2);SD.DetPos(:,2)]));
xRange=max(max([SD.SrcPos(:,1);SD.DetPos(:,1)]))...
    -min(min([SD.SrcPos(:,1); SD.DetPos(:,1)]));
yRange=max(max([SD.SrcPos(:,2);SD.DetPos(:,2)]))...
    -min(min([SD.SrcPos(:,2); SD.DetPos(:,2)]));
 scale=max([xRange,yRange])/50;
%scale=min(abs([SD.SrcPos(1,1)-SD.DetPos(1,1) SD.SrcPos(1,2)-SD.DetPos(1,2)]))/2

% h=plot(SD.SrcPos(:,1)-xmean,SD.SrcPos(:,2)-ymean,'.r');
% hold on;
% plot(SD.DetPos(:,1)-xmean,SD.DetPos(:,2)-ymean,'.b');
lst=find(SD.MeasList(:,1)>0);
ml=SD.MeasList(lst,:);
lstML = find(ml(:,4)==1); 
lst2=lstML;
% for ii=1:length(lst2)
%     plot( (SD.SrcPos(ml(lstML(lst2(ii)),1),1)+SD.DetPos(ml(lstML(lst2(ii)),2),1))/2 -xmean, ...
%         (SD.SrcPos(ml(lstML(lst2(ii)),1),2)+ SD.DetPos(ml(lstML(lst2(ii)),2),2))/2 -ymean ,'*k');
% end
%map to a matrix
x=(SD.SrcPos(ml(lstML(lst2),1),1)+SD.DetPos(ml(lstML(lst2),2),1))/2 -xmean;
y=(SD.SrcPos(ml(lstML(lst2),1),2)+ SD.DetPos(ml(lstML(lst2),2),2))/2 -ymean;
ChannelPos=[x,y];
SrcPos=[SD.SrcPos(:,1)-xmean,SD.SrcPos(:,2)-ymean];
DetPos=[SD.DetPos(:,1)-xmean,SD.DetPos(:,2)-ymean];
nomalizeChannelPos=round(ChannelPos./scale)+50;
nomalizeSrcPos=round(SrcPos/scale)+25;
nomalizeDetPos=round(DetPos./scale)+25;
% for i1=1:size(nomalizeSrcPos(:,1),1)
%     map(nomalizeSrcPos(i1,1),nomalizeSrcPos(i1,2))=1;
% end
% for i2=1:size(nomalizeDetPos(:,1),1)
%     map(nomalizeDetPos(i2,1),nomalizeDetPos(i2,2))=2;
% end
for i3=1:size(nomalizeChannelPos(:,1),1)
    map(nomalizeChannelPos(i3,1)-1:nomalizeChannelPos(i3,1)+1,...
        nomalizeChannelPos(i3,2)-1:nomalizeChannelPos(i3,2)+1)=fc(i3);
end
%[idx idy]=find((map>0));
% for i=1:length(idx)
%     map(idx(i)-5:idx(i)+5,idy(i)-5:idy(i)+5)=fc(i);
% end
% [idx idy]=find(map==1);
% for i=1:length(idx)
%     map(idx(i):idx(i),idy(i):idy(i))=1;
% end
% [idx idy]=find(map==2);
% for i=1:length(idx)
%     map(idx(i):idx(i),idy(i):idy(i))=2;
% end
%figure;
map=map';
% imagesc(map)


