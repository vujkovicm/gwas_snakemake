library('yaml')

# config.yaml contains the phenotypes and covariates in the proper order
yml <- yaml.load_file("/project/saleheenlab/snakemake/config/config.yaml")

# pca contains principal components, and the patient order is according to the genotype files
pca <- read.csv('/project/saleheenlab/snakemake/pheno/PROMIS_WEseq_10.5k_PCA1-10.csv', T, stringsAsFactors = F)

# phenotype information collected from questionnaire (contains both GWAS1 and GWAS2 cohorts)
phe <- read.csv('/project/saleheenlab/snakemake/pheno/PROMIS_Universal_40k_PhenoMarkers.tab.gz', as.is = T, header = T, sep = "\t", comment.char = "", quote = "")
phe <- phe[which(is.na(phe$WES_PROMISID) == F), ]

# select the
tab <- phe[, c("subjectid", "WES_PROMISID")]
tab$fatid <- 0
tab$matid <- 0

for(i in 1:length(yml$wesAnnoPhe))
{
        tab <- cbind.data.frame(tab, phe[, names(yml$wesAnnoPhe)[i]])
        colnames(tab)[i + 4] <- yml$wesAnnoPhe[[i]][1]
        if(length(yml$wesAnnoPhe[[i]]) == 3)
        {
                tmp <- tab[, i + 4]
                tmp <- ifelse(tab[,i + 4]  == yml$wesAnnoPhe[[i]][3], '1', ifelse(tab[,i + 4] == "", NA, '2'))
                tab[,i + 4] <- tmp
        }
}

# remove duplicate entries from phenotype file
tab <- unique(tab)

# merge PCA with PHENOTYPES
tab <- merge(tab, pca, by.x = "WES_PROMISID", by.y = "IND_ID", all.x = T)
tab$subjectid <- tab$WES_PROMISID

validvarname=any
colnames(tab)[ 2] <- "fid"
colnames(tab)[ 1] <- "iid"
names(tab)[names(tab) == "LCSET.Min"] <- "BATCH"

# reorganize table to fit PED format
refcols = c("fid", "iid", "fatid", "matid", "SEX")
tab <- tab[, c(refcols, setdiff(names(tab), refcols))]

# create dummy variables
tab$BATCH       <- substr(tab$BATCH,(nchar(tab$BATCH) + 1) - 4, nchar(tab$BATCH))
tab$BATCH       <- as.factor(tab$BATCH)
dummyBatch      <- model.matrix(~ BATCH, data = tab)

# merge phenotype file with batch dummies
tab <- cbind(tab, dummyBatch[, 2:ncol(dummyBatch)])

# seperate the outcome data from covariates
phe.list   <- c(yml$wesPhenoLin, yml$wesPhenoLog)
phe.prefix <- c("fid", "iid", "fatid", "matid", "SEX")

tab.phe <- tab[, c(phe.prefix, phe.list)]
tab.cov <- tab[, -which(names(tab) %in% phe.list)]

# export
write.table(tab.phe, "/project/saleheenlab/snakemake/pheno/WEseq10.5kPhenoCov.rvtest.pheno", sep = "\t", col.names = T, row.names = F, quote = F)
write.table(tab.cov, "/project/saleheenlab/snakemake/pheno/WEseq10.5kPhenoCov.rvtest.covar", sep = "\t", col.names = T, row.names = F, quote = F)
