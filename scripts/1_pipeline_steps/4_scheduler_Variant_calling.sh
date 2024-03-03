#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu-long
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=Variant_Calling_1
#SBATCH --mem=100G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@gmail.com

cd /data/<path_to_data>/

module load VCFtools
module load GATK

perl /<path_to_perl_file>/4_Variant_calling.pl

