
#!/bin/bash

BASE_DIR=***Insert base directory path.***
PREDICTIONS_DIR=$BASE_DIR/predictions
DATA_DIR=$BASE_DIR/data
BOUNDS_DIR=$BASE_DIR/bounds
METRICS_DIR=$BASE_DIR/metrics
MODEL_DIR=$BASE_DIR/model

INPUT_BW=$DATA_DIR/signal.bw
PEAKS_F=$DATA_DIR/Cluster24.idr.optimal.narrowPeak

REFERENCE_DIR=***Insert reference directory path.***
CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta

SHAP_DIR=$BASE_DIR/shap
mkdir -p $SHAP_DIR

shap_scores \
    --reference-genome $REFERENCE_GENOME \
    --model $MODEL_DIR/***Insert model name here with .h5*** \
    --bed-file $PEAKS_F \
    --chroms chr1 \
    --output-dir $SHAP_DIR \
    --input-seq-len 2114 \
    --control-len 1000 \
    --task-id 0 \
    --control-info $INPUT_DATA



