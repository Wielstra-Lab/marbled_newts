#!/bin/bash 
#SBATCH -p testing						# Partition to submit to 
#SBATCH --job-name=FASTQC_all					# jobname 
#SBATCH -c 8 
#SBATCH -o FASTQC_all.%A.out					# File to whch stdout will be written 
#SBATCH -e FASTQC_all.%A.err 					# File to which #stderr will be written 
#SBATCH --mem-per-cpu=20G 					# Memory per cpu 
#SBATCH --ntasks=1 --cpus-per-task=1 #--ntasks-per-node=1 	# More info on tasks 
#SBATCH --mail-type=FAIL 					# Type of email notifications- BEGIN, END, #FAIL, ALL 
#SBATCH --mail-user=email@gmail.com 		# Email to which notifications will be sent

# Change to directory where the files are located
cd /data/<path_to_data>/

# Load module
module load FastQC/0.11.8-Java-11

# Run the Fastqc
fastqc -o quality_check <file_name>.fastq.gz

# move the files to your output directory, which is quality_check in this case 
# and already specified in the fastqc command



