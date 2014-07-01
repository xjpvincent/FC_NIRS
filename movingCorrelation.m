function correlationTS = movingCorrelation(dataMatrix, windowSize, indexColumn)
 
[N,M] = size(dataMatrix);
correlationTS = nan(N, M-1);
 
for t = windowSize+1:N
    C = corrcoef(dataMatrix(t-windowSize:t, :));
    idx = setdiff(1:M, [indexColumn]);
    correlationTS(t, :) = C(indexColumn, idx);
end