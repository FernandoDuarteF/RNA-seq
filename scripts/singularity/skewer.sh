#!/usr/bin/env bash

#$ -cwd
#$ -N skewer_fd
#$ -q short-sl7
#$ -j y
#$ -o /users/bi/fduarte/RNAseq-course/logs/
#$ -l h_rt=00:30:00
#$ -l virtual_free=2G
#$ -pe smp 1

F=$1 # only enter forward read
ADAPT=$2
R=${F%_1.fastq.gz}_2.fastq.gz
ID=$(basename "$F" _1.fastq.gz)
OUTDIR=$PWD/outfolder/trimmed_reads


echo $F $R $ID

mkdir -p $OUTDIR

cd $OUTDIR

$RUN skewer -m pe $F $R -y $ADAPT -Q 10 -z -o ${ID}
