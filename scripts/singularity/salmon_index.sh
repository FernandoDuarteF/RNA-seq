#!/usr/bin/env bash

#$ -cwd
#$ -N salmonidx_fd
#$ -q short-sl7,long-sl7,biocore-el7
#$ -j y
#$ -o /users/bi/fduarte/RNAseq-course/logs/
#$ -l h_rt=01:00:00
#$ -l virtual_free=12G
#$ -pe smp 4

TRANS=$1

# index and store the index files in index_salmon folder
$RUN salmon index -t $TRANS -i index_salmon -p 4 --gencode
