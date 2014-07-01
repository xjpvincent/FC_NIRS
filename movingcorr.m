function c_XY = movingcorr(x ,y,windowSize,step,windowmode)
[m n]=size(x);
X=zeros(m,2*n);
% for i=1:2:n
%     X(:,i:i+1)=x(:,floor(i,2)+1);
%     Y(:,i:i+1)=y(:,floor(i,2)+1);
% end
% B=1/windowones(windowSize,1);
% Xconv=conv2(X,B,'same');
% Yconv=conv2(Y,B,'same');
XY=[x,y];
c_XY=zeros(m,n);
for i=1:step:m-windowSize
    xi=x(i:i+windowSize-1,:);
    yi=y(i:i+windowSize-1,:);
    for j=1:n
        xj=xi(:,j);
        yj=yi(:,j);
        x0 = xj - mean(xj);
        y0 = yj - mean(yj);
        c_XY(i,j) = (x0./norm(x0))' * (y0 ./ norm(y0));
    end
end
% s=c_XY;
% k=windowSize;
% switch windowmode
%   case 'central'
%     c_XY(k:(n-k)) = c_XY((2*k):end);
%   case 'forward'
%     c_XY(1:(n-k+1)) = c_XY(k:end);
%   case 'backward'
%  
% end
