function std_sig=detect_stdArtifact(signal,t,window_length,stdThre,traceColors)
cla
std_sig=zeros(size(signal));
for i=1:size(signal,2)
    std_sig(:,i)=movingstd(signal(:,i),round(window_length/abs(t(1)-t(2))),'central');
    m_std=mean(std_sig(:,i));
    s_std=std(std_sig(:,i));
    std_sig(:,i)=std_sig(:,i)>(m_std+stdThre*s_std);
end
t1=t(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))));
% std_sig1=std_sig(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))),:);
% h=imagesc(t1,1:size(signal,2),std_sig1');
