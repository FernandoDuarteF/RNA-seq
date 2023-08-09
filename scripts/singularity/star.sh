#!/usr/bin/env bash

#$ -cwd
#$ -N star_fd
#$ -q short-sl7,long-sl7,biocore-el7
#$ -j y
#$ -o /users/bi/fduarte/RNAseq-course/logs/
#$ -l h_rt=01:00:00
#$ -l virtual_free=32G
#$ -pe smp 8

INDEX=$1 # index directory
F=$2 # only enter forward read
R=${F%-pair1.fastq.gz}-pair2.fastq.gz
ID=$(basename "$F" -trimmed-pair1.fastq.gz)
OUTDIR=$PWD/outfolder/STAR

mkdir -p $OUTDIR

$RUN STAR --genomeDir $INDEX \
      --readFilesIn $F $R \
      --readFilesCommand zcat \
      --outSAMtype BAM SortedByCoordinate \
      --quantMode GeneCounts \
      --outFileNamePrefix $OUTDIR/$ID
