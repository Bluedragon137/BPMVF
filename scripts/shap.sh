#!/bin/bash

BASE_DIR=/wynton/home/corces/allan/BPMVF/ENCSR000EGM
DATA_DIR=$BASE_DIR/data
MODEL_DIR=$BASE_DIR/models
REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference
CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa
CV_SPLITS=$BASE_DIR/splits.json
INPUT_DATA=$BASE_DIR/input_data.json
PREDICTIONS_DIR=$BASE_DIR/predictions
BOUNDS_DIR=$BASE_DIR/bounds
METRICS_DIR=$BASE_DIR/metrics
SHAP_DIR=$BASE_DIR/shap

shap_scores \
    --reference-genome $REFERENCE_GENOME \
    --model $(ls $MODEL_DIR/model_split000.h5) \
    --bed-file $DATA_DIR/peaks.bed \
    --chroms chr1 \
    --output-dir $SHAP_DIR \
    --input-seq-len 2114 \
    --control-len 1000 \
    --control-smoothing 7.0 81 \
    --task-id 0 \
    --control-info $INPUT_DATA
