!/bin/bash
#################################################################
#                           Hic step 2
#################################################################


refname=locust
originalref=ctg.fa
R1Reads=R1.fastq	#HiC 测序R1端数据
R2Reads=R2.fastq	#HiC 测序R2端数据


enzyme=MboI
shortname=locust

workdir=`pwd`

time bash /lixz/HiC/scripts/juicer.sh \
        -D ${workdir} \
        -d ${workdir}/Assembly \
        -t 12 \
        -s ${enzyme} \
        -g ${shortname} \
	-y ./restriction_sites/${shortname}_MboI.txt \
        -z ./references/${refname}.fasta \
        -p ./references/${refname}.fasta.ref
