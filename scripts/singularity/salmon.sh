#!/usr/bin/env bash

#$ -cwd
#$ -N salmon_fd
#$ -q short-sl7,long-sl7,biocore-el7
#$ -j y
#$ -o /users/bi/fduarte/RNAseq-course/logs/
#$ -l h_rt=01:00:00
#$ -l virtual_free=32G
#$ -pe smp 8

INDEX=$1 # index directory
F=$2 # only enter forward read
GTF=$3
LIB=$4
R=${F%-pair1.fastq.gz}-pair2.fastq.gz
ID=$(basename "$F" -trimmed-pair1.fastq.gz)
OUTDIR=$PWD/outfolder/salmon

$RUN salmon quant -i $INDEX -l $LIB -1 $F -2 $R -o $OUTDIR/$ID -g $GTF -p 8 --seqBias --validateMappings
