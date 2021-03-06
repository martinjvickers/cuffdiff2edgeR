# cuffdiff2edgeR
Perl Script to convert CUFFDIFF output for use with edgeR and Trinity DE analysis

##Rationale

The Trinity Differential Analysis pipeline written in R produces some fantastic heatmaps and other visual representation which is catered for in the CUFFLINKS cummeRbund library. For this reason, this script converts the results of your diff_cuff directory (namely the `genes.read_group_tracking` file) to a format which is readable by edgeR in the Trinity DE analysis tools.

##Usage:

This script assumes that you have completed the whole cufflinks protocol and have a directory called `diff_out`. Within the `diff_out` directory run the following;

`./cuffdiff_2_edgeR.pl --type "raw_frags" --filename genes.read_group_tracking > cuffdiff_genes.counts.matrix`

The `cuffdiff_genes.counts.matrix` file can now be used with the Trinity Differential Expression Analysis scripts.

`./cuffdiff_2_edgeR.pl --type "fpkm" --filename genes.read_group_tracking > cuffdiff_genes.fpkm.matrix`

This probably shouldn't be used in Trinity DE analysis, however it could be used in other software packages, such as Genesis the heatmap/clustering software.
