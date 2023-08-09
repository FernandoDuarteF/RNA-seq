#!/usr/bin/env bash

#$ -cwd
#$ -N staridx_fd
#$ -q short-sl7,long-sl7,biocore-el7
#$ -j y
#$ -o /users/bi/fduarte/RNAseq-course/logs/
#$ -l h_rt=01:00:00
#$ -l virtual_free=32G
#$ -pe smp 8

FASTA=$1
GTF=$2

mkdir -p GRCh38_index

$RUN STAR --runThreadN 8 \
--runMode genomeGenerate \
--genomeDir GRCh38_index \
--genomeFastaFiles $FASTA \
--sjdbGTFfile $GTF
