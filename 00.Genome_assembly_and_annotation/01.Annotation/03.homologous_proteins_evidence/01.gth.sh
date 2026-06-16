#为了加快速度，可以将不同的近缘物种的蛋白分割成多份，同时运行
#例如近缘物种蛋白为protein.faa
perl fasta-splitter.pl --n-parts 20 protein.faa
cd ..
mkdir 01-protein
cd 01-protein
#gth
@name_sample=('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','17','18','19','20');
foreach $name (@name_sample){
    my $cc=`nohup gth -gff3out -intermediate -startcodon -duplicatecheck seq \
            -protein /***/***/***/protein.part-${name}.fa  \
            -translationtable 1 \
            -genomic genome.final.fasta.masked  \
            -o genomeThreader-${name}.gff  > ${name}.out 2>&1 &`;
        }
#产生genomeThreader-01.gff到genomeThreader-20.gff文件
#evm转换格式
EvmUtils/misc/genomeThreader_to_evm_gff3.pl genomeThreader-01.gff  > evm.genomeThreader-01.gff
#将evm.genomeThreader-01.gff到evm.genomeThreader-20.gff合并到一起产生最终的evm.genomeThreader.gff
