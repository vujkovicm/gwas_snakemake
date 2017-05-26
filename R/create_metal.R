args <- commandArgs(trailingOnly = TRUE)

#
# METAL script creation
#

# set working directory
dir = "/project/saleheenlab/snakemake/"

# open
sink(file = paste(dir, "script/promis_",  args[1], ".metal", sep = ""), append = T)

# additional variables to incorporate in metal output
cat("CUSTOMVARIABLE all_total \n")
cat("LABEL all_total as all_total \n")

cat("CUSTOMVARIABLE chromosome \n")
cat("LABEL chromosome as chromosome \n")

cat("CUSTOMVARIABLE position \n")
cat("LABEL position as position \n")

# options
cat("SCHEME STDERR \n")
cat("AVERAGEFREQ ON \n")
cat("MINMAXFREQ ON \n")
cat("COLUMNCOUNTING STRICT \n")
cat("GENOMICCONTROL ON \n")

# meta-analysis parameters
cat("# PROMIS: GWAS COHORT 1 \n")
cat("MARKER SNP \n")
cat("ALLELE alleleA alleleB \n")
cat("EFFECT frequentist_add_beta_1 \n")
cat("STDERR frequentist_add_se_1 \n")
cat("PVALUE frequentist_add_pvalue \n")
cat("WEIGHT all_total \n")
cat("FREQ all_maf \n")
cat("SEPERATOR WHITESPACE \n")
cat(paste("PROCESS ", dir, "out/PROMIS/imputed/summary/", args[1], "/", args[1], "_gwas1.snptest.filtered.out \n", sep = ""))
cat(paste("PROCESS ", dir, "out/PROMIS/imputed/summary/", args[1], "/", args[1], "_gwas2.snptest.filtered.out \n", sep = ""))
cat("\n")

# export
cat(paste("OUTFILE ", dir, "out/PROMIS/imputed/summary/", args[1], "/promis_", args[1], ".metal.", " .TBL \n", sep = ""))
cat("ANALYZE HETEROGENEITY \n")
cat("QUIT \n")
sink()
