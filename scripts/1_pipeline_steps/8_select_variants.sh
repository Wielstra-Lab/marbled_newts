#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=testing
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=varaints
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@gmail.com

cd /data/<path_to_data>/

module load VCFtools

vcftools --vcf <genotyped_VCF_ExcHet>.vcf --max-missing 0.5 --remove-indels --minQ 20 --recode --recode-INFO-all --out <VCF_filtered>

perl /<path_to_perl_file>/8_subsampleVCF.pl <VCF_filtered>.recode.vcf <VCF_SNPs_Subset>.vcf

#We are interested in the filtered.recode file
#For the 1 SNP per target we use the 9th script