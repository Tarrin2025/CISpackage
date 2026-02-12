source("R/colocalization.R")
library(coloc)

gwas <- read.table("/Users/tarrindewberry/Desktop/CISpackage/Gwas_small.tsv", header = TRUE)
bcell <- read.table("/Users/tarrindewberry/Desktop/CISpackage/bcell_small.tsv", header = TRUE)
cd4_naive <- read.table("/Users/tarrindewberry/Desktop/CISpackage/cd4_naive_small.tsv", header = TRUE)
cd8_naive <- read.table("/Users/tarrindewberry/Desktop/CISpackage/cd8_naive_small.tsv", header = TRUE)

gwas_bcell <-overlap_snps(gwas, bcell)

gwas_cd4 <- overlap_snps(gwas,cd4_naive)
#there is no overlap for cd8
gwas_cd8 <- overlap_snps(gwas,cd8_naive)

#fix the function "create_input_list does not work yet
#list(gwas_list,bcell_list) <- create_input_list(gwas_bcell, type = "cc")

#For Bcell and Gwas
gwas_list <- list(snp = gwas_cd4$rsid, position = gwas_cd4$base_pair_location,
                     beta = gwas_cd4$beta.x, varbeta = (gwas_cd4$standard_error)^2,
                   pvalue = gwas_cd4$p_value, type = "cc")
cd4_list <- list(snp = gwas_cd4$rsid, position = gwas_cd4$position,
                  beta = gwas_cd4$beta.y, varbeta = (gwas_cd4$se)^2,
                  pvalue = gwas_cd4$pvalue, type = "cc")

res <- coloc.abf(gwas_list,cd4_list)

run_coloc(gwas_list,cd4_list)
