# args <- commandArgs(trailingOnly = TRUE)

setwd("/project/saleheenlab/snakemake/report/")

# getting pandoc errors with executing html reports
# conda install -c conda-forge pandoc=1.19.2

library(rmarkdown)
library(tools)

rmarkdown::render(input = "report.Rmd", output_file = "summary/PROMIS_Summary.html")

