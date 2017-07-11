args <- commandArgs(trailingOnly = TRUE)

library('tidyr')
df   <- read.table(args[1], F)

if(grep("chr", df$V1[1]) == 1)
{
        write.table(df$V1, paste(args[1], ".rs.tmp", sep = ""), sep = "\t", row.names = F, col.names = F, quote = F)
}
else
{
        df     = separate(df, V1, c("chr", "pos"), sep = ":")
        df$chr = gsub("chr", "", df$chr)
        write.table(df, paste(args[1], ".loc.tmp", sep = ""), sep = "\t", row.names = F, col.names = F, quote = F)
}
