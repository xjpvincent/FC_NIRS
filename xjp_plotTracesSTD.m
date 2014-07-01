
function h=xjp_plotTracesSTD(signal,t,window_length,stdThre,traceColors)
std_sig=zeros(size(signal));
for i=1:size(signal,2)
    std_sig(:,i)=movingstd(signal(:,i),window_length,'central');
    m_std=mean(std_sig(:,i));
    s_std=STD(std_sig(:,i));
    std_sig(:,i)=std_sig(:,i)>(m_std+stdThre*s_std);
end
%t1=t(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))));
std_sig1=std_sig(window_length/(2*abs(t(1)-t(2))):end-window_length/(2*abs(t(1)-t(2))),:);
h=imagesc(t,1:size(signal,2),std_sig1');