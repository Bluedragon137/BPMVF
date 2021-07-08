#!/bin/bash

BASE_DIR=/wynton/home/corces/allan/BPMVF/ATAC
REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference
PREDICTIONS_DIR=$BASE_DIR/predictions
DATA_DIR=$BASE_DIR/data
BOUNDS_DIR=$BASE_DIR/bounds
METRICS_DIR=$BASE_DIR/metrics

INPUT_BW=$DATA_DIR/Cluster24.bpnet.unstranded.bw
PEAKS_DIR=$DATA_DIR/peaks
PEAKS_F=$PEAKS_DIR/Cluster24.idr.optimal.narrowPeak

CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa

LOGITS_FILE=$PREDICTIONS_DIR/'bpnet_task0.bw'
COUNTS_FILE=$PREDICTIONS_DIR/'bpnet_task0_exponentiated_counts.bw'

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
    -B $LOGITS_FILE \
    --peaks $PEAKS_F \
    --chroms chr1  \
    --output-dir $METRICS_DIR \
    --apply-softmax-to-profileB \
    --countsB $COUNTS_FILE \
    --chrom-sizes $CHROM_SIZES \
    --bounds-csv $BOUNDS_DIR/bounds.bds \
    --exclude-zero-profiles