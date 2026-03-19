# Work Breakdown Structure (WBS)

## **CIS – Colocalized Immune-Cell Score** 

## Activity1: Project Setup 

Goal: Create github repository and design documentation. 

:ballot_box_with_check: Task 1.1:  Github Repository Setup  
  * Description : Initialize Github repository with .gitignore, README, and license.  
    * Output: Functional Github repository   
 [x] Task 1.2:  Create Design Documents :S  
    * Description: Create a software Requirement Specification (SRS), Work Breakdown Structure (WBS), and Design Document Specification (DDS) documents  
    * Output: Design documents are created and included in the github repository

## Activity 2: Data Preparation & Subsetting 

Goal: Download genome-wide association studies (GWAS) and expression quantitative trait loci (eQTL) summary statistic files from public databases. Load downloaded files into the package. 

[x] Task 2.1: Download GWAS Dataset from [EBI Catalog](https://www.ebi.ac.uk/gwas/docs/methods/summary-statistics)  
  * Description: Download the GWAS summary statistics for Amyotrophic lateral sclerosis (ALS) from the [EBI Catalog](https://www.ebi.ac.uk/gwas/docs/methods/summary-statistics). Ensure that the GWAS file is a harmonized summary statistic that has the following columns: snp ids, beta, varbeta (or standard error), pvalues, location.  
    * Output: GWAS summary statistics file  
[x] Task 2.2:  Download eQTL Dataset from the [eQTL Catalogue](https://www.ebi.ac.uk/eqtl/Data_access/)   
    * Description: Download the eQTL summary statistics for desired immune cell type from the  [eQTL Catalogue](https://www.ebi.ac.uk/eqtl/Data_access/). Ensure that the eQTL file is a harmonized summary statistic that has the following columns: snp ids, beta, varbeta (or standard error), pvalues, location.  
    * Output: One or more immune specific cell type eQTL files  
 [x] Task 2.3 Subsetting Data for Tool Development  
    * Description: Subset the GWAS and eQTL files to a smaller sample size for the tools development.   
    * Output: Reduced GWAS and eQTL datasets that meet the requirements for the tool.   
  [x] Task 2.4: Create a *check\_data()* function  
    * Description: Create a function that validates the GWAS and eQTL files. It will check for empty files, non-dataframe inputs, and missing required columns. Include unit tests for the function.  
    * Output: Validated GWAS and eQTL dataframes inputs

## Activity 3: Colocalization Pipeline

Goal: Implement and validate colocalization pipeline.

[x] Task 3.1: Create an *overlap\_snps()* function  
  * Description: Use the R function *merge()* to overlap the GWAS and eQTL datasets by snp\_id.   
    * Create a unit test for validation to ensure that the snps returned are shared between the GWAS and eQTL file. Also check that the function can handle snp duplicates.  
    * Output: One dataframe containing shared snps between GWAS and eQTL as well as all the GWAS and eQTL content from both dataframes.   
[x] Task 3.2: Create a *create\_coloc\_input() function*  
    * Description: Convert a dataframe that is the overlap of the shared snps from both the GWAS and eQTL file into separate input lists for *coloc.abf()* function. The input list should have arguments including beta, varbeta, SNP\_ID, position.   
    * Output: Input list for GWAS and each immune cell type  
[x] Task 3.3: Validate *create\_coloc\_input()* function  
    * Description: Run *checkdataset()* from the coloc R package to ensure the list meets the requirements for the *coloc.abf()* function. Ensure that the values for beta , varbeta (or standard error), location are all numeric. Ensure that snp ids are characters.   
    * Output: Unitest and validated input list for GWAS and each immune cell type   
[x] Task 3.4:Create a *run\_coloc\_pipeline()* function  
    * Description: Run *coloc.abf()* for each GWAS locus against each immune-specific eQTL list to estimate posterior probabilities of shared causal variants. Combine the colocalization outputs from the function into a table containing the GWAS locus, immune cell type and PP4 values.   
    * Output: CSV file with Gwas loci, immune cell type and PP4 values. 

 [x] Task 3.5: Validate run\_coloc\_pipeline()  
    * Description: Create unit test for run\_coloc\_pipeline()  
    * Output: Unitest and validated colocalization pipeline. 

## Activity 4: Immune Cell type Scoring & Aggregation

Goal: Generate CIS scores and rank immune cell types.  
[ ] Task 4.1: Create *norm\_coloc ()* function  
  * Description: Normalize PP4 values across immune cell types for each GWAS locus (makes sure the weights sum to 1).  
    * Output: Table of normalized weights for each locus-immune cell pair  
  * Task 4.2: Validate *norm\_coloc()* function  
    * Description: Create unit test for the norm\_coloc() function  
    * Output: Unit test for the norm\_coloc() function

  * Task 4.3: Create *aggregate\_score()* function  
    * Description: Sum the locus-level normalized weights across GWAS loci to create a colocalization-immune score(CIS) for each immune cell type.  
    * Output: Table of aggregated scores CIS for each immune cell   
  * Task 4.4: Validate *aggregate\_score()* function  
    * Description: Create unit test for the norm\_coloc() function  
    * Output: Unit test and Validated aggregate\_score() function  
        
  * Task 4.5: Create *rank\_cell function(*) function  
    * Description: Rank each immune cell type, using the CIS ranking score. Create a table that includes the ranking, immune cell type, and GWAS loci.   
    * Output: Ranked tables of immune cell types.   
  * Task 4.6: Validate the *rank\_cell*() function  
    * Description: Create Unit test for the rank\_cell() function.   
      * Output: Unit test and validated rank\_cell() function

## Activity 5: Documentation & Reporting

Goal: Ensuring my github repo is user friendly. 

* Task 5.1: Update Design Documents  
  * Description: Update SRS, DDS, and WBS documents.  
    * Output: Complete and well-documented project documentation.  
  * Task 5.2 : Create demo for package  
    * Description: Create a step-by-step tutorial of my tool.  
    * Output: User tutorial  
  * Task 5.3: Demonstration  
    * Description: Use example datasets to run the tool.  
    * Output: Reproducible workflow

## Activity 6 : Run on Larger Dataset 

Goal: Ensure that tool can work on large datasets.

* Task 6.1: Run this package on a large-scale dataset.    
  * Description: Run the tool on a full-scale dataset. Measure its runtime and memory usage.  
    * Output: Large scale CIS results and performance metrics of the tool. 

## 

**AI Disclaimer:**   
Artificial Intelligence tools (ChatGPT and Claude) were used to assist with document organization and structure. AI was also used for spelling and grammar checks. 
