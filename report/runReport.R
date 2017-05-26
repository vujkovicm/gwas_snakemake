args <- commandArgs(trailingOnly = TRUE)

setwd("/project/saleheenlab/snakemake/report/")

# getting pandoc errors with executing html reports
# conda install -c conda-forge pandoc=1.19.2

library(rmarkdown)
library(tools)
library(knitr)

rmarkdown::render(input = "report.Rmd", output_file = paste("out/PROMIS_", args[1], "_Summary.html", sep = ""))

