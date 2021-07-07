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
SHAP_DIR=$BASE_DIR/shap
MODISCO_PROFILE_DIR=$BASE_DIR/modisco_profile
MODISCO_COUNTS_DIR=$BASE_DIR/modisco_counts

motif_discovery \
    --scores-path $SHAP_DIR/profile_scores.h5 \
    --output-directory $MODISCO_PROFILE_DIR

motif_discovery \
    --scores-path $SHAP_DIR/counts_scores.h5 \
    --output-directory $MODISCO_COUNTS_DIR
