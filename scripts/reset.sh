#!/bin/bash

BASE_DIR=/Users/alexlan/Desktop/Research/BPMVF/ENCSR000EGM
REFERENCE_DIR=/Users/alexlan/Desktop/Research/BPMVF/reference
DEPLOY_DIR=/Users/alexlan/Desktop/Research/BPMVF/deployment
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

rm -r $PREDICTIONS_DIR
rm -r $SHAP_DIR

rm $DEPLOY_DIR/static/images/countsimp0.png
rm $DEPLOY_DIR/static/images/profileimp0.png

mkdir $BASE_DIR/predictions
mkdir $BASE_DIR/shap