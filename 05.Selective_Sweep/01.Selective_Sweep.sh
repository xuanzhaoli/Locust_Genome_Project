#TajimaD
vcftools --gzvcf Lmi.filtered.mis0.2.maf0.05.final.addID.vcf.gz --keep ../../listbin/HB_SD.list --TajimaD 100000 --out HB_SD.100kb.TajimaD
vcftools --gzvcf Lmi.filtered.mis0.2.maf0.05.final.addID.vcf.gz --keep ../../listbin/Lh_Ri.list --TajimaD 100000 --out Lh_Ri.100kb.TajimaD

#fst
vcftools --gzvcf Lmi.filtered.mis0.2.maf0.05.final.addID.vcf.gz --weir-fst-pop ../../LS36_RK40 --weir-fst-pop ../../DY00_HH00 --fst-window-size 100000 --fst-window-step 50000 --out LS36_RK402DY00_HH00.win100kb.step50kb

#XPCLR (For example, Chr1)
xpclr --out Lh_Ri2HB_SD.chr1 --format vcf --input Lmi.filtered.mis0.2.maf0.05.final.addID.vcf.gz --samplesA LS36_RK40 --samplesB DY00_HH00 --ld 0.95 --size 100000 --step 10000 --chr chr1 --maxsnps 1000

#Phasing genotypes
java -Xmx4g -jar beagle.jar gt=Lmi.filtered.mis0.2.maf0.05.addID.simple.vcf.gz out=Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased nthreads=6

#nsl
for name in 1 2 3 4 5 6 7 8 9 10 11 12
do
selscan --nsl --vcf ../Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr$name\.vcf.recode.vcf --out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr$name\.nSL
done
#
norm --nsl --files Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr10.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr11.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr12.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr1.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr2.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr3.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr4.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr5.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr6.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr7.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr8.nSL.nsl.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr9.nSL.nsl.out --bp-win 100000

#ihs
for name in 1 2 3 4 5 6 7 8 9 10 11 12
do
selscan --ihs --ihs-detail --threads 4 --vcf ../Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr$name\.vcf.recode.vcf --pmap --out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr$name\.iHS
done
#
norm --ihs --files Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr10.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr11.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr12.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr1.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr2.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr3.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr4.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr5.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr6.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr7.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr8.iHS.ihs.out Lmi.filtered.mis0.2.maf0.05.addID.simple.Phased.Chr9.iHS.ihs.out --bp-win --winsize 100000

