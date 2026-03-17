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
  gwas_input <- list(
    snp = overlap$rsid,
    position = overlap$base_pair_location,
    beta = overlap$beta.x,
    varbeta = (overlap$standard_error)^2,
    pvalue = overlap$p_value,
    MAF = overlap$maf,
    N = overlap$N_effective,
    type = type)
  eqtl_input <- list(
    snp = overlap$rsid,
    position = overlap$base_pair_location, #edited to fix by SC --was causing an error
    beta = overlap$beta.y,
    varbeta = (overlap$se)^2,
    pvalue = overlap$pvalue,
    MAF =overlap$maf,
    N = overlap$N_effective,
    type = type)
  return(list(gwas_list = gwas_input, eqtl_list = eqtl_input))

}

#'#'run_coloc_pipeline (Sydney Clark HW3)
#'
#' This function runs the coloc.abf() function from the R package for a GWAS list
#' and immune cell eQTL dataset and returns the pp4 value for that given locus
#' and immune cell type.
#'
#' @param gwas_file GWAS dataframe (including rsid, beta, standard_error, p_value,
#'                   base_pair_location)
#' @param eQTL_file eQTL dataframe (including rsid, beta, se, pvalue,
#'                   base_pair_location)
#' @param cell_type Character string naming the immune cell type
#'                  (what will be included in the resulting dataframe, ex. "CD4 naive")
#' @param type data type passed to coloc: either 'cc' (case-control) or 'quant'
#' @return Dataframe of immune cell type, snp variants, pp4 value (from coloc result)
#' @export
#'
run_coloc_pipeline<- function(gwas_file, eqtl_file, cell_type, type){
  #Validate function inputs
  #make sure cell_type is of type character and contains content
  if(!is.character(cell_type) || nchar(trimws(cell_type)) == 0) {
    stop("'cell_type' has to be a non-empty character string.")
  }
  #make sure type is either cc or quant
  if(!type %in% c("cc", "quant")){
    stop("'type' can only be 'cc' or 'quant'.")
  }

  #overlap eQTL and GWAS dataframes
  overlap_dataframe <- overlap_snps(gwas_file, eqtl_file)

    #validate that there were SNPs overlapping between GWAS and eQTL datasets
    if (nrow(overlap_dataframe) == 0){
      stop("No overlapping SNPS were found between GWAS and eQTL datasets")
    }

  #turn the overlap dataframes into two input lists
  inputs <- create_input_list(overlap_dataframe, type)
  gwas_list <- inputs$gwas_list
  eqtl_list <- inputs$eqtl_list

  #run coloc.abf() on the two input lists
  res <- coloc::coloc.abf(gwas_list, eqtl_list)

  #Create a new dataframe storing the immune cell type, snp variants, and pp4 values
  result_df <- data.frame(
    cell_type = cell_type,
    snp = overlap_dataframe$rsid,
    pp4 = as.numeric(res$summary["PP.H4.abf"]),
    stringsAsFactors = FALSE
  )
  return(result_df)
}

