# CISpackage
 A tool to score and rank immune-specific cells in a given disease using a GWAS- eQTL Colocalization pipeline. The tool is used to identify what loci and immune cell types are strongly associated with the disease. The tool can help understand how genetic variation  affects expression in specific immune cells.

# Input data:
GWAS and eQTL files must include fields such as SNP ID, varbeta, beta, and type,p-values, position(optional). If both varbeta and beta can’t be provided, then p-values and MAF must be provided and are sufficient factors as well. 
# Output Data: 
One data file with locus, immune cell type, PP4 value, CIS score, and ranked top immune cell types

# Example Data 
* Refer to the dataset file in the Design documents folder to see the example data.
EBI eQTL Catalog
In the development of this tool, I will use data from the EBI GWAS catalog and the EBI eQTL catalog. The sample data used to develop this tool is a subset of immune cell files from the eQTL Catalogue. I specifically use data from the Schmiedel_2018 paper ( in the eQTL Catalogue the study_id is QTS000026). Schmiedel_2018 paper is composed of 15 different immune cell types from the DICE ( Database of Immune Cell Expression, Expression quantitative trait loci (eQTLs) and Epigenomics). I specifically used files that had a quantification method of “ge,” meaning that it was developed using total gene-level expression.

I specifically used 3 immune cell types to develop this package: 
Bcell (QTD000474)
Cd4_naive T cell(QTD000479)
C48_naive T cell(QTD000489)

The Gwas and eQTL files are tsv (tab-separated values) with: 
Each row are the different SNPs
Each column is meta data about the SNPS (Ex. standard error, base pair location, etc.) 
The files are great for tool requirements because they are harmonized, having required columns like Beta, Varbeta, Standard Error, Pvalue, snps_IDs which are need to run the coloc.abf() function in R. 

# Tutorial
Refer to vignette folder for the demo/ tutorial od how to use this package and interpret the results. 
[The Tutorial](./vignettes/CIS_Tutorial.Rmd) shows you how to: 
1. Overlap SNPS between Gwas and each immune cell type eqtl files
2. Run Coloc Pipeline
3. Rank the Immune Cell Type
4. Intrepret these results
