args <- commandArgs(trailingOnly = TRUE)
# args = c("LDL", "1", "5e-8")
# create seperate script for metal output metal (other script, becuase output from metal is different

# p-value threshold
threshold <- as.numeric(args[3])
dir = "/project/saleheenlab/snakemake/"

# For MAF > .05
df <- read.table(paste(dir, "out/PROMIS/imputed/summary/", args[1], "/", args[1], "_gwas", args[2], ".snptest.filtered.out", sep = ""), sep = " ",  T, stringsAsFactors = F, fill = T)

df.sig <- df[(df$frequentist_add_pvalue < threshold), ]           # select rows that meet p-value threshold

# init sentinel SNPs
gen.hits <- df.sig[NULL, ]

# columns
# "filename", "rsid", "index", "position", "alleleA", "alleleB", "average_maximum_posterior_call", "info", "all_total", "all_maf", "missing_data_proportion", "cohort_1_hwe", "frequentist_add_pvalue", "frequentist_add_info", "frequentist_add_beta_1", "frequentist_add_se_1"

# find top snp
for (i in 1:22)
{
        # init chr
        chr <- df.sig[which(df.sig$chromosome == i), ]
        if (nrow(chr) > 0)
        {
                current  <- chr$position[1]     # set first position as current position
                top.hits <- chr[NULL, ]         # create empty list to store top loci
                for (j in 1:length(chr))
                {
                        # if distance btw current snp and previous top snp is greater than distance threshold,
                        # push current snp into a list of top SNPs
                        if ((j == 1) | ((chr$position[j] - current) > 1e6 ))
                        {
                                top.hits <- rbind(top.hits, chr[j, ])
                                current  <- chr$position[j]
                        }
                        else if (chr[which(chr$position = j), "frequentist_add_pvalue"] < chr[which(chr$position == current), "frequentist_add_pvalue"])
                        {
                                top.hits <- rbind(top.hits, chr[j, ])
                                current <- chr$position[j]
                        }
                }
                # merge chromosome top lists into 1
                gen.hits <- c(gen.hits, unique(top.hits))
        }
}


gen.hits <- unlist(gen.hits$SNP)

for (i in 1:length(gen.hits))
{
        cmd <- paste("bsub /project/saleheenlab/software/LOCUSZOOM/locuszoom/bin/locuszoom --metal",
                        paste(dir, "out/PROMIS/imputed/summary/", args[1], "/", args[1], "_gwas", args[2], ".snptest.filtered.out", sep = ""),
                "--delim space --refsnp",
                gen.hits[i],
                "--flank 250kb --pop EUR --build hg19 --source 1000G_March2012 --cache None --plotonly --no-date --markercol SNP --pvalcol frequentist_add_pvalue",
                sep = " ")
        system(cmd)
}
