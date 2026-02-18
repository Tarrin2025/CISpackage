
#' run_coloc
#'
#' This function runs the coloc.abf() function from the R package for a GWAS list and immune cell eQTL dataset:
#'
#'
#' @param gwas_list list of Gwas data (including snp, beta, varbeta)
#' @param eqtl_list list containing eQTL data (including snp,beta, varbeta)
#' @return The PP0-PP4 values for each Gwas-eqtl signal
#' @export
run_coloc<- function(gwas_list, eqtl_list){
  # coloc::check_dataset(gwas_list)
  # coloc::check_dataset(eqtl_list)
  res <- coloc::coloc.abf(gwas_list,eqtl_list)
  return(res$summary)
}



