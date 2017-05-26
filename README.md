# gwas_snakemake

Snakemake 
First install miniconda3 (works on python3.6 so have to manually install 2.5 (snakemake))
Website:
https://conda.io/miniconda.html
execute the shell script. Make sure that the path to python in your .bashrc file points to miniconda3 directory.

You can check if the correct python is called with

> which python

> conda install python = 3.5

> conda install -c bioconda snakemake

> conda create --name promis --file reqs.txt python = 3.5

> source activate promis

locuszoom only works on python version 2, so create a seperate environment for that to run on

> conda create --name promis2 --file reqs.txt python = 2.7

> source activate promis2

To save the current conda package list, activate the workflow and submit the following command:

for python 3.5
> source activate promis
> conda list --explicit > reqs.txt

or for python 2.7
> source activate promis2
> conda list --explicit > reqs2.txt
