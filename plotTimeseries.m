function h=plotTimeseries(time,signal, traceColors)
channel = 1:size(signal,2);
%kk = 0;
for ch=channel(1:end-1)
    %kk = kk+1;
    %subplot(length(channel),1,kk);
    %plot(signal(:,ch) - kk*.2);
    %hold on;
    signal(:,ch+1) = signal(:,ch+1)+max(signal(:,ch))-min(signal(:,ch+1)) ;
end
if(exist('traceColors'))
    for ii=1:length(channel)
        h=plot(time, signal(:,channel(ii)),'color',traceColors(ii,:));
        hold on;
    end
else
     hold on;
    plot(time,signal(:,channel))
end




