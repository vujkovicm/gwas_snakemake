# gwas_snakemake

Snakemake 
First install miniconda3 (works on python3.6 so have to manually install 2.5 (snakemake))
Website:
https://conda.io/miniconda.html
execute the shell script. Make sure that the path to python in your .bashrc file points to miniconda3 directory.

##### if you correctly installed miniconda3 then you can add the following lines to your profile
##### ~/.bashrc file may look like this
##### export PATH="/home/username/miniconda3/bin:$PATH"
##### export PATH="/home/username/miniconda3:$PATH"

You can check if the correct python is called with

> which python

> conda install python = 3.5

> conda install -c bioconda snakemake

> conda create --name promis3 --file reqs3.txt python = 3.5

> source activate promis

locuszoom only works on python version 2, so create a seperate environment for that to run on

> conda create --name promis2 --file reqs2.txt python = 2.7

> source activate promis2

To save the current conda package list, activate the workflow and submit the following command:

for python 3.5
> source activate promis3

> conda list --explicit > reqs.txt

or for python 2.7
> source activate promis2

> conda list --explicit > reqs2.txt
