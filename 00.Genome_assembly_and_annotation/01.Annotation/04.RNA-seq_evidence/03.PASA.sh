#将屏蔽的基因组、组装好的转录本、以及配置文件sqlite.confs放在同一个文件夹下面
mkdir sample_data
cd sample_data
pwd
#/***/***/sample_data
cp *genome.fasta.masked *allTrinity.fa /***/***/sample_data
cp -r sqlite.confs /***/***/sample_data
#运行PASA
$ docker run --rm -it -v /tmp:/tmp \
    -v /***/***/sample_data:/***/***/sample_data \
    pasapipeline/pasapipeline:latest 
#这里需要注意的是：如果不是第一次跑的话，要进入/tmp目录下将sample_mydb_pasa.sqlite删除，否则会报错。
$ cd /tmp
$ rm sample_mydb_pasa.sqlite
$ cd /***/***/sample_data
$ /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
    -c sqlite.confs/alignAssembly.config -C -R --ALIGNER gmap \
    -g *.genome.fasta.masked -t *allTrinity.fa
$ /usr/local/src/PASApipeline/scripts/pasa_asmbls_to_training_set.dbi \
    --pasa_transcripts_fasta sample_mydb_pasa.sqlite.assemblies.fasta \
    --pasa_transcripts_gff3 sample_mydb_pasa.sqlite.pasa_assemblies.gff3 
    
#产生的结果文件为：用于EVM合并的文件：sample_mydb_pasa.sqlite.pasa_assemblies.gff3
#                 用于AUGUSTUS从头预测的文件：sample_mydb_pasa.sqlite.assemblies.fasta.transdecoder.genome.gff3
