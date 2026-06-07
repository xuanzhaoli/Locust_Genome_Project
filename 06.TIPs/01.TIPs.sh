#Generate a candidate transposable element database
#Combining the de novo annotation results from RepeatMasker and the RepBase database
cat RepeatMasker_out.fa RepBase.fa > TElib.fa
#Identify transposable element insertions using "ngs_te_mapper2" software
python3.6 ngs_te_mapper2.py -t 6 -f ${name}.fa -r locust_genome.chr.final.fasta -l TElib.fa
#Integrate TE insertion information from each sample to generate a VCF file
#kinship
gcta_v1.94.0Beta_linux_kernel_3_x86_64/gcta --bfile TE --make-grm-gz --make-grm-alg 1 --out kinship
#PCA
plink --threads 4 --bfile TE --pca 3 --out TE

