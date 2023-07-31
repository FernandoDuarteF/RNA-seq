## RNA-seq course

### 18/07/2023

Sequequences were downloaded from ENA (project name PRJNA493745). View Zotero for the paper in folder ```RNAseq trainning```. Download commands were obtained for ENA and cluster options were added to the ```.sh``` file. Commnads are stored in ```sequences/ena-file-download-20230718-1222.sh```, the other ```*.sh``` files are possible alternatives for downloading.

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

```
export RUN="singularity exec -e $HOME/RNAseq-course/containers/rnaseq2020_1.0.sif"
```
Now commands can be run using ```$RUN programname --help```.

FastQC can be run using:

```
qsub scripts/singularity/fastqc.sh test
```

For a large number of files, it might be a good idea to run multiqc. Since it's not iside the container, we can pull a new container:

```
Singularity pull docker://ewels/multiqc:latest
```

Add it to ```.bashrc``` as above, in this case, the environment variable name is ```$RUN_MQC```. You can modfy the script ```fastqc.sh``` to include multiqc.

### 27/07/2023

Useful tip. When pulling a container using singularity, you can add a custom name to the image. Example:

```
singularity pull skewer.sif https://depot.galaxyproject.org/singularity/skewer:0.2.2--hc9558a2_3
``` 

This image is now in ``contaiers`` folder, although it might not be useful.

For trimming the reads, skewer was used. Check parameters in ``scripts/singularity/skewer.sh``. The next line was run:

```
for i in $PWD/test/*_1.fastq.gz; do qsub scripts/singularity/skewer.sh $i; done
```
To understand skewer output, check log files as well as run FastQC and multiQC again:

```
qsub scripts/singularity/fastqc.sh outfolder/trimmed_reads/
```
In case of skewer, you will see in the log something like this:

```
  12372 ( 1.24%) trimmed read pairs available after processing
 987623 (98.76%) untrimmed read pairs available after processing

```

This means that 1.24% reads pairs had their adapters removed, whereas in 98.76% of the reads no adapter was found.

### 31/07/2023

Let's check both aligners: STAR and Salmon (pseudoaligner). Donwload data for aligners using:

```
# genome
wget ftp://ftp.ensembl.org/pub/release-99/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_rm.primary_assembly.fa.gz

# transcriptome
wget ftp://ftp.ensembl.org/pub/release-99/fasta/homo_sapiens/cds/Homo_sapiens.GRCh38.cds.all.fa.gz

# annotation
wget ftp://ftp.ensembl.org/pub/release-99/gtf/homo_sapiens/Homo_sapiens.GRCh38.99.chr.gtf.gz
```


