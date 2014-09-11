% test for spline-corr
close all;
testData=rand(1000,1);
testData(501:550,:)=4*rand(50,1);
t=1:1000;
tMotion=20;
STDEVthresh=3;
tMask=20;

[tInc,tIncCh] = hmrMotionArtifactByChannel([testData],...
         t, [],tMotion, tMask, STDEVthresh, 100);

%      [tInc,tIncCh] = hmrMotionArtifactByChannel(inputdata.rawdata.d,...
%          inputdata.rawdata.t, SD, [],tMotion, tMask, STDEVthresh, 100);
% for j=1:92;
%     tInc(:,j)=tInc(:,1);
% tIncCh=detect_stdArtifact(inputdata.procConc.HbO,inputdata.procConc.t,tMotion,STDEVthresh);
% % end

figure;
imagesc(tIncCh')
% outdata.procOD.dod= hmrMotionCorrectSpline(inputdata.procOD.dod, inputdata.procOD.t, SD, tIncCh, p);
tmark=abs(diff(tIncCh));
[tindex]=find(tmark==1);
x= hmrMotionCorrectSpline([testData], ...
   t,  tIncCh, 0.01);
subplot(2,1,1)
plot(0.1:0.1:100,testData);
hold on;
for t=1:size(tindex,1);
     line([tindex(t)/10,tindex(t)/10],[0,2],'Color','r');
end
axis([0 100 -1 2]);

subplot(2,1,2);
plot(0.1:0.1:100,x);
hold on;
for t=1:size(tindex,1);
    line([tindex(t)/10,tindex(t)/10],[-1,2],'Color','r');
end
axis([0 100 -1 2]);


