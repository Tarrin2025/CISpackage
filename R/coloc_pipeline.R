
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

create_input_list <- function(overlap){
  gwas_input <- list(
    snp = overlap$rsid,
    position = overlap$base_pair_location,
    beta = overlap$beta.x,
    varbeta = (overlap$standard_error)^2,
    pvalue = overlap$p_value,
    type = "cc",
    N = 152268,
    s = 0.194)
  eqtl_input <- list(
    snp = overlap$rsid,
    position = overlap$base_pair_location, #edited to fix by SC --was causing an error
    beta = overlap$beta.y,
    varbeta = (overlap$se)^2,
    pvalue = overlap$pvalue,
    type = "quant",
    N = 91,
    MAF = overlap$maf,
    sdY = 1)
  return(list(gwas_list = gwas_input, eqtl_list = eqtl_input))

}

#'#'run_coloc_pipeline (Sydney Clark HW3)
#'
#' This function runs the coloc.abf() function from the R package for a GWAS list
#' and immune cell eQTL dataset and returns the pp4 value for that given locus
#' and immune cell type.
#'
#' @param overlap_df dataframe (including rsid, beta, standard_error, p_value,
#'                   base_pair_location)
#' @param cell_type Character string naming the immune cell type
#'                  (what will be included in the resulting dataframe, ex. "CD4 naive")
#' @param type data type passed to coloc: either 'cc' (case-control) or 'quant'
#' @return Dataframe of immune cell type, snp variants, pp4 value (from coloc result)
#' @export
#'
run_coloc_pipeline<- function(overlap_df, cell){
  #Validate function inputs
  #make sure cell_type is of type character and contains content
  #if(!is.character(cell_type) || nchar(trimws(cell_type)) == 0) {
    #stop("'cell_type' has to be a non-empty character string.")
 # }
  #make sure type is either cc or quant
  #if(!type %in% c("cc", "quant")){
  #  stop("'type' can only be 'cc' or 'quant'.")
  #}



    #validate that there were SNPs overlapping between GWAS and eQTL datasets
    #if (nrow(overlap_dataframe) == 0){
      #stop("No overlapping SNPS were found between GWAS and eQTL datasets")
    #}

  #turn the overlap dataframes into two input lists
  inputs <- create_input_list(overlap_df)
  gwas_list <- inputs$gwas_list
  eqtl_list <- inputs$eqtl_list

  #run coloc.abf() on the two input lists
  res <- coloc::coloc.abf(gwas_list, eqtl_list)

  #Create a new dataframe storing the immune cell type, snp variants, and pp4 values
  result_df <- data.frame(
    cell_type = cell,
    pp4 = as.numeric(res$summary["PP.H4.abf"]),
    pp3 = as.numeric(res$summary["PP.H3.abf"]),
   stringsAsFactors = FALSE
  )
  return(result_df)
}

#'#'run_coloc_pipeline_all
#'
#' This function runs the coloc.abf() function from the R package for a GWAS list
#' and multiple immune cell eQTL dataset and returns the pp4 value for that given locus
#' and immune cell type.
#'
#' @param overlap_list dataframe (including rsid, beta, standard_error, p_value,
#'                   base_pair_location)
#' @param cell_type Character string naming the immune cell type
#'                  (what will be included in the resulting dataframe, ex. "CD4 naive")
#' @return Dataframe of immune cell type and pp4 value (from coloc result)
#' @export
#'

run_coloc_pipeline_all <- function(overlap_list) {
  result_list <- list()
  for (cell in names(overlap_list)) {
    message("Running coloc for: ", cell)
      result_list[[cell]] <- run_coloc_pipeline(overlap_list[[cell]], cell)
  }
  return(do.call(rbind,result_list))
}


#'#'rank_cell
#'
#' This function ranks the resulting run_coloc_pipeline_all() function for all immune cell types.
#'
#' @param result_list list of results from the run_coloc_pipeline_all()
#' @return Dataframe of ranking the immune cell type by the highest pp4 value (from coloc result)
#' @export
#'

rank_cell <- function(result_list){
  result_df <- as.data.frame(result_list)
  result_df <- result_df[order(-result_df$pp4),]
  return(result_df)
}
