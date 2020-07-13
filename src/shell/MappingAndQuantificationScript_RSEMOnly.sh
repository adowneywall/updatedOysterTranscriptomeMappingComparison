#!/bin/bash

## Software Versions
# STAR: STAR_2.5.3a
# RSEM: 

# Script takes trimmed RNA-seq files outputed from trimmomatic (fq.gz compressed format)
# and maps them to the provided genome (fasta or .fna format) and annotates with provided
# annotation file (.gtf format).

## Script uses default settings for STAR and RSEM

#### WARNING ####
# This script used the '&' sample after the RSEM function 
# in order to run all samples in parallel. This was done because
# the 'rsem-calculate-expression' is quite slow and doesn't take
# a ton of resources. However, if you are running lots of samples
# running them all simulataneously might be taxing on the system.
# This '&' can be commented out to run each sample serially (one-by-one).

## List of samples in direcotry to be run
#lst=(17181 17203 17211 17213)
lst=(17070 17072 17079 17090 17094 17108)


# Raw sequence file directory
raw="/shared_lab/20180226_RNAseq_2017OAExp/RNA/rawfiles"
# Reference genome file (.fna or fasta file)
genome="/shared_lab/20180226_RNAseq_2017OAExp/RNA/references/genome/haplotig_masked_genome.fasta"
# Annotation file (.gtf)
annotation="/shared_lab/20180226_RNAseq_2017OAExp/RNA/references/gene_annotation/KM_CV_genome_edit_Gnomon.gtf"
# Output folder
output="/shared_lab/20180226_RNAseq_2017OAExp/RNA/haplotTigGenome_PaperSTARSettings_allSamples"

### Create basic file structure
refs="$output/refs"
s_out="$output/STAR"
s_out_m2=$s_out"/m2"
s_out_m3=$s_out"/m3"
r_out="$output/RSEM"
rsem_ref=$refs"/RSEM_ref"

### RSEM Quantification ###########################################
echo "Starting RSEM...."

for i in ${lst[*]};do
    echo "RSEM .. processing sample: "$i
    outPath=$r_out"/"$i
    filePath=${s_out_m3}"/"${i}
    file1=$(ls $filePath*toTranscriptome.out.bam)

    # --alignments : arguement used to specify that we are supplying aligned bam files
    # --paired-end : paired end reads
    rsem-calculate-expression \
    --alignments \
    --paired-end \
    --output-genome-bam \
    -p 5 \
    $file1 \
    $rsem_ref"/RSEM" \
    $outPath & # The & here will cause all samples to run in parallel
done

wait
echo "RSEM transcript quantification complete"