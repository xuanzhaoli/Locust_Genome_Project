!/bin/bash
#################################################################
#   			    Hic step 1
#################################################################



refname=locust	#名字
originalref=ctg.fa	#contig级别基因组位置
R1Reads=L1_1.fq.gz #HiC 测序R1端数据
R2Reads=L1_2.fq.gz #HiC 测序R2端数据
enzyme=MboI	#HiC测序中用到的酶
shortname=SH	#名字



 [ -d references        ] || mkdir -p references
 [ -d restriction_sites ] || mkdir -p restriction_sites
 [ -d ./Assembly/fastq  ] || mkdir -p ./Assembly/fastq

 cd references
 ln -s ${originalref} ${refname}.fasta
 cat ${refname}.fasta | sed 's/[ ].*//' | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' > ${refname}.fasta.ref
bwa index -a bwtsw ${refname}.fasta
 cd ..

cd restriction_sites
time python2.7 /lixz/script/assembly/generate_site_positions.py ${enzyme} ${shortname} ../references/${refname}.fasta
cd ..

cd ./Assembly/fastq
ln -s $R1Reads L01_R1.fastq.gz
ln -s $R2Reads L01_R2.fastq.gz
