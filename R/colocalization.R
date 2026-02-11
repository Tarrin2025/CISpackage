# Functions for running coloc on GWAS and eQTL datasets

# Function: run_coloc
# Description: Runs coloc.abf() for a GWAS dataset and a given immune cell eQTL dataset
# Inputs:
#   gwas_list - list containing GWAS data (beta, varbeta, SNP_ID)
#   eqtl_list - list containing eQTL data (beta, varbeta, SNP_ID)
# Outputs:
#    PP0-PP4 values for each locus
#install.packages("coloc")


run_coloc<- function(gwas_list, eqtl_list){
  coloc::check_dataset(gwas_list)
  coloc::check_dataset(eqtl_list)
  res <- coloc::abf(gwas_list,eqtl_list)
  return(res$summary)
}



