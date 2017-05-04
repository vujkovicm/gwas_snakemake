args <- commandArgs(trailingOnly = TRUE)

library('yaml')

# config.yaml contains the phenotypes and covariates in the proper order
yml <- yaml.load_file("/project/saleheenlab/snakemake/config/config.yaml")

# pca contains principal components, and the patient order is according to the genotype files
pca <- read.table(paste('/project/saleheenlab/original_data/PROMIS_GWAS12_1kG_phase3_imputed/GWAS', args[1], '/promis_gwas', args[1], '_ordered_id_pcs.tab', sep = ""), T, sep = "\t", stringsAsFactors = F)

# phenotype information collected from questionnaire (contains both GWAS1 and GWAS2 cohorts)
phe <- read.csv('/project/saleheenlab/original_data/PROMIS_SAMPLE_FILES_CLEANED_03182015/promis_questionaire_data_for_seq_full.csv', T, stringsAsFactors = F)

# merge PCA with PHENOTYPES
tab <- merge(pca, phe, by = "subjectid", all.x = T)

# insert empty row for phenotype meta-info
tab <- rbind(NA, tab)

# tranform all values in data.frame to character
tab <- data.frame(lapply(tab, as.character), stringsAsFactors = FALSE)

# create .sample file
sam <- tab[ , c("ID_1","ID_2", "line")]
sam[1, 1:3] <- "0"

# add covariates and phenotypes
for(i in 1:length(yml$dotSample))
{
        sam <- cbind.data.frame(sam, tab[, names(yml$dotSample)[i]], stringsAsFactors = F)
        colnames(sam)[i + 3] <- yml$dotSample[[i]][1]
        sam[1, i + 3] <- yml$dotSample[[i]][2]
        # recode binary (categoric) variable (taking into account missings)
        if(sam[1, i + 3] %in% c('B', 'D'))
        {
                tmp <- sam[1, i + 3]
                sam[i + 3]    <- ifelse(sam[i + 3]  == yml$dotSample[[i]][3], '0', ifelse(sam[i + 3] == "", NA, '1'))
                sam[1, i + 3] <- tmp
        }
}

# sort by appropriate patient order (concordant with genotype file)
sam <- sam[order(as.numeric(sam$line)), ]

# convert line (patient order) to MISSING variable and set to 0
colnames(sam)[3] <- "MISSING"
sam$MISSING <- "0"

# export
write.table(sam, paste("/project/saleheenlab/snakemake/output/PROMIS/imputed/GWAS", args[1], "/promis_gwas", args[1], ".sample", sep = ""), sep = " ", col.names = T, row.names = F, quote = F)

