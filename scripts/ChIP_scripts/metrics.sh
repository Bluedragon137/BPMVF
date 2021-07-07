#!/bin/bash

BASE_DIR=/Users/alexlan/Desktop/Research/BPMVF/ENCSR000EGM
REFERENCE_DIR=/Users/alexlan/Desktop/Research/BPMVF/reference
# BASE_DIR=/wynton/home/corces/allan/BPMVF/ENCSR000EGM
# REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference
DATA_DIR=$BASE_DIR/data
MODEL_DIR=$BASE_DIR/models
CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa
CV_SPLITS=$BASE_DIR/splits.json
INPUT_DATA=$BASE_DIR/input_data.json
PREDICTIONS_DIR=$BASE_DIR/predictions
BOUNDS_DIR=$BASE_DIR/bounds
METRICS_DIR=$BASE_DIR/metrics

#for plus strand
metrics \
   -A $DATA_DIR/plus.bw \
   -B $PREDICTIONS_DIR/model_split000_task0_plus.bw \
   --peaks $DATA_DIR/peaks.bed \
   --chroms chr1 \
   --output-dir $METRICS_DIR \
   --apply-softmax-to-profileB \
   --countsB $PREDICTIONS_DIR/model_split000_task0_plus_exponentiated_counts.bw \
   --chrom-sizes $CHROM_SIZES

#for minus strand
metrics \
   -A $DATA_DIR/minus.bw \
   -B $PREDICTIONS_DIR/model_split000_task0_minus.bw \
   --peaks $DATA_DIR/peaks.bed \
   --chroms chr1 \
   --output-dir $METRICS_DIR \
   --apply-softmax-to-profileB \
   --countsB $PREDICTIONS_DIR/model_split000_task0_minus_exponentiated_counts.bw \
   --chrom-sizes $CHROM_SIZES
