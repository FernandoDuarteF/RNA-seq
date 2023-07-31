#!/usr/bin/env bash

#$ -cwd
#$ -N fasqc_fd
#$ -q short-sl7
#$ -j y
#$ -o /users/bi/fduarte/RNAseq-course/logs/
#$ -l h_rt=00:30:00
#$ -l virtual_free=2G
#$ -pe smp 1

module load FastQC/0.11.9-Java-11

SEQS=$1 # folder with the sequences
OUTDIR_fqc=$PWD/outfolder/fastqc
OUTDIR_mqc=$PWD/outfolder/multiqc

mkdir -p $OUTDIR_fqc # FastQC cannot create folder

$RUN fastqc ${SEQS}/*.fastq.gz -o $OUTDIR_fqc

$RUN_MQC multiqc -f $OUTDIR_fqc -o $OUTDIR_mqc
