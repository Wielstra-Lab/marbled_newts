#!/usr/bin/perl
#
#Written by E. McCartney-Melstad
#Adjusted by M.C. De Visser and C. Kazilas

use strict;
use warnings;
use Parallel::ForkManager;


#From Dummyset, two individuals:
my @samples = ("<sample_1>", "<sample_2>", "<sample_3>""); 

print "Processing " . scalar(@samples) . " samples\n";   


##                               CHECK LATER IF WE NEED TO RUN BQSR! - if so, code is missing here
##                               CHECK LATER IF WE NEED TO RUN BQSR! - if so, code is missing here
##                               CHECK LATER IF WE NEED TO RUN BQSR! - if so, code is missing here


### VARIANT CALLING ###
unless(-d "<variants_dir>") {
    mkdir("<variants_dir>");
}
print "\n\nRunning haplotypeCaller to generate gvcfs\n\n";   
                                                  #be careful how to call your output here, depending on BQSR is actually run or not!!

my $hapCallerFM = Parallel::ForkManager->new(9);
foreach my $sample (@samples) {
    $hapCallerFM->start and next;
	my $inputBAM = "/<mapped_reads_dir>/" . $sample . ".dedup.bam"; 
	my $gVCF = "/<variants_dir>/" . $sample . ".g.vcf";   #if using BQSR, add this to output name for clarity
    #my $bqsrTable = "BQSR/L007_BQSR.table";                            #silenced this as we are not using it at the moment

    system("/cm/shared/easybuild/software/GATK/4.1.3.0-GCCcore-8.3.0-Java-1.8/gatk --java-options '-DGATK_STACKTRACE_ON_USER_EXCEPTION=true' HaplotypeCaller --reference /<path_to_reference_file>/triturus.RBBH.fasta -I $inputBAM -O $gVCF -ERC GVCF");
#    --bqsr $bqsrTable \                          #silenced this as we are not using it at the moment
#    --emitRefConfidence GVCF \       		  #silenced this as we are not using it at the moment
	$hapCallerFM->finish;
	                                          #removed -T argument/option, not sure what it does
}
 
$hapCallerFM->wait_all_children();
print "\n\nFinished running first round of haplotypeCaller to generate gvcfs\n\n";
#!!be careful to know if they are indeed BQSR'd or not
