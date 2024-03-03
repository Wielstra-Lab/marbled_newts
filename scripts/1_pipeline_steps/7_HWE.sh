#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=testing
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=HetExc
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@gmail.com

cd /data/<path_to_data>/

module load BCFtools

bcftools +fill-tags  <genotyped_VCF>.vcf -Ou -- -t all | bcftools view -e'ExcHet<0.05' >  <genotyped_VCF_ExcHet>.vcf # creates a new .vcf file excluding the sites with heterozygote excess