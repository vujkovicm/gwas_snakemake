args <- commandArgs(trailingOnly = TRUE)

library('tidyr')

# import list of rsids or chr:pos
df   <- read.table(args[1], F, stringsAsFactors = F)

# if field start with 'chr' then its a chr:ps
if(substr(df$V1[1], 1, 3) == "chr")
{
        x     = separate(df, V1, c("chr", "pos"), sep = ":")
        x$chr = gsub("chr", "", x$chr)
        write.table(x, paste(args[1], ".tmp", sep = ""), sep = "\t", row.names = F, col.names = F, quote = F)
}

# if field doesn't start with 'chr' then it is an rsid
if(substr(df$V1[1], 1, 3) != "chr")
{
        write.table(df$V1, paste(args[1], ".tmp", sep = ""), sep = "\t", row.names = F, col.names = F, quote = F)
}
