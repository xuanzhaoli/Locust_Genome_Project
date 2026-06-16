ln -s evm.ausustsus.gff gene_predictions.gff3  
ln -s sample_mydb_pasa.sqlite.pasa_assemblies.gff3 transcript_alignments.gff3
ln -s evm.genomeThreader.gff protein_alignments.gff3
#
perl /mnt/lixuanzhao/software/EVidenceModeler/EvmUtils/partition_EVM_inputs.pl --genome locust.genomic.fna --gene_predictions gene_predictions.gff3 --protein_alignments protein_alignments.gff3 --transcript_alignments transcript_alignments.gff3 --segmentSize 100000 --overlapSize 10000 --partition_listing partitions_list.out
#
perl /mnt/lixuanzhao/software/EVidenceModeler/EvmUtils/write_EVM_commands.pl --genome locust.genomic.fna --weights `pwd`/weights.txt --gene_predictions gene_predictions.gff3 --protein_alignments protein_alignments.gff3 --transcript_alignments transcript_alignments.gff3 --output_file_name evm.out  --partitions partitions_list.out >  commands.list
ParaFly -c commands.list -CPU 30 -v &> commands.log
#
perl /mnt/lixuanzhao/software/EVidenceModeler/EvmUtils/recombine_EVM_partial_outputs.pl --partitions partitions_list.out --output_file_name evm.out
perl /mnt/lixuanzhao/software/EVidenceModeler/EvmUtils/convert_EVM_outputs_to_GFF3.pl --partitions partitions_list.out --output_file_name evm.out --genome locust.genomic.fna
#
find . -regex ".*evm.out.gff3" -exec cat {} \; | bedtools sort -i - > EVM.all.gff
gffread EVM.all.gff -g locust.genomic.fna -y tr_pep.fa -x cds.fa
