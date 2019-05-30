# RLFimpute
Imputation for scRNA-seq data based on the reinforcement learning framwork (RLF).

## Brief Introduction
- RLFimpute is a novel imputation algorithm based on the reinforcement learning framework (RLF) to deal with dropouts in scRNA-seq data. We see dropout as agent, current matrix as environment, the process of imputation as state changes, and Davies-Bouldin Index as reward.<br/>
- The input of RLFimpute is read count matrix data (genes x cells). It preprocessed the data and applies RLFimpute to get the candidate sets of dropouts and then get the imputed data (genes x cells).<br/>
- We have tested RLFimpute on Matlab2018a software on different operating systems(Windows, Linux, Mac OS). RLFimpute enables GPU acceleration inaddition to CPU computing as long as the GPUs are available.<br/>

### Dependences
RLFimpute depends on matlab's parfor parallel computing, make sure your matlab version can use parfor before running RLFimpute.<br/>
Before using parfor, you must first configure and start the parallel computing pool. <br/>
Parpool function provides parallel pool configuration and opening functions.<br/>
> p=parpool

If your parfor works, you will get the information about NumWorkers, IdleTimeout, SpmdEnabled, etc.

### Implementation
Running the script would read the rawdata matrix, processes it, call RLFimpute and get the recovered matrix.<br/>
> parfor_main.m

### Data visualization
PCA visualization:<br/>
> visulaization.m

T-sne visualization:<br/>
> addpath(genpath('TSNE'));<br/>
> mappedX = tsne(rawcount_imp',[],2,50,30);<br/>
> gscatter(mappedX(:,1),mappedX(:,2),X);

### Calculation of clustering evaluation indices
Calculate rand index:<br/>
> ri = rand_index(p, p1);

Calculate adjusted rand index:<br/>
> ari = rand_index(p, p1, 'adjusted');

### GPU acceleration
When the data is too large, you can run RLFimpute on GPUs for acceleration.<br/>
Get the information about your GPU:<br/>
> gpuDevice

Move data from CPU to GPU using function: gpuArray, usage:<br/>
> rawdata = gpuArray(data);

After calculation, the imputed data is moved out to the CPU storage using function: gather, usage:<br/>
>rawdata_imp = gather(rawdata_norm);
