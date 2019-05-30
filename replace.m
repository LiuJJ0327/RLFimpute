function [DBI] = replace(rawcount_norm,i,k)
MV=rawcount_norm(i,rawcount_norm(i,:)~=0);
NI=find(rawcount_norm(i,:)==0);
MI=find(rawcount_norm(i,:)~=0);
celln=size(rawcount_norm,2);
DB=zeros(length(NI),length(MV));
for j=1:length(NI)
    for l=1:length(MV)
        rawcount_norm(i,NI(j))=MV(l);
%         E=evalclusters(rawcount_norm','kmeans','DaviesBouldin','klist',1:4);
%         DB(j,k)=E.CriterionValues(4);
        [DBM] = pca_kmeans(rawcount_norm,k);
        DB(j,l)=DBM;
    end
end
DBI=zeros(length(NI),celln+1);
%DBI(:,celln+1)=i;
DBI(:,MI)=DB;
end

