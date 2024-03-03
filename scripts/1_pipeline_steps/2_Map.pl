#!/usr/bin/perl
#This seems to work
#Written by E. McCartney-Melstad
#Adjusted by M.C. De Visser and C. Kazilas

use strict;
use warnings;
use Parallel::ForkManager;

#From Dummyset, all individuals:
my @samples = ("<sample_1>", "<sample_2>", "<sample_3>"");  

print "Processing " . scalar(@samples) . " samples\n";   

### MAPPING ###
print "\n\n >>>>Mapping reads using BWA MEM\n\n";

unless (-d "<mapped_reads_dir>") {
    mkdir "<mapped_reads_dir>";
}

#system("/cm/shared/easybuild/software/BWA/0.7.17-GCC-8.2.0-2.31.1/bin/bwa index /<path_to_reference_file>/triturus.RBBH.fasta);

my $bwaFM = Parallel::ForkManager->new(1);
foreach my $sample (@samples) {
    $bwaFM->start and next;
    my $R1 = "<path_to_data>/" . $sample . "_L001_R1_001.fastq.gz";
    my $R2 = "<path_to_data>/" . $sample . "_L001_R2_001.fastq.gz";
    my $bam = "<mapped_reads_dir>/" . $sample . ".bam";
	
    system("/cm/shared/easybuild/software/BWA/0.7.17-GCC-8.2.0-2.31.1/bin/bwa mem -M /<path_to_reference_file>/triturus.RBBH.fasta $R1 $R2 | /cm/shared/easybuild/software/SAMtools/1.9-GCC-8.2.0-2.31.1/bin/samtools view -bS - > $bam");
    $bwaFM->finish;
}
$bwaFM->wait_all_children();
print "\n\n >>>>Finished mapping reads using BWA mem\n\n";
