**Software Requirements Specification**

				**For:** CIS- Colocalization Immune-Cell Score  
				**By:** Tarrin Dewberry  
**Purpose:**   
1.1 A tool to score and rank immune-specific cells in a given disease using a GWAS- eQTL Colocalization pipeline. The tool is used to identify what loci and immune cell types are strongly associated with the disease. The tool can help understand how genetic variation  affects expression in specific immune cells.

**1.2 Project Scope:**   
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

**1.4 References**   
**Cell-type-specific regulator variants on Immune traits**   
[https://www.science.org/doi/10.1126/science.abf3041](https://www.science.org/doi/10.1126/science.abf3041)?  
**GWAS-eQTL using DICE Database**  
[**https://www.sciencedirect.com/science/article/pii/S009286741831331X?via%3Dihub**](https://www.sciencedirect.com/science/article/pii/S009286741831331X?via%3Dihub)

**2\. Overall Description**  
**Functional Requirements**  
**Input:** GWAS summary statistics (format:csv file) and Immune Cell-type-specific eQTL summary statistic (format: vcf file)   
**Output**: Quantify colocalized loci and computing a Colocalized Immune-Cell Score (CIS) (format: csv file)

**3\. Functional Requirements**  
	3.1 System Features  
	**Data Upload:**   
FR-1.1: The system shall accept genomic data files in GWAS CSV and Immune cell eQTL VCF file  
FR-1.2: The system shall validate uploaded files for correct format and completeness  
FR-1.3: The system shall display error messages for invalid file formats  
**Colocalization:**   
FR-2.1: The system shall turn each input dataset file into a list.  
FR-2.2: The system shall validate the list has all the required information by running the function, *checkdataset()* from the coloc package in R  
FR-2.3: For each immune cell eQTL list we will run *coloc.abf()* with the GWAS list to compare PP0-PP4 posterior probabilities   
**CIS Ranking-Score:**  
FR-3.1: The system shall use sum up PP4 values for each locus and immune cell type.   
FR-3.2: The system shall normalize the weights across loci to compute a Colocalized Immune-Cell Score (CIS) per immune cell type.  
FR-3.3: The system shall output a CSV file containing the immune cell type, the locus and the ranking score (CIS score).

	**3.2 Use Cases**   
**User Type 1:** Bioinformatician   
**Description**: Bioinformatician with programming experience in analyzing genomic and transcriptomic data with familiarity with R   
**User Type 2: Immunology Researcher**   
**Description:** Wet-lab researchers studying immune responses to diseases with familiarity to R programming

**4\. Data Dictionary**

* **Input data:** GWAS and eQTL files must include fields such as SNP ID, varbeta, beta, and type,p-values, position(optional). If both varbeta and beta can’t be provided, then p-values and MAF must be provided and are sufficient factors as well.   
* **Output Data:** One data file with locus, immune cell type, PP4 value, CIS score, and ranked top immune cell types

