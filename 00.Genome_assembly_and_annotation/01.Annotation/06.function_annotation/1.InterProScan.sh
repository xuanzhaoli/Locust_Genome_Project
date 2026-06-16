mkdir pep
mkdir out
cp *.genome.final.pep.fa pep\
perl fasta-splitter.pl genome.final.pep.fa
cd ..
@name_sample=('01','02','03','04','05','06','07','08','09','10');
foreach $name (@name_sample){
    my $cc=`nohup /software/interproscan-5.55-88.0/interproscan.sh -appl Pfam -f TSV -i pep/genome.final.pep.part-${name}.fa -cpu 8 -b out/${name}.out -goterms -iprlookup -pa > ${name}.out 2>&1 &`;
        }
