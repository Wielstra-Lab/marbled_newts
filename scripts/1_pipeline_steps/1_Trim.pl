#!/usr/bin/perl
#Written by E. McCartney-Melstad
#Adjusted by M.C. De Visser and C. Kazilas

use strict;
use warnings;
use Parallel::ForkManager;

#Define your dataset:
my @samples = ("<sample_1>", "<sample_2>", "<sample_3>"");  

print "Processing " . scalar(@samples) . " samples\n";   

### Trim adapters
unless (-d "skewer") {
    mkdir "skewer";
}

my @skewerCommands;
foreach my $sample (@samples) {
    my $R1 = $sample . "_R1_001.fastq.gz"; #removed "reads/" .  
    my $R2 = $sample . "_R2_001.fastq.gz"; #removed "reads/" .  

    my $adapterFile = "<adapters_file>.fa";

    # Make sure the adapter file exists
    unless (-e $adapterFile) {die "$adapterFile not present!\n";}

    my $skewerBaseName = "skewer/" . $sample;

    push(@skewerCommands, "/cm/shared/easybuild/software/skewer/0.2.2-foss-2019b/bin/skewer -x $adapterFile -m pe $R1 $R2 -L 150 -e -z -o $skewerBaseName");  #--quiet argument removed
}

#print "Running all skewer commands\n";
my $skewerFM = Parallel::ForkManager->new(1);
foreach my $skewerCommand(@skewerCommands) {
    $skewerFM->start and next;
    print "Running the following command: \n$skewerCommand\n";
    system($skewerCommand);
    $skewerFM->finish;
}
$skewerFM->wait_all_children();
print "Finished running all skewer commands\n";
