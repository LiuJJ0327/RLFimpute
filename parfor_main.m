clc;
clear;
tic;

%% Read data
read_data = load('testdata/testdata.mat');
data=read_data.testdata;
%% select k
E=evalclusters(data','kmeans','DaviesBouldin','klist',1:20);
k=find(E.CriterionValues==min(E.CriterionValues));

%% Data normalization
[hv_data,processed_data] = process_data(data');
%rawcount_norm=hv_data';
rawcount_norm=processed_data';

%% Get DBI matrix 
genen=size(rawcount_norm,1);
temp=[];
parfor i=1:genen
    [DBI] = replace(rawcount_norm,i,k);
    temp=[temp;DBI];
end

%% Impute for scRNA-seq data
DB=temp;
Q1=prctile(DB(DB~=0),25);
F=find(DB>Q1);
DB(F)=0;
count=0;
for i=1:size(rawcount_norm,1)
for j=1:size(rawcount_norm,2)
         if rawcount_norm(i,j)==0
              count=count+1;
              Findex=find(DB(count,:)>0);
              DBvalue=DB(count,Findex);
              Genevalue=rawcount_norm(i,Findex);
              rawcount_norm(i,j)=sum(Genevalue.*DBvalue)/sum(DBvalue);
         end
         clear Findex DBvalue Genevalue;
end
end
rawcount_imp=rawcount_norm;
rawcount_imp(isnan(rawcount_imp))=0; 
rawcount_imp(rawcount_imp==inf)=0;
time_taken=toc;


