 
for i=1:46
    fc=corr(Conc.HbO);
    fc=fc(:,3);
    [map]=fc_map(SD,fc);
    figure;
    

   % imagesc(map)
imagesc(conv2(map,ones(3)/9,'same'));
colorbar
end
close all