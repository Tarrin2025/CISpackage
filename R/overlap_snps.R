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
    message(paste("After removing duplicates Dataset 1 has",nrow(gwas_file),"snps"))
  }
  if (any(duplicated(eQTL_file$rsid)) ==TRUE) {
    eQTL_file <- eQTL_file[!duplicated(eQTL_file$rsid),]
    message(paste("After removing duplicates Dataset 2 has",nrow(eQTL_file),"snps"))
  }
  if (nrow(gwas_file) == 0 || nrow(eQTL_file) == 0) {
    stop("Files are empty")
  }
  gwas_eqtl_df <- merge(gwas_file,eQTL_file, by = "rsid")
  message(paste("Overlaping Dataset 1 and Dataset 2 has ",nrow(gwas_eqtl_df),"snps"))
  gwas_eqtl_df <- gwas_eqtl_df[order(gwas_eqtl_df$rsid),]
  return(gwas_eqtl_df)
}

#'#'overlap_snps_all
#'
#' This function merge the Gwas dataframe and each eQTL dataframe by SNP_id.
#'
#' @param gwas_file Gwas file (including snp, beta, varbeta)
#' @param folder multiple pathways of an eQTL data (including snp,beta, varbeta)
#' @return A list of dataframes that contains the shared SNPS between GWAS and each eQTL file
#'  (as well as the GWAS and eQTl contents for those given SNPs)
#' @export
overlap_snps_all <- function(gwas,cell_type_list){
  overlap_list <- list()
  for (cell in names(cell_type_list)) {
    message(paste("Overlap snps for", cell))
    overlap_df <- overlap_snps(gwas,cell_type_list[[cell]])
    overlap_list[[cell]] <- overlap_df

  }
  return(overlap_list)
}
