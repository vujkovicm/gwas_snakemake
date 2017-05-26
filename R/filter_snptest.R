args <- commandArgs(trailingOnly = TRUE)

dir = "/project/saleheenlab/snakemake/"

# For MAF > .05
s    <- read.table(paste(dir, "out/PROMIS/imputed/summary/", args[1], "/", args[1], "_gwas", args[2], ".snptest.out", sep = ""), sep = " ",  T, stringsAsFactors = F)

# filter on maf, hwe (info already done previously)
s.filtered <- s[which(s$all_maf > 0.01 & s$cohort_1_hwe > 0.000001), c("filename", "rsid", "index", "position", "alleleA", "alleleB", "average_maximum_posterior_call", "info", "all_total", "all_maf", "missing_data_proportion", "cohort_1_hwe", "frequentist_add_pvalue", "frequentist_add_info", "frequentist_add_beta_1", "frequentist_add_se_1")]

# extract SNP, chromosome, and position in seperate variables 
s.filtered$chromosome <- sapply(strsplit(s.filtered$filename, "_"), "[[", 3)
s.filtered$chromosome <- as.numeric(s.filtered$chromosome)
s.filtered$RS  <- sapply(strsplit(s.filtered$rsid, ":"), "[[", 1)
s.filtered$SNP <- ifelse(is.na(as.numeric(s.filtered$RS)), s.filtered$RS, paste(s.filtered$chromosome, s.filtered$position, sep = ":"))

# remove temporary variables
s.filtered$filename = NULL
s.filtered$RS = NULL

# export
write.table(s.filtered, paste(dir, "out/PROMIS/imputed/summary/", args[1], "/", args[1], "_gwas", args[2], ".snptest.filtered.out", sep = ""), sep = " ", col.names = T, row.names = F, quote = F)
