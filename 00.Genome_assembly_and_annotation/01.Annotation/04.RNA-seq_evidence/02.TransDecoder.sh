genome='locust.genomic.fna';
name='locust';
stringtie -P 8 -o result/$name.gtf result/$name.sort.bam
mkdir translocal
cd translocal
perl /TransDecoder-TransDecoder-v5.3.0/util/gtf_genome_to_cdna_fasta.pl ../result/$name.gtf $genome >transcripts.fasta
perl /TransDecoder-TransDecoder-v5.3.0/util/gtf_to_alignment_gff3.pl ../result/$name.gtf >transcripts.gff3
/TransDecoder-TransDecoder-v5.3.0/TransDecoder.LongOrfs -t transcripts.fasta
/TransDecoder-TransDecoder-v5.3.0/TransDecoder.Predict -t transcripts.fasta
perl /TransDecoder-TransDecoder-v5.3.0/util/cdna_alignment_orf_to_genome_orf.pl transcripts.fasta.transdecoder.gff3 transcripts.gff3 transcripts.fasta >transcripts.fasta.transdecoder.genome.gff3
