function [hv_data] = find_hv_genes(processed_data)
for i=1:size(processed_data,2)
    nozero=processed_data((processed_data(:,i)~=0),i);
    mu(1,i)=mean(nozero);
    sd(1,i)=std(nozero);
    cv(1,i)=sd(1,i)/mu(1,i);
end
hv=find(mu>=1 & cv>= prctile(cv,25));
hv_data=processed_data(:,hv);
end

