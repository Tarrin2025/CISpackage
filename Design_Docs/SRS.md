# Software Requirements Specification

				**For:** CIS- Colocalization Immune-Cell Score  
				**By:** Tarrin Dewberry

# Purpose: 

1.1 A tool to score and rank immune-specific cells in a given disease using a GWAS- eQTL Colocalization pipeline. The tool is used to identify what loci and immune cell types are strongly associated with the disease. The tool can help understand how genetic variation  affects expression in specific immune cells.

## 1.2 Project Scope: 

The tool identifies a genomic loci and immune cell types where gene expression is influenced by disease associated variants. The tool can compare colocalization results across different immune cell types..   
This tool can: 

- Identify loci specific to disease   
- Identify immune cell types where gene expression is influenced by disease associated variants   
- Comparison colocalization signals across different immune cell types  
- Input: GWAS summary statistics preharmonized and immune cell-specific eQTL files  
- Output: CSV files with locus level colocalization results and immune cell rankings

This tool can’t: 

- Clinically diagnosis or suggest drug/treatment recommendations   
- Analyze cell types that are not immune cell types 

## 1.3 References 

**Cell-type-specific regulator variants on Immune traits**   
[https://www.science.org/doi/10.1126/science.abf3041](https://www.science.org/doi/10.1126/science.abf3041)?  
**GWAS-eQTL using DICE Database**  
[**https://www.sciencedirect.com/science/article/pii/S009286741831331X?via%3Dihub**](https://www.sciencedirect.com/science/article/pii/S009286741831331X?via%3Dihub)

# 2\. Overall Description

**Input:** GWAS summary statistics (format:csv file) and Immune Cell-type-specific eQTL summary statistic (format: vcf file)   
**Output**: Quantify colocalized loci and computing a Colocalized Immune-Cell Score (CIS) (format: csv file)

# 3\. Functional Requirements

## 	**3.1 System Features**

### 	**3.1.1 Preprocessing:** 

FR-1.1: The system shall accept harmonized summary statistics files for Gwas and eQTL data.   
FR-1.2: The system shall validate that the inputted files contain required columns, including Beta, varbeta or standard error, which are necessary for colocalization.  
FR-1.3: The system shall display error messages for invalid file formats or missing required columns.  
FR-1.4: The system shall convert valid input files into dataframes for downstream analysis. 

### **3.1.2 Gwas-eQTL Colocalization Pipeline:** 

FR-2.1: The system shall identify shared SNP variants between the Gwas dataset and each immune-specific eQTL dataset.   
FR-2.2: The system will create a merged dataframe using overlapping SNP variants and the summary statistics associated.  
FR-2.3: The system shall create a coloc input list with the overlapping SNPs and the associated meta data from both the eQTL and Gwas summary statistics.  
FR-2.4: The system shall validate the coloc input list using the *checkdataset()* function from the coloc R package.  
FR-2.5: The system shall run coloc.abf() from the coloc R package on the Gwas input list and each immune-specific cell type list.   
FR-2.5: The system shall store colocalization results into a dataframe with the immune cell type, SNP variants, and PP4 value produced from the *coloc.abf()* function.

### **3.1.3 Compute Colocalization Scores:**

FR-3.1: The system shall create normalized weights of the PP4 values for each immune cell type for each GWAS locus.   
FR-3.2: The system shall aggregate the weights across loci to compute the Colocalized Immune-Cell Score (CIS) per immune cell type.  
FR-3.4: The system shall store the CIS scores for each immune cell type. 

### **3.1.4 Rank Immune Cell types & Validation:**

FR-4.1: The system shall rank the immune cell type by their CIS scores.  
FR-4.2: The system shall output a csv file containing the immune cell type, Gwas locus and the CIS score.  
FR-4.3: The system shall validate the ranking results. 

## 	**3.2 Use Cases** 

**User Type 1:** Bioinformatician   
**Description**: Bioinformatician with programming experience in analyzing genomic and transcriptomic data with familiarity with R   
**User Type 2: Immunology Researcher**   
**Description:** Wet-lab researchers studying immune responses to diseases with familiarity to R programming

# 

# **4\. Data Dictionary**

* **Input data:** GWAS and eQTL tab-separated files (tsv) files must include fields such as SNP ID, varbeta, beta, and type,p-values, position(optional). If both varbeta and beta can’t be provided, then p-values and MAF must be provided and are sufficient factors as well.   
* **Output Data:** A csv data file with ranked immune cell type and associated Gwas locus and CIS score.

**AI Disclaimer:**   
Artificial Intelligence tools (ChatGPT and Claude) were used to assist with document organization and structure. AI was also used for spelling and grammar checks.  
