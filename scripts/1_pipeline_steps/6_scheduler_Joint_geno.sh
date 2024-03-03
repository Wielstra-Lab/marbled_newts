#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=testing
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=joing_all_geno_test
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@gmail.com

cd /data/<path_to_data>/

module load GATK

/<path_to_perl_file>/6_Joint_geno.sh


