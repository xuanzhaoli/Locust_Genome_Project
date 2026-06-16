genome=locust.genomic.fna
prefix=locust
CPU=6
# 2. LTRfinder
mkdir 02-LTRfinder
cd 02-LTRfinder
seqkit split -i ../$genome
function run_ltrfinder() {
  ltr_finder_cmd=ltr_finder.cmd
  ls ../$genome.split | while read line
  do
    idnum=${line/$genome.id_/}
    idnum=${idnum/.fasta/}
    echo "ltr_finder -D 15000 -d 1000 -L 7000 -l 100 -p 20 -C -M 0.9 ../$genome.split/${line} > $prefix.finder.${idnum}.scn" >>$ltr_finder_cmd
    echo $idnum
  done

  ParaFly -CPU $CPU -c $ltr_finder_cmd
}
run_ltrfinder
cat $prefix.finder.*.scn >$prefix.finder.scn
cd ..
