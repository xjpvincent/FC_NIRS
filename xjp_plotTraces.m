function h=xjp_plotTraces(signal,   time)
channel = 1:size(signal,2);
for ch=2:size(signal,2);
    signal(:,ch) = signal(:,ch)+max(max(signal(:,ch-1)))-min(min(signal(:,ch)));%+max(max(signal(:,ch)));
end
if(exist('traceColors'))
    for ii=1:length(channel)
        h=plot(time, signal(:,channel(ii)),'color',traceColors(ii,:));
        hold on;
    end
else
   h= plot(time,signal(:,channel));
end

