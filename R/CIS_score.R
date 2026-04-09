
#'#'rank_cell
#'
#' This function ranks the immune cells by the pp4 value
#'
#' @param coloc_df a dataframe that contains the pp4 values from the coloc pipeline.
#' @return ranked dataframe
#' @export

rank_cell <- function(coloc_df){
  coloc_df$rank <- rank(-coloc_df$pp4, ties.method = "first")
  coloc_df$is_strong <- rank_df$pp4 >= 0.8
  #coloc_df <- coloc_df[order(coloc_df$pp4,]
  return(coloc_df)
}

#'#'compute_immune_score
#'
#' This function computes the cis score
#'
#' @param coloc dataframe including immunce cells and pp4 values from coloc function
#' @param type could be "cc" or "quant"
#' @return dataframe with CIS score
#' @export

compute_immune_score <- function(coloc_df){
  coloc_df <- coloc_df[order(-coloc_df$pp4)]
  topcell <- coloc_df[1,]$pp4
  secondcell <- coloc_df[2,]$pp4
  coloc_df$CisScore <- coloc_df$pp4 *(topcell- secondcell)
  return(coloc_df)
}


