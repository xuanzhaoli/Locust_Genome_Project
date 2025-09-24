#K=2
admixture -j10 --cv  Lmi.filtered.mis0.2.maf0.05.final.addID.bed 2|tee log2.out
#K=3
admixture -j10 --cv  Lmi.filtered.mis0.2.maf0.05.final.addID.bed 3|tee log3.out
#K=4
admixture -j10 --cv  Lmi.filtered.mis0.2.maf0.05.final.addID.bed 4|tee log4.out
