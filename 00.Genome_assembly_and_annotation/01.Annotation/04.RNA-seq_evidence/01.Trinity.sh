#有参转录组组装
genome='locust.genomic.fna';
name='locust';
mkdir index
mkdir result
hisat2-build $genome index/$name
#使用hisat2-build对参考基因组建立索引
hisat2 -p 36 -x index/$name -1 r_1.clean.fq.gz -2 r_2.clean.fq.gz -S result/$name.sam
#输入转录组数据，进行比对
samtools sort -@ 24 result/locust.sam -o result/locust.sort.bam
#####同时该文件也作为后续stringtie、TransDecoder流程中的输入文件#####

#排序
cd result
Trinity --genome_guided_bam locust.sort.bam --max_memory 80G --genome_guided_max_intron 10000 --CPU 10
#使用Trinity进行组装
#产生的结果文件在trinity_out_dir/Trinity-GG.fasta
#使用无参转录组或者有参转录组生成的转录本组装结果作为PASA的输入文件
