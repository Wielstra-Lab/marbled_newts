#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --mem=50GB
#SBATCH --partition=cpu-long
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=trim_adapter_test
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@gmail.com

cd /data/<path_to_data>/

module load skewer
module load VCFtools

perl /<path_to_perl_file>/1_Trim.pl


