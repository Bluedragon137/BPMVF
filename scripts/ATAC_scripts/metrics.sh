#!/bin/bash

BASE_DIR=***Insert base directory path.***
PREDICTIONS_DIR=$BASE_DIR/predictions
DATA_DIR=$BASE_DIR/data
BOUNDS_DIR=$BASE_DIR/bounds
METRICS_DIR=$BASE_DIR/metrics


INPUT_BW=$DATA_DIR/signal.bw
PEAKS_F=$DATA_DIR/Cluster24.idr.optimal.narrowPeak

REFERENCE_DIR=***Insert reference directory path.***
CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta

LOGITS_FILE=$PREDICTIONS_DIR/***Insert logits file '...split000_task0.bw'***
COUNTS_FILE=$PREDICTIONS_DIR/***Insert counts file '...split000_task0_exponentiated_counts.bw'***

mkdir -p $BOUNDS_DIR
bounds \
    --input-profiles $INPUT_BW \
    --output-names bounds \
    --output-directory $BOUNDS_DIR \
    --peaks $PEAKS_F \
    --chroms chr1

mkdir -p $METRICS_DIR
metrics \
    -A $INPUT_BW \
    -B $PREDICTIONS_DIR/$LOGITS_FILE \
    --peaks $PEAKS_F \
    --chroms chr1  \
    --output-dir $METRICS_DIR \
    --apply-softmax-to-profileB \
    --countsB $PREDICTIONS_DIR/$COUNTS_FILE \
    --chrom-sizes $CHROM_SIZES \
    --bounds-csv $BOUNDS_DIR/bounds.bds \
    --exclude-zero-profiles