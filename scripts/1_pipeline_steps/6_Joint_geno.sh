#!/bin/bash
#Written by M.C. de Visser and C. Kazilas

module load GATK

/cm/shared/easybuild/software/GATK/4.1.3.0-GCCcore-8.3.0-Java-1.8/gatk --java-options '-DGATK_STACKTRACE_ON_USER_EXCEPTION=true' GenotypeGVCFs \
--allow-old-rms-mapping-quality-annotation-data \
--reference /<path_to_reference_file>/triturus.RBBH.fasta \
--variant /<combined_VCF>.vcf \
--output <genotyped_VCF>.vcf
