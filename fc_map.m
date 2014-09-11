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

lst=find(SD.MeasList(:,1)>0);
ml=SD.MeasList(lst,:);
lstML = find(ml(:,4)==1); 
lst2=lstML;

x=(SD.SrcPos(ml(lstML(lst2),1),1)+SD.DetPos(ml(lstML(lst2),2),1))/2 -xmean;
y=(SD.SrcPos(ml(lstML(lst2),1),2)+ SD.DetPos(ml(lstML(lst2),2),2))/2 -ymean;
xrang=[min(x)-(max(x)-min(x))*0.10 :0.1: max(x)+(max(x)-min(x))*0.10];
yrang=[min(y)-(max(y)-min(y))*0.10 :0.1 :max(y)+(max(y)-min(y))*0.10];
yrang=xrang;
for i=1:length(xrang)
    for j=1:length(yrang)
      xrangindex(i,j)=xrang(i);
      yrangindex(i,j)=yrang(j);
    end
end
yy=griddata(x,y,fc,reshape(xrangindex,length(xrang)*length(yrang),1),reshape(yrangindex,length(xrang)*length(yrang),1));
map=reshape(yy,length(xrang),length(yrang));

% ChannelPos=[x,y];
% SrcPos=[SD.SrcPos(:,1)-xmean,SD.SrcPos(:,2)-ymean];
% DetPos=[SD.DetPos(:,1)-xmean,SD.DetPos(:,2)-ymean];
% nomalizeChannelPos=round(ChannelPos./scale)+50;
% nomalizeSrcPos=round(SrcPos/scale)+25;
% nomalizeDetPos=round(DetPos./scale)+25;
% 
% 
% for i3=1:size(nomalizeChannelPos(:,1),1)
%     map(nomalizeChannelPos(i3,1)-1:nomalizeChannelPos(i3,1)+1,...
%         nomalizeChannelPos(i3,2)-1:nomalizeChannelPos(i3,2)+1)=fc(i3);
% end
map=map';
% map=flipud(map);
% imagesc(map)


