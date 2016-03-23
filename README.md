# cuffdiff2edgeR
Perl Script to convert CUFFDIFF output for use with edgeR and Trinity DE analysis

##Usage:

This script assumes that you have completed the whole cufflinks protocol and have a directory called `diff_out`. Within the `diff_out` directory run the following;

`perl cuffdiff_2_edgeR.pl genes.read_group_tracking > cuffdiff_genes.counts.matrix`

The `cuffdiff_genes.counts.matrix` file can now be used with the Trinity Differential Expression Analysis scripts.

##TODO:

* Ensure reps are in the correct order as CUFFDIFF doesn't seem to guarentee replicate order.
* Rather than outputting to screen, use perl to write correct output files
+ Trinity DE analysis assumes that the matrix file format is of the form Trinity_genes.count.matrix

