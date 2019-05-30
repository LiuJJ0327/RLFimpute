%% Data visualization using PCA
M=rawcount_imp';
[coef,score,latent,t2] = pca(M);
score2= bsxfun(@minus,M,mean(M,1))*coef;
xy=score2';
x=xy(1,:); 
y=xy(2,:);
k=2; % k is the number of true cell types,change it when data changes
[resX resY record] =FunK_mean(x,y,k);
get_label;
%% visualize data of predicted label
gscatter(x,y,p1);   %p1 is the predicted label;

%% visualize data of true label
p=load('data/pre/label.mat');
%p=load('data/simulated/label.mat')
gscatter(x,y,p);    %p is the true label;

%% TSNE visualization
% addpath(genpath('TSNE'));
% mappedX = tsne(rawcount_imp',[],2,50,30);
% gscatter(mappedX(:,1),mappedX(:,2),X);

%% Calculation of clustering evaluation indices
% addpath(genpath('Index')); 
% ri = rand_index(p, p1); %calculate rand index
% ari = rand_index(p, p1, 'adjusted');  %calculate adjusted rand index

                