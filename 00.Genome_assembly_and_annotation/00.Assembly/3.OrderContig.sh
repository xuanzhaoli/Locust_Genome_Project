#!/bin/bash
#################################################################
#                           Hic step 3
#################################################################


exepath=/media/dell/lixuanzhao/software/3d-dna-201008/
#export PATH=/public-supool/software/parallel-20180222/bin:$PATH
#export PATH=/public-supool/software/jdk1.8.0_161/bin:$PATH

ln -s ../references/locust.fasta genome.fa
ln -s ../Assembly/aligned/merged_nodups.txt mnd.txt

time ${exepath}/run-asm-pipeline.sh \
     genome.fa \
     mnd.txt

# -i|--input the size threshold for the draft sequences to scaffold.
# Contigs/scaffolds smaller than input_size are going to be ignored
# by the algorithm and concatenated to the output without change.
# Default: 15000.
# 
# -r|--rounds the number of iterative rounds for misjoin correction. Default: 2.
# 
# -m|--merge the parameter to specify whether to run the merge module or
# not. Merging is not run by default and should only be employed
# if high levels of undercollapsed heterozygosity are expected to be
# present in the draft assembly.
# 
# -h|--help shows this help. Use ¨Ch for main options and --help for a full set
# of options.
# 
