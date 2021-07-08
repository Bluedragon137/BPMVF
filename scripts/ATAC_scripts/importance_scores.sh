#!/bin/bash
#$ -S /bin/bash
#$ -o /wynton/home/corces/allan/BPMVF/scripts/job_output
#$ -cwd
#$ -j y
#$ -l mem_free=10G
#$ -l h_rt=24:00:00

BASE_DIR=/wynton/home/corces/allan/BPMVF/ATAC
REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference
PREDICTIONS_DIR=$BASE_DIR/predictions
DATA_DIR=$BASE_DIR/data
BOUNDS_DIR=$BASE_DIR/bounds
METRICS_DIR=$BASE_DIR/metrics
MODEL_DIR=$BASE_DIR/model

INPUT_DATA=$BASE_DIR/input_data.json
CV_SPLITS=$BASE_DIR/splits.json

INPUT_BW=$DATA_DIR/Cluster24.bpnet.unstranded.bw
PEAKS_DIR=$DATA_DIR/peaks
PEAKS_F=$PEAKS_DIR/Cluster24.idr.optimal.narrowPeak

CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa

SHAP_DIR=$BASE_DIR/shap
mkdir -p $SHAP_DIR

shap_scores \
    --reference-genome $REFERENCE_GENOME \
    --model $MODEL_DIR/bpnet.256.15.001_split000.h5 \
    --bed-file $PEAKS_F \
    --chroms chr1 \
    --output-dir $SHAP_DIR \
    --input-seq-len 2114 \
    --control-len 1000 \
    --task-id 0 \
    --control-info $INPUT_DATA