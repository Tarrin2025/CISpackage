#'#'filter_nearby_snps_eqtl
#'
#' This function filters the whole genome data set to a specific target region to colocalize.
#'
#' @param file_path A string of the eqtl file_path
#' @param snp_id A string of the target SNP
#' @param region_window how far from the target snps we want to include in the coloc pipeline
#' @return A dataframe that contains the target SNPS and the SNPS with in the set region window
#' @export
filter_nearby_snps_eqtl <- function(df_eqtl,snp_id,region_window = 50000){
  target_snp <- df_eqtl[which(df_eqtl$rsid == snp_id),]
  message(paste("Found",snp_id, "in the dataframe"))
  target_snp_pos <- target_snp$position #position 27563870
  message(paste("The position of",snp_id,"is", target_snp_pos))
  target_snp_chr <- target_snp$chromosome #9
  message(paste("The chromosome of",snp_id,"is", target_snp_chr))
  df_nearby_snps_eqtl <- df_eqtl[
    df_eqtl$chromosome == target_snp_chr  &
      df_eqtl$position >= (target_snp_pos - region_window) &
      df_eqtl$position <= (target_snp_pos + region_window),
  ]

  message(paste("The number of nearby snps is",nrow(df_nearby_snps_eqtl)))
  return(df_nearby_snps_eqtl)
}

#'#'filter_nearby_snps_gwas
#'
#' This function filters the whole genome data set to a specific target region to colocalize.
#'
#' @param file_path A string of the gwas file_path
#' @param snp_id A string of the target SNP
#' @param region_window how far from the target snps we want to include in the coloc pipeline
#' @return A dataframe that contains the target SNPS and the SNPS with in the set region window
#' @export
filter_nearby_snps_gwas <- function(df_gwas,snp_id,region_window = 50000){
  target_snp <- df_gwas[which(df_gwas$rsid == snp_id),]
  message(paste("Found",snp_id, "in the dataframe"))
  target_snp_pos <- target_snp$base_pair_location #position 27563870
  message(paste("The position of",snp_id,"is", target_snp_pos))
  target_snp_chr <- target_snp$chromosome #9
  message(paste("The chromosome of",snp_id,"is", target_snp_chr))
  df_nearby_snps_gwas <- df_gwas[
    df_gwas$chromosome == target_snp_chr  &
      df_gwas$base_pair_location >= (target_snp_pos - region_window) &
      df_gwas$base_pair_location <= (target_snp_pos + region_window),
  ]

  message(paste("The number of nearby snps is",nrow(df_nearby_snps_gwas)))
  return(df_nearby_snps_gwas)
}
