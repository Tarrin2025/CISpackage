#Test cases for the overlap_SNPS function()
#Create mock gwas dataframe

gwas_df <- data.frame(
  rsid = c("rs1","rs2","rs3"),
  beta_gwas = c(0.5,0.1,0.2),
  standard_error_Gwas = c(0.03,0.02,0.01),
  location = c(100,200,300)
)

#Create a mock eQTL dataframe
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

usethis::use_testthat("only returns overlap SNPs",
                      {results <- overlap_snps(gwas_df, eqtl_df)
                      expect_equal(results$rsid,expect_overlap_df$rsid)})

test_that("removes duplicate rsids in gwas before merging", {
  gwas_dupes <- data.frame(
    rsid = c("rs1", "rs1", "rs2"),
    beta_gwas = c(0.5,0.1,0.2),
    standard_error_Gwas = c(0.03,0.02,0.01),
    location = c(100,200,300) )
  result <- overlap_snps(gwas_df, eqtl_df)
  expect_equal(result$rsid, "rs2")
})

test_that("removes duplicate rsids in eQTL before merging", {
  eqtl_dupes <- data.frame(
    rsid = c("rs2", "rs2", "rs5"),
    gene = c("GENE1", "GENE1_DUP", "GENE2"),
    stringsAsFactors = FALSE
  )
  result <- overlap_snps(gwas_dupes, eqtl_dupes)
  expect_equal(nrow(result), 2)
})

test_that("returns empty data frame when there is no overlap", {
  gwas_no_overlap <- data.frame(
    rsid = c("rs10", "rs11"),
    pval = c(0.01, 0.05),
    stringsAsFactors = FALSE
  )
  result <- overlap_snps(gwas_no_overlap, eqtl_df)
  expect_equal(nrow(result), 0)
})



