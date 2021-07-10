#!/bin/bash
#$ -S /bin/bash
#$ -o /wynton/home/corces/allan/BPMVF/scripts/job_output
#$ -cwd
#$ -j y
#$ -l mem_free=20G
#$ -l h_rt=48:00:00

rgt-hint footprinting --atac-seq --paired-end --organism=hg38 --output-location=/wynton/home/corces/allan/BPMVF/ATAC/HINT --output-prefix=C24onSGE Cluster24.sorted.bam Cluster24.idr.optimal.narrowPeak