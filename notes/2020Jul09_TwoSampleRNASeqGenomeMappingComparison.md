# Genome RNA-seq mapping and quantification comparison

## Overview  
Compared mapping and quantification oftwo C. virginica RNA-seq samples (17005 and 17099,[available on NCBI](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA594029/)) using genome [NCBI oyster genome](https://www.ncbi.nlm.nih.gov/assembly/GCF_002022765.2) and a [reduced genome]() created by Jon Puritz.

## Protocol   
I started with samples files that were already trimmed using a standard trimmomatic approach, and used custom script that combined mapping with STAR and transcript quantification with RSEM. You will need both to run the script.
* [Script](https://github.com/adowneywall/updatedOysterTranscriptomeMappingComparison/blob/master/src/shell/MappingAndQuantificationScript_V1.sh)

### Sample versions
* **Hap_custom** : Using reduced genome with custom parameters (used when originally analyzing these samples).
* **Hap_default** : Using the reduced genome with default parameters (both for STAR and RSEM).
* **OG_custom** : Used the original genome from NCBI and custom parameters.

## Results

[Link to figures and tables](https://github.com/adowneywall/updatedOysterTranscriptomeMappingComparison/blob/master/src/twoSample_OutputSummary.md)

* Confirmed that the choice of parameters only had minor effects on mapping and RSEM quantification.
* Saw that mapping of unique reads was consistent higher with the reduced genome ('Hap') by ~6% and we saw a similar decrease in multi mapping.
* These differences in mapping also tended to lead to subtle differences in transcript count estimates, the correlation between TPM between genomes was ~0.85 and slightly higher in the non-standardized counts.
