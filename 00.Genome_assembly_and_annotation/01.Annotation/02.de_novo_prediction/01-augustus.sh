cp sample_mydb_pasa.sqlite.assemblies.fasta.transdecoder.genome.gff3 /02-de_novo_prediction
#进行训练
gff=sample_mydb_pasa.sqlite.assemblies.fasta.transdecoder.genome.gff3
genome=locust.genomic.fna
prefix=name
gff2gbSmallDNA.pl $gff $genome 1000 gene.raw.gb
new_species.pl --species=$prefix
etraining --species=$prefix--stopCodonExcludedFromCDS=false gene.raw.gb 2> train.err 
cat train.err | perl -pe 's/.*in sequence (\S+): .*/$1/' >badgenes.lst
filterGenes.pl badgenes.lst gene.raw.gb > genes.gb
randomSplit.pl genes.gb 500
new_species.pl --species=$prefix
etraining --species=$prefix genes.gb.train
augustus --species=$prefix genes.gb.test |tee firsttest.out
# 运行到此步骤可以往下运行
optimize_augustus.pl --species=$prefix --rounds=3 --cpus=15 genes.gb.train
# 该步骤进行模型训练，时间会特别慢
augustus --species=$prefix genes.gb.test |tee secondtest.out
#augustus从头预测
#可以将基因组分成多份同时运行
#--species=$prefix 为训练集的名字
@name_sample=('01','02','03','04','05','06','07','08');
foreach $name (@name_sample){
        open(OUT,">augustus-${name}.sh");
        print OUT "
#augustus-${name}
date
augustus --species=name --gff3=on SH.genome.fasta-part${name}.mask > SH.genome.fasta-part${name}.gff
date
";
        close OUT;
    my $cc=`nohup sh augustus-${name}.sh > augustus-${name}.nohup 2>&1 &`;
        }
#将产生的gff文件合并到一起
cat genome.fasta-part*.gff > temp.gff
/augustus-3.2.3/scripts/join_aug_pred.pl < temp.gff  | grep -v '^#' > temp.joined.gff
bedtools sort -i temp.joined.gff > augustsus.gff
perl /EVidenceModeler-1.1.1/EvmUtils/misc/augustus_GFF3_to_EVM_GFF3.pl augustsus.gff >evm.ausustsus.gff
