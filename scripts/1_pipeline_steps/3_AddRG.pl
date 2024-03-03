#!/usr/bin/perl
#This seems to work
#Written by E. McCartney-Melstad
#Adjusted by M.C. De Visser and C. Kazilas

use strict;
use warnings;
use Parallel::ForkManager;

my @samples = ("<sample_1>", "<sample_2>", "<sample_3>"");

print "Processing " . scalar(@samples) . " samples\n";   


# Now we'll add RG information using picard AddOrReplaceReadGroups and mark duplicates
my $addReplaceFM = Parallel::ForkManager->new(2);
print "\n\n>>>>Adding read groups and marking duplicates with picard\n\n";
foreach my $sample (@samples) {
    $addReplaceFM->start and next;

    my $input = "/<mapped_reads_dir>/$sample.bam";
    my $output = "/<mapped_reads_dir>/$sample.RG.bam";
    my $SM = $sample;
    my $RGLB = $SM . '-lib1';
    my $RGID = $sample;
    my $PU = 'HSEM050';
	
    system("java -jar \$EBROOTPICARD/picard.jar AddOrReplaceReadGroups I=$input O=$output RGLB=$RGLB RGPL=ILLUMINA RGSM=$SM RGID=$RGID RGPU=NA SORT_ORDER=coordinate");
		#changed RGPU=$PU to RGPU=NA --> check this later

    my $MDout = "/<mapped_reads_dir>g/$sample.dedup.bam";
    my $metrics = "/<mapped_reads_dir>/$sample.dedup.metrics";
    system("java -jar \$EBROOTPICARD/picard.jar MarkDuplicates I=$output O=$MDout M=$metrics");
    system("samtools index $MDout");
	unlink($input, $output);
    $addReplaceFM->finish;
}
$addReplaceFM->wait_all_children();
print "\n\n>>>>Finished adding read groups and marking duplicates with picard\n\n";


open(my $bqFH, ">", "/<mapped_reads_dir>/L007.dedupBams.list");
foreach my $sample (@samples) {
	print $bqFH "/<mapped_reads_dir>/$sample.dedup.bam" . "\n";
}
close($bqFH);
