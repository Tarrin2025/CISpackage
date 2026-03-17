# unit tests for run_coloc_pipeline (Sydney Clark HW3)

#run using testthat::test_file("/test_run_coloc_pipeline.R") (update file path)
library(testthat)

#-- Make mock dataframes --
#make mock gwas dataframe (similar to that in test_overlap.R, but changed some to match actual data)
gwas_df <- data.frame(
  rsid = c("rs1", "rs2", "rs3"),
  chromosome = c("1", "1", "1"),
  base_pair_location = c(100,200,300),
  effect_allele = c("a", "t", "c"),
  other_allele = c("g", "c", "g"),
  beta = c(0.5,0.1,0.2),
  standard_error = c(0.03,0.02,0.01),
  p_value = c(0.04, 0.2, 0.09),
  N_effective = c(47000, 50000, 43000),
  stringsAsFactors = FALSE
)

#make mock eQTL dataframe (based on what is in actual data)
eQTL_df <- data.frame(
  molecular_trait_id = c("ENSG00000176022", "ENSG00000189339", "ENSG00000224051"),
  chromosome = c("1", "1", "1"),
  position = c("758351","758443","769828"),
  ref = c("A", "G", "A"),
  alt = c("G", "C", "G"),
  variant = c("chr1_758351_A_G", "chr1_758443_G_C", "chr1_761275_A_G"),
  ma_samples = c(13, 6, 8),
  maf = c(0.073, 0.084, 0.034),
  pvalue = c(0.6, 0.03, 0.1),
  beta = c(0.09, -0.3, 0.8),
  se = c(0.2, 0.35, 0.09),
  type = c("SNP", "SNP", "SNP"),
  ac = c(14, 16, 6),
  an = c(178, 178, 178),
  r2 = c(0.44, 0.50, 0.81),
  molecular_trait_object_id = c("ENSG00000176022", "ENSG00000189339", "ENSG00000224051"),
  gene_id = c("ENSG00000176022", "ENSG00000189339", "ENSG00000224051"),
  median_tpm = c(13.8, 7.5, 82.2),
  rsid = c("rs1", "rs2", "rs3")
)

#-- Tests --

#test that output is a dataframe that contains the right columns
test_that("run_coloc_pipeline returns a dataframe with the correct columns", {
  result <- run_coloc_pipeline(
    gwas_file = gwas_df, eqtl_file = eQTL_df, cell_type = "test_cell", type = "cc")
  expect_s3_class(result, "data.frame")
  expect_true(all(c("cell_type", "snp", "pp4") %in% colnames(result)))
})

#test that output has one row for each overlapping SNP
test_that("run_coloc_pipeline returns one row per overlapping SNP", {
  result <- run_coloc_pipeline(
    gwas_file = gwas_df, eqtl_file = eQTL_df, cell_type = "test_cell", type = "cc")
  expect_equal(nrow(result), 3) #there should be 3 rows since there are 3 overlapping SNPs
})

#test that cell_type in the cell_type column of the output is repeated for every row
test_that("run_coloc_pipeline returns a dataframe with cell_type repeated for every row in the cell_type column", {
  result <- run_coloc_pipeline(
    gwas_file = gwas_df, eqtl_file = eQTL_df, cell_type = "test_cell", type = "cc")
  expect_true(all(result$cell_type == "test_cell"))
})

#test that PP4 is numeric and bounded in the output
test_that("run_coloc_pipeline returns a dataframe with PP4 values that are numeric and between 0 and 1", {
  result <- run_coloc_pipeline(
    gwas_file = gwas_df, eqtl_file = eQTL_df, cell_type = "test_cell", type = "cc")
  expect_type(result$pp4, "double")
  expect_true(all(result$pp4 >= 0 & result$pp4 <= 1))
})

#test that run_coloc_pipeline returns an error if cell_type is empty
test_that("run_coloc_pipeline errors with empty cell_type", {
  expect_error(
    run_coloc_pipeline(
      gwas_file = gwas_df, eqtl_file = eQTL_df, cell_type = "", type = "cc"),
    "'cell_type' has to be a non-empty character string.")
})

#test that run_coloc_pipeline returns an error when there aren't any overlapping SNPs
test_that("run_coloc_pipeline errors when no SNPs overlap", {
  gwas_no_overlap <- gwas_df
  gwas_no_overlap$rsid <- c("rs100", "rs101", "rs102") #now they don't match eQTL
  expect_error(run_coloc_pipeline(
    gwas_file = gwas_no_overlap, eqtl_file = eQTL_df, cell_type = "test_cell", type = "cc"),
    "No overlapping SNPS were found between GWAS and eQTL datasets")
})

#test that run_coloc_pipeline returns an error when an invalid type argument is provided
test_that("run_coloc_pipeline errors with invalid type", {
  expect_error(
    run_coloc_pipeline(
      gwas_file = gwas_df, eqtl_file = eQTL_df, cell_type = "test_cell", type = "wrong"),
    "'type' can only be 'cc' or 'quant'."
  )
})

#-- Print test summary --
cat("\n--------------------------------------\n")
cat("Unit tests for run_coloc_pipeline complete\n")
cat("\n--------------------------------------\n")
