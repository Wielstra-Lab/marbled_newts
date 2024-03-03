#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=admixture_analysis
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@gmail.com

#make directory
cd /data/<path_to_data>/

mkdir -p <admixture_ouput>
cd <admixture_ouput>

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

K=<number_of_K>
for r in {1..25}
do
$HOME/admixture -s ${RANDOM} --cv=10 /<admixture_ouput>/$FILE.bed $K > log${r}.out
mv $FILE.${K}.Q $FILE.${K}${r}.Q
done

zip ${FILE}.admixture.zip *Q
rm *Q
