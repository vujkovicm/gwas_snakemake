args <- commandArgs(trailingOnly = TRUE)

dir = "/project/saleheenlab/snakemake/"

# open
sink(file = paste(dir, "script/promis_",  args[1], ".maf", args[2], ".metal", sep = ""), append = T)

# cat
cat("# PROMIS: GWAS COHORT 1 \n")
cat("MARKER rsid \n")
cat("ALLELE alleleA alleleB \n")
cat("EFFECT frequentist_add_beta_1 \n")
cat("STDERR frequentist_add_se_1 \n")
cat("PVALUE frequentist_add_pvalue \n")
cat("WEIGHT all_total \n")
cat("GENOMICCONTROL ON \n")
cat("SEPERATOR WHITESPACE \n")
cat(paste("PROCESS ", dir, "out/PROMIS/imputed/summary/", args[1], "/", args[1], "_gwas1.snptest.maf", args[2], ".out \n", sep = ""))
cat("\n")

cat("# PROMIS: GWAS COHORT 2 \n")
cat("MARKER rsid \n")
cat("ALLELE alleleA alleleB \n")
cat("EFFECT frequentist_add_beta_1 \n")
cat("STDERR frequentist_add_se_1 \n")
cat("PVALUE frequentist_add_pvalue \n")
cat("WEIGHT all_total \n")
cat("GENOMICCONTROL ON \n")
cat("SEPERATOR WHITESPACE \n")
cat(paste("PROCESS ", dir, "out/PROMIS/imputed/summary/", args[1], "/", args[1], "_gwas2.snptest.maf", args[2], ".out \n", sep = ""))
cat("\n")

cat(paste("OUTFILE ", dir, "out/PROMIS/imputed/summary/", args[1], "/promis_", args[1], ".metal.maf", args[2], " .TBL \n", sep = ""))
cat("ANALYZE \n")
cat("SCHEME STDERR \n")
cat("QUIT \n")
sink()
