args <- commandArgs(trailingOnly = TRUE)

setwd("/project/saleheen/snakemake/report")

library(rmarkdown)
library(tools)

rmarkdown::render(input = "report.Rmd", output_file = paste(args[1], "-x", args[2], "-", args[3], ".html", sep = ""))
