#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=testing
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=quality_filtering
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@gmail.com

cd /data/<path_to_data>/

module load VCFtools

vcftools --vcf <genotyped_VCF_ExcHet>.vcf --max-missing 1 --remove-indels --minQ 20 --recode --recode-INFO-all --out <VCF_filtered>.noqm

perl /<path_to_perl_file>/9_SNP_Subset.pl <VCF_filtered>.noqm.recode.vcf <VCF_SNPs_Subset>.vcf

#We are interested in the SNPs_Subset file (1 SNP per target)