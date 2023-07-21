#!/usr/bin/env bash

#$ -cwd
#$ -N fasqc_fd
#$ -q short-sl7
#$ -j y
#$ -l h_rt=00:15:00
#$ -l virtual_free=2G
#$ -pe smp 1

module load FastQC/0.11.9-Java-11

SEQ_F=$1 # folder with the sequences
OUTDIR=$PWD/outfolder/fastqc

mkdir -p $OUTDIR

fastqc $SEQ_F/*.fastq.gz -o $OUTDIR
