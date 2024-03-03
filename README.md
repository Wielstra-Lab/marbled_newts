# **Spatial genetic structure in European marbled newts revealed with target enrichment by sequence capture**

__________________________________________________________________________________________________

Our team: Christos Kazilas, Christophe Dufresnes, James France, Konstantinos Kalaentzis, Iñigo Martínez-Solano, Manon C. de Visser, Jan W. Arntzen, Ben Wielstra

__________________________________________________________________________________________________

## 1️⃣ Pipeline steps

*All the necessary script files are located in the `scripts` folder, in the order in which they should be executed.*

###### <u>0 - Quality check</u>

This step is optional and is performed in order to assess the quality of FASTQ read files. Run the `0_FASTQC.sh` script for each file and then check the FastQC reports in the `quality_check` output folder.

###### <u>1 - Trimming</u>

This step removes the adapters. Run the `1_scheduler_Trim.sh` script and keep the trimmed files in a new folder for the next step.

###### <u>2 - Mapping</u>

Here we map our read files to a reference sequence. Don't forget to specify the sample names, working directories, and path to the reference sequence file. Run the `2_scheduler_Map.sh` script. Your bam files will be saved a new directory, specified in the `2_Map.pl` perl file.

###### <u>3 - Adding Read Groups</u>

Marks PCR duplicates and filters different reads. Run the `3_scheduler_AddRG.sh` script. Beware before running this make sure either that it works, or that you have somewhere a copy of the mapped reads. If the paths are somehow misinterpreted (for instance due to invisible endline characters that should not be there) the process is killed and the mapped reads/bams can become overwritten. 

###### <u>4 - Variant Calling</u>

Calls the SNPs. Don't forget to specify the sample names, working directories, and path to the reference sequence file. Run the `4_scheduler_Variant_calling.sh` script. Your bam files will be saved a new directory, specified in the `4_Variant_calling.pl` perl file.

###### <u>5 - Combine gVCFs</u>

Combines all the output files of variant calling. Run the `5_scheduler_Comb_gvcfs.sh` script. The output will be a single VCF file, saved in the directory you specified in `5_Comb_gvcfs.sh` script.

###### <u>6 - Joint Genotyping</u>

Genotypes the file, indicates the presence of variants among all individuals. Run the `6_scheduler_Joint_geno.sh` script. The output will be a single VCF file, saved in the directory you specified in `6_Joint_geno.sh` script.

###### <u>7 - Hardy Weinberg Equilibrium</u>

Filters out all variants that aren't in Hardy Weinberg Equilibrium. Creates a new VCF file, excluding the sites with heterozygote excess. Run the `7_HWE.sh` script.

###### <u>8 - Select Variants</u>

Filters SNPs with a minimum quality score of 20 and no more than 50% missing data. The output is used in the **Principal Component Analysis (PCA)**, the **RAxML**, and the **BEAST** analyses. Run the `8_select_variants.sh` script and keep the `<VCF_filtered>.recode.vcf` output.

###### <u>9 - Select Variants (one SNP per target)</u>

Keeps SNPs from sites with no missing data and chooses one per contig randomly. The output is used in the **Admixture** and the **NewHybrids** analyses. Run the `9_SNP_Subset.sh` script and keep the `<VCF_SNPs_Subset>.vcf` output.

## 2️⃣ Admixture

###### <u>K selection</u>

For the number of subpopulations (K), values from 1 to 20 are tested by running the `Admixture_Kselection.sh` script. The ouput is a PDF file of the following format: `<VCF_SNPs_Subset>.Admixture.Kselection.pdf`. Use this file to determine the optimal number of K subpopulations for your analysis.

###### <u>Admixture analysis</u>

Run the `Admixture.sh` script, by specifying the number of K subpopulations from the previous run. The analysis is run for 25 replicates. The output file (`<VCF_SNPs_Subset.admixture.zip`) is then uploaded to CLUMPAK to combine the replicates for each K value and visualize the results.

## 3️⃣ PCA

Follow the instuctions provided in the `PCA.R` file. Also, modify the `filenames_PCA.txt` according to the sample names and groups you would like to use.
