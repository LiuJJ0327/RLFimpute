function [hv_data,processed_data] = process_data(data)

min_count=2; min_cells=3;
  
%% Removing outliers
cs= sum(data>min_count);
x_use_genes = find(cs>min_cells);
gene_filtered_data=data(:,x_use_genes);

%% Normalization
libsize  = sum(gene_filtered_data,2);
geneFiltered_normed_data = bsxfun(@rdivide, gene_filtered_data, libsize) * median(libsize);

%% Log transform
processed_data = log2(1+geneFiltered_normed_data);

%% Select highly variable genes
[hv_data] = find_hv_genes(processed_data);
end

