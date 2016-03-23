#!/usr/bin/perl
use strict;
use warnings;

my $line_no = 0;
my $current_id = "";
my $line;
my $filename = $ARGV[0];
my @row;
my @header;
my $first_run = 1;
my $never_header = 1;

open (INFILE, $filename) or die "Sorry, cannot open the file titled: $filename";



#WARNING, the script assumes that the cuffdiff file is always 
###the way to do this properly;
#read first N number of lines until there is a change in tracking_id. This will give you the header, the number of samples and then the reps.
#Create an index so we know which array element a specific condition and rep belongs in the row
#start reading the file again and this time match the condition and rep with the row array element to ensure that it's always correct.




for $line (<INFILE>) {

	#read line into the correct variables
	my ($tracking_id, $condition, $replicate, $raw_frags, $internal_scaled_frags, $external_scaled_frags, $FPKM, $effective_length, $status) = split("\t", $line);

	##check to see if the first line header matches what we expect
	if($line_no == 0)
	{
		($tracking_id eq "tracking_id") and \\
		($condition eq "condition") and \\
		($replicate eq "replicate") and \\
		($raw_frags eq "raw_frags") and \\
		($internal_scaled_frags eq "internal_scaled_frags") and \\
		($external_scaled_frags eq "external_scaled_frags") and \\
		($FPKM eq "FPKM") and \\
		($effective_length eq "effective_length") and \\
		($status eq "status") or \\
		die "The first line of your genes.read_group_tracking file is incorrect.\nIt should be in the following format as produced by CUFFDIFF:\n\ntracking_id\tcondition\treplicate\traw_frags\tinternal_scaled_frags\texternal_scaled_frags\tFPKM\teffective_length\tstatus\n";
	
		$line_no++;
		next;
	}

	#now process the results
	if($line_no != 0){

		##this is a new gene, so new row with first column containing tracking_id
		if($current_id ne $tracking_id){

			#if we've never printed the header but have completed a first run, print header now
                        if($never_header == 1 && $first_run == 0){
                                $never_header = 0;
                                print join("\t", @header), "\n";
                        }

			#if we're on our first run, add initial commit
			if($first_run == 1){
	                        push(@header, "Gene");
	                        push(@header, "$condition-$replicate");
				$first_run = 0;
			}

                        if($never_header == 0 && $first_run == 0){
				print join("\t", @row), "\n";
                        }
			
			@row=(); 
			$current_id = $tracking_id;
			push(@row, $current_id);
			push(@row, $raw_frags);

			next;
		}

		##same gene as before, so append $raw_frags
		if($current_id eq $tracking_id){
			push(@row, $raw_frags);
			if($never_header == 1){
				push(@header, "$condition-$replicate");
			}
		}

	}

	$line_no++;

}

#final line out
print join("\t", @row), "\n";

close INFILE;
