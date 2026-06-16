genome=locust.genomic.fna
prefix=locust
CPU=2
# 3. LTR retriever
mkdir 03-LTRretriever
cd 03-LTRretriever
/share/home/software/software/LTR_retriever-master/LTR_retriever -genome ../$genome -inharvest ../01-LTRharvest/$prefix.harvest.scn.new -infinder ../02-LTRfinder/$prefix.finder.scn -threads $CPU
cd ../
