# cuffdiff2edgeR
Perl Script to convert CUFFDIFF output for use with edgeR and Trinity DE analysis

##Usage:

`perl cuffdiff_2_edgeR.pl edgeR.matrix > cuffdiff_genes.counts.matrix`

##TODO:

* Ensure reps are in the correct order as CUFFDIFF doesn't seem to guarentee replicate order.
* Rather than outputting to screen, use perl to write correct output files
+ Trinity DE analysis assumes that the matrix file format is of the form Trinity_genes.count.matrix

