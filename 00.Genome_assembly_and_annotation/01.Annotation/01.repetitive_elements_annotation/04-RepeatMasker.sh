genome=locust.genomic.fna
prefix=locust
CPU=4
# 4. RepeatMasker
mkdir 04-RepeatMasker
cd 04-RepeatMasker
RepeatMasker -pa $CPU -nolow -no_is -gff -norna -e ncbi -lib ../03-LTRretriever/$genome.mod.LTRlib.fa -dir ./ -gff ../$genome
BuildDatabase -name $prefix -engine ncbi $genome.masked
RepeatModeler -database $prefix -pa $CPU
