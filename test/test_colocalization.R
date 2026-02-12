source("R/colocalization.R")
library(testthat)

gwas_df <- data.frame(
  rsid = c("rs1","rs2","rs3"),
  beta_gwas = c(0.5,0.1,0.2),
  standard_error_Gwas = c(0.03,0.02,0.01),
  location = c(100,200,300)
)
eqtl_df <- data.frame(
  rsid = c("rs1","rs4","rs2"),
  beta_eQTL = c(0.2,0.3,0.6),
  se_eQTL = c(0.02,0.03,0.04),
  location = c(100,300,400)
)

expect_overlap_df <- data.frame(
  rsid = c("rs1","rs2"),
  beta_gwas = c(0.5,0.1),
  standard_error_Gwas = c(0.03,0.02),
  location = c(100,200),
  beta_eQTL = c(0.2,0.6),
  se_eQTL = c(0.02,0.04),
  location = c(100,400)
)

usethis::use_testthat("the right number of snps are being returned",
                      {expect_true(identical(overlap_snps(gwas_df,eqtl_df),expect_overlap_df))})

