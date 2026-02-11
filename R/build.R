#source("R/colocalization.R")
#install.packages("coloc")
#library(coloc)

# gwas <- list(
#   beta = c(-0.2, -0.1),
#   varbeta = c(0.04, 0.02),
#   snp = c("rs1", "rs2"),
#   position = c(100, 101),
#   N = 100,
#   type = "cc",
#   sdY = 1
# )
#
# # Minimal test eQTL dataset
# bcell_eqtl <- list(
#   beta = c(0.25, 0.12),
#   varbeta = c(0.05, 0.03),
#   snp = c("rs1", "rs2"),
#   position = c(100, 101),
#   N = 500,
#   type = "cc",
#   sdY = 1
# )
#
# # Run coloc
# results <- run_coloc(gwas,bcell_eqtl)
#
# print(results)
#
