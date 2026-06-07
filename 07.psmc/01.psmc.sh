#!/usr/bin/env bash
# ------------------------------------------

#1.index for reference genome
bwa index locust_genome.chr.final.fasta

#2.mapping
bwa mem -t 40 -R '@RG\tID:${name}\tPL:Illumina\tSM:${name}' locust_genome.chr.final.fasta ${name}_1.fq.gz ${name}_2.fq.gz | samtools view -bS -o ${name}.bam

#3.sort
samtools sort -@ 20 -o ${name}.sort.bam ${name}.bam

#4.rmdup
samtools rmdup ${name}.sort.bam ${name}.sort.rmdup.bam

#5.index
/share/home/software/software/samtools-1.3.1/samtools index -c ${name}.sort.rmdup.bam

#6.call snp
samtools mpileup -C50 -uf locust_genome.chr.final.fasta ${name}.sort.rmdup.bam |  bcftools call -c | vcfutils.pl vcf2fq -d 10 -D 100 | gzip > ${name}.diploid.fq.gz

#7.fq2psmcfa
fq2psmcfa -q20 ${name}.diploid.fq.gz > ${name}.diploid.psmcfa

#8.psmc
psmc -N30 -t15 -r5 -p "4+25*2+4+6" -o ${name}.diploid.psmc ${name}.diploid.psmcfa

#9.plot
psmc_plot.pl -p ${name} ${name}.diploid.psmc
