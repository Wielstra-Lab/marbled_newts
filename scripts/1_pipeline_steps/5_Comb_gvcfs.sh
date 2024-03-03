#!/bin/bash
#Written by M.C. de Visser and C. Kazilas

##  USING THE NON-BQSR'D STUFF FROM MY OWN OPTIMIZED PIPELINE:
/cm/shared/easybuild/software/GATK/4.1.3.0-GCCcore-8.3.0-Java-1.8/gatk --java-options '-DGATK_STACKTRACE_ON_USER_EXCEPTION=true' CombineGVCFs \
--reference /<path_to_reference_file>/triturus.RBBH.fasta \
--variant /<variants_dir>/<sample_1>.g.vcf \
--variant /<variants_dir>/<sample_2>.g.vcf \
--variant /<variants_dir>/<sample_3>.g.vcf \
--output <combined_VCF>.vcf
