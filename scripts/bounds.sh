#!/bin/bash

BASE_DIR=/Users/alexlan/Desktop/Research/BPMVF/ENCSR000EGM
REFERENCE_DIR=/Users/alexlan/Desktop/Research/BPMVF/reference
DATA_DIR=$BASE_DIR/data
MODEL_DIR=$BASE_DIR/models
CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa
CV_SPLITS=$BASE_DIR/splits.json
INPUT_DATA=$BASE_DIR/input_data.json
PREDICTIONS_DIR=$BASE_DIR/predictions
BOUNDS_DIR=$BASE_DIR/bounds

bounds \
    --input-profiles $DATA_DIR/plus.bw $DATA_DIR/minus.bw \
    --output-names task0_plus task0_minus \
    --output-directory $BOUNDS_DIR \
    --peaks $DATA_DIR/peaks.bed \
    --chroms chr1
