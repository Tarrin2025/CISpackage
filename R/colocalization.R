#' Functions for running coloc on GWAS and each eQTL datasets


overlap_snps <- function(gwas_file,eQTL_file){
  gwas_file <- gwas_file[!duplicated(gwas_file$rsid),]
  eQTL_file <- eQTL_file[!duplicated(eQTL_file$rsid),]
  gwas_eqtl_df <- merge(gwas_file,eQTL_file, by = "rsid") #edge cases (if different files have didnt SNP names columns, test if SNPS are the same, test if not the same)
  return(gwas_eqtl_df)
  }


create_input_list <- function(overlap, type = "cc"){
  gwas_input <- list(snp = overlap$rsid, position = overlap$location_Gwas,
                     beta = overlap$beta_Gwas, varbeta = (overlap$standard_error_Gwas)^2,
                     pvalue = overlap$p_value_Gwas, type = type)
  eQTL_input <- list(snp = overlap$rsid, position = overlap$location_eQTL,
                     beta = overlap$beta_eQTL, varbeta = (overlap$se_eQTL)^2,
                     pvalue = overlap$p_value_eQTL, type = type)
  return(return(list(gwas_list = gwas_input,eqtl_list = eqtl_input)))

}
#' Function: run_coloc
#' Description: Runs coloc.abf() for a GWAS dataset and a given immune cell eQTL dataset
#' Inputs:
#'   gwas_list - list containing GWAS data (beta, varbeta, SNP_ID)
#'   eqtl_list - list containing eQTL data (beta, varbeta, SNP_ID)
#' Outputs:
#'    PP0-PP4 values for each locus


#check edge cases for duplicated SNPS
run_coloc<- function(gwas_list, eqtl_list){
  # coloc::check_dataset(gwas_list)
  # coloc::check_dataset(eqtl_list)
  res <- coloc::coloc.abf(gwas_list,eqtl_list)
  return(res$summary)
}



