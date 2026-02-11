**CIS – Colocalized Immune-Cell Score** 

**Activity 1: Download & Format Datasets**

* Task 1.1: Download GWAS Dataset  
  * Description: Download GWAS summary statistics for ALS from the [EBI Catalog](https://www.ebi.ac.uk/gwas/docs/methods/summary-statistics)  
    * Output: Dataframe containing GWAS summary statistics   
  * Task 1.2: Find multiple eQTL immune-cell types datasets  
    * Description: Download each immune-specific cell eQTL file from the DICE Database  
    * Output: A data frame for each immune cell type containing eQTL summary statistics  
  * Task 1.3: Validate Input files  
    * Description: Load the GWAS and eQTL files into R as dataframes, ensuring that fields such as SNP ID, effect size, beta, position are present and non-empty.  
    * Output: Validated GWAS and eQTL data frames

**Activity 2: Overlapping GWAS & eQTL Immune Cell Datasets**

* Task 2.1: Merge GWAS & eQTL datasets  
  * Description: Use the function *merge()* to overlap the GWAS and eQTL datasets by SNP ID  
    * Output: One dataframe containing shared SNPS between GWAS and eQTL  
  * Task 2.2: Create coloc input lists  
    * Description: From the overlap dataset, create separate input lists for GWAS and each immune cell type. Input the values that are required for *coloc.abf()* function, including beta, varbeta, SNP\_ID, position.   
    * Output: Input list for GWAS and each immune cell type  
  * Task 2.3: Validate coloc input  
    * Description: Run *checkdataset()* from the coloc R package to ensure the list meet the requirements for the *coloc.abf()* function  
    * Output: Validated input list for GWAS and each immune cell type 

**Activity 3: Colocalization** 

* Task 3.1: Run Colocalization   
  * Description: Run *coloc.abf()* for each GWAS locus against each immune-specific eQTL list to estimate posterior probabilities of shared causal variants  
    * Output: Colocalization results for each locus-cell type pair, containing PP0-PP4 values  
  * Task 3.2: Compile locus-level Colocalization  
    * Description: Combine colocalization outputs into one table containing GWAS locus, immune cell type, and PP4 values   
    * Output:CSV file with GWAS loci, immune cell type and PP4 values

**Activity 4: Creating CIS Scores**

* Task 4.1:Normalize Colocalization  
  * Description: Normalize PP4 values across immune cell types for each GWAS locus (makes sure the weights sum to 1).  
    * Output: Table of normalized weights for each locus-immune cell pair  
        
  * Task 4.2: Aggregating Scores by Immune cell type   
    * Description: Sum the locus-level normalized weights across GWAS loci to create a colocalization-immune score(CIS) for each immune cell type.  
    * Output: Table of aggregated scores CIS for each immune cell   
  * Task 4.3: Rank Immune Cell Types  
    * Description: Rank each immune cell type, using the CIS ranking score. Create a table that includes the ranking, immune cell type, and GWAS loci.   
    * Output: Ranked tables of immune cell types. 