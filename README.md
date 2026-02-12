# CISpackage
 A tool to score and rank immune-specific cells in a given disease using a GWAS- eQTL Colocalization pipeline. The tool is used to identify what loci and immune cell types are strongly associated with the disease. The tool can help understand how genetic variation  affects expression in specific immune cells.

Input data: GWAS and eQTL files must include fields such as SNP ID, varbeta, beta, and type,p-values, position(optional). If both varbeta and beta can’t be provided, then p-values and MAF must be provided and are sufficient factors as well. 
Output Data: One data file with locus, immune cell type, PP4 value, CIS score, and ranked top immune cell types

