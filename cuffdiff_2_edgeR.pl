#!/usr/bin/perl
use strict;
use warnings;

my $line_no = 0;
my $line;
my $filename = $ARGV[0];
my $current_id = "";
my %conditions = ();
my $first_run = 0;
my @headers = "";
my $first_print = 0;

open (INFILE, $filename) or die "Sorry, cannot open the file titled: $filename";

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
	}

	#now create out header array
	if($line_no != 0)
	{

		#start of a new ID
		if($tracking_id ne $current_id)
		{

			if($first_run != 0)
			{

				if ($first_print == 0)
				{
					my $value = 1;
					my $numkeys = keys( %conditions );
					print "\t";
					foreach my $key (keys %conditions)
					{
						if($value < $numkeys)
						{
                                        		print "$key\t";
						} else {
							print "$key";
						}
						$value++;
                                	}
					print "\n";
					$first_print = 1;
				}

				print "$current_id\t";
				my $value = 1;
				my $numkeys = keys( %conditions );
				
				foreach my $key (keys %conditions)
				{
					if($value < $numkeys)
					{
						print "$conditions{$key}\t";
					} else {
						print "$conditions{$key}";
					}
					$value++;
				}
				print "\n";
			} elsif ($first_run == 0)
			{
				$first_run = 1;
			}

			$current_id = $tracking_id;
			$conditions{ "$condition-$replicate" } = $raw_frags;

		} else {
			$conditions{ "$condition-$replicate" } = $raw_frags;
		}
	
	}

	$line_no++;
}

close INFILE;
