close all;
t=dataSave.tHRF+5;
HbR=dataSave.HbR;
HbO=dataSave.HbO;
c_XY=movingcorr(HbO,HbR,250,1);
figure;imagesc(t,1:46,c_XY,[-1 1]);
colorbar
figure;
plotTimeseries(t,HbO)
title('HbO');
figure;
plotTimeseries(t,HbR)
title('HbR');
figure
c=corr(HbO);
imagesc(c)
colorbar
figure;
xjp_plotTracesSTD(HbO,t,250,3)