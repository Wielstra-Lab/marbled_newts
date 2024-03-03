#!/bin/bash

#SBATCH --ntasks=1
#SBATCH	--partition=cpu-medium
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-nam=mapping_test
#SBATCH --mem=100G 	
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@gmail.com

cd /data/<path_to_data>/

module load BWA
module load VCFtools
module load SAMtools

perl /<path_to_perl_file>/2_Map.pl

