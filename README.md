## RNA-seq course

### 18/07/2023

Sequequences were downloaded from ENA (project name PRJNA493745). View Zotero for the paper in folder ```RNAseq trainning```. Download commands were obtained for ENA and cluster options were added to the ```.sh``` file. Commnads are stored in ```ena-file-download-20230718-1222.sh```, the other ```*.sh``` files are possible alternatives for downloading.

### 19/07/2023

Sequences were downloaded successfully. Checked the number of reads for each sequence by doing:

```
for i in *.fastq.gz; do echo $i; echo $(zcat $i | wc -l)/4 | bc; done
```

Results are stored in ```sequences/number_reads```. Since files have a lot of reads, it might be a good idea to take a subset of one million reads in order to test our pipeline. We can take two samples

```
mkdir test
cd test
# Select subset. In this case, the first 4 samples:
ls ../sequences/*.fastq.gz | head -n 4 > subset
# Subsample one million reads and generate new .fastq files:
while read -r line; do zcat $line | sed -n 1,4000000p > $(basename "$line" .fastq.gz).fastq & done < subset >log&
# Also compress files for extension consistency:
for i in *.fastq; do gzip $i; done
```
### 21/07/2023

Instead of modules, we are going to use singularity containers:

```
mkdir containers
cd containers
singularity pull docker://biocorecrg/rnaseq2020:1.0
```

Add this to your ```.bashrc```:


