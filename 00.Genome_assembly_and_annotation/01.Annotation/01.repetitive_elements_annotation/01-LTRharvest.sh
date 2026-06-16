genome=locust.genomic.fna
prefix=locust
CPU=10

# 1. LTRharvest
mkdir 01-LTRharvest
cd 01-LTRharvest

gt suffixerator \
      -db ../$genome \
      -indexname $prefix \
      -tis -suf -lcp -des -ssp -sds -dna  

gt ltrharvest \
      -index $prefix \
      -similar 90 -vic 10 -seed 20 -seqids yes \
      -minlenltr 100 -maxlenltr 8000 -mintsd 4 -maxtsd 6 \
       > $prefix.harvest.scn.new

cd ../
