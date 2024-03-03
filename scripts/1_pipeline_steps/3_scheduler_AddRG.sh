#!/bin/bash


##BEWARE before running this make sure either that it works, or that you have somewhere a copy of the mapped reads!! Because if the path's are somehow misinterpreted, for instance due to invisible endline characters that should not be there, the process is killed and the mapped reads/bams can become overwritten


#SBATCH --ntasks=1
#SBATCH --partition=testing
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=RG_test
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@gmail.com

cd /data/<path_to_data>/

module load VCFtools
module load SAMtools
module load picard

perl /<path_to_perl_file>/3_AddRG.pl
