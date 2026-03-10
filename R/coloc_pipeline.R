#'#'overlap_snps
#'
#' This function merge the Gwas dataframe and eQTL dataframe by SNP_id.
#'
#' @param gwas_file Gwas file (including snp, beta, varbeta)
#' @param eqtl_file eQTL data (including snp,beta, varbeta)
#' @return A dataframe that containes the shared SNPS between GWAS and eQTL
#'  (as well as the GWAS and eQTl contents for those given SNPs)
#' @export
overlap_snps <- function(gwas_file,eQTL_file){
  if (any(duplicated(gwas_file$rsid)) == TRUE) {
    gwas_file <- gwas_file[!duplicated(gwas_file$rsid),]
  }
  if (any(duplicated(eQTL_file$rsid)) ==TRUE) {
    eQTL_file <- eQTL_file[!duplicated(eQTL_file$rsid),]
  }
  if (nrow(gwas_file) == 0 || nrow(eQTL_file) == 0) {
    stop("Files are empty")
  }
  gwas_eqtl_df <- merge(gwas_file,eQTL_file, by = "rsid")
  gwas_eqtl_df <- gwas_eqtl_df[order(gwas_eqtl_df$rsid),]
  return(gwas_eqtl_df)
}

#'#'create_input_list
#'
#' This function separates the overlap data frame that has both GWAS and eQTL content
#' and converts them to two separate input_list(Gwas input list and eQTL input list)
#' for the run_coloc function.
#'
#' @param gwas_file overlap dataset with Gwas and eQTL content
#' @param type could be "cc" or "quant"
#' @return a Gwas input list and eQTL input list that has required content for
#' coloc package
#' @export

create_input_list <- function(overlap, type = "cc"){
  gwas_input <- list(snp = overlap$rsid, position = overlap$base_pair_location,
                     beta = overlap$beta.x, varbeta = (overlap$standard_error)^2,
                     pvalue = overlap$p_value, type = type)
  eqtl_input <- list(snp = overlap$rsid, position = overlap$position,
                     beta = overlap$beta.y, varbeta = (overlap$se)^2,
                     pvalue = overlap$pvalue, type = type)
  return(list(gwas_list = gwas_input,eqtl_list = eqtl_input))

}

#'#'run_coloc
#'
#' Description:
#'
#' @param gwas_list
#' @param eQTLlist
#' @return Dataframe of gwas_locus, immune cell, pp4 value (from coloc result)
#' @export

