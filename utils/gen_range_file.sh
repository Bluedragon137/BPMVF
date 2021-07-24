#!/bin/bash
#$ -S /bin/bash
#$ -o /wynton/home/corces/allan/BPMVF/scripts/job_output
#$ -cwd
#$ -j y
#$ -l mem_free=20G
#$ -l h_rt=48:00:00

python3 gen_ranges.py