function [DBM] = pca_kmeans(rawcount_norm,k)
    PR=rawcount_norm';
    [coef,score,latent,t2] = pca(PR);
    score2= bsxfun(@minus,PR,mean(PR,1))*coef;
    xy=score2';
    x=xy(1,:); 
    y=xy(2,:);
    [resX,resY,record ] = FunK_mean( x,y,k );
    get_label;
    DBM= getDB(PR,p1);
end

