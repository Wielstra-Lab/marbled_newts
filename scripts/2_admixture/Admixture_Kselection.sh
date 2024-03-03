#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=Kadmixture_analysis
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@gmail.com

#make directory
cd /data/<path_to_data>/

mkdir -p <admixture_k_selection_ouput>
cd <admixture_k_selection_ouput>

#specift file
FILE=<VCF_SNPs_Subset>

#load modules locally
module use $HOME/plink
module use $HOME/admixture

#generate thei nput file in plink format
$HOME/plink --vcf /<path_to_VCF_file>/$FILE.vcf --make-bed --out $FILE --allow-extra-chr --double-id

#For admixture change chromosomes to integers
awk '{$1=0;print $0}' $FILE.bim > $FILE.bim.tmp
mv $FILE.bim.tmp $FILE.bim

#run admixture multiple times
mkdir -p runs
cd runs


for k in {1..20}
do
	for r in {1..5}
	do
	$HOME/admixture -s ${RANDOM} --cv=10 /<admixture_ouput>/$FILE.bed $k > log.${k}.${r}.out
	done
done

#Creating a Graph in R
cd ..

grep -h CV runs/log*.out |sed "s/CV error (K=//" | sed "s/)://" > CV_error

module load R/3.6.0-foss-2019a-Python-3.7.2
Rscript /<path_to_CV_plot_file>/CVplot.R

mv Rplots.pdf ${FILE}.Admixture.Kselection.pdf
