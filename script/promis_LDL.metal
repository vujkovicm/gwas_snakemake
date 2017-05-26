
CUSTOMVARIABLE all_total
LABEL all_total as all_total
CUSTOMVARIABLE chromosome
LABEL chromosome as chromosome
CUSTOMVARIABLE position
LABEL position as position
SCHEME STDERR
AVERAGEFREQ ON
MINMAXFREQ ON
COLUMNCOUNTING STRICT
GENOMICCONTROL ON
# PROMIS: GWAS COHORT 1
MARKER SNP
ALLELE alleleA alleleB
EFFECT frequentist_add_beta_1
STDERR frequentist_add_se_1
PVALUE frequentist_add_pvalue
WEIGHT all_total
FREQ all_maf
SEPERATOR WHITESPACE
PROCESS /project/saleheenlab/snakemake/out/PROMIS/imputed/summary/LDL/LDL_gwas1.snptest.filtered.out
PROCESS /project/saleheenlab/snakemake/out/PROMIS/imputed/summary/LDL/LDL_gwas2.snptest.filtered.out

OUTFILE /project/saleheenlab/snakemake/out/PROMIS/imputed/summary/LDL/promis_LDL.metal. .TBL
ANALYZE HETEROGENEITY
QUIT
