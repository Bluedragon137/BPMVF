#!/bin/bash

BASE_DIR=***Insert base directory path.***
PREDICTIONS_DIR=$BASE_DIR/predictions
DATA_DIR=$BASE_DIR/data
BOUNDS_DIR=$BASE_DIR/bounds
METRICS_DIR=$BASE_DIR/metrics
MODEL_DIR=$BASE_DIR/model
SHAP_DIR=$BASE_DIR/shap

INPUT_BW=$DATA_DIR/signal.bw
PEAKS_F=$DATA_DIR/Cluster24.idr.optimal.narrowPeak

REFERENCE_DIR=***Insert reference directory path.***
CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta

peaks_valid_scores=$SHAP_DIR/peaks_valid_scores.bed
counts_scores_h5=$SHAP_DIR/counts_scores.h5
counts_out_pfx=$SHAP_DIR/count_scores

python importance_hdf5_to_bigwig_v2.py \
    -h5 $counts_scores_h5 \
    -r $peaks_valid_scores \
    -c $chorm_sizes \
    -o $counts_out_pfx.bw \
    -s $counts_out_pfx.stats.txt \
    -t 1

profile_scores_h5=$SHAP_DIR/profile_scores.h5
profile_out_pfx=$SHAP_DIR/profile_scores

python importance_hdf5_to_bigwig_v2.py \
    -h5 $profile_scores_h5 \
    -r $peaks_valid_scores \
    -c $chorm_sizes \
    -o $profile_out_pfx.bw \
    -s $profile_out_pfx.stats.txt \
    -t 1
