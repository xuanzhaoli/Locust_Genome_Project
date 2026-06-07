#vcf2phylip 
python  ~/software/vcf2phylip-master/vcf2phylip.py -i Lmi.rmCY.filtered.mis0.2.maf0.05.vcf.gz -f -n -o HN20-13 --output-prefix Lmi.rmCY.filtered.mis0.2.maf0.05

#raxmlHPC
/share/home/software/software/standard-RAxML-8.2.12/raxmlHPC-PTHREADS-AVX -T 12 -f a -x 12345 -p 12345 -# 100 -m GTRGAMMA -n Lmi.100kb.min4.tree -s Lmi.rmCY.filtered.mis0.2.maf0.05.100kb.min4.phy 
