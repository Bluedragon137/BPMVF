#!/bin/bash

BASE_DIR=/wynton/home/corces/allan/BPMVF/ATAC
REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference
PREDICTIONS_DIR=$BASE_DIR/predictions

DATA_DIR=$BASE_DIR/data
PEAKS_DIR=$DATA_DIR/peaks
PEAKS_F=$PEAKS_DIR/Cluster24.idr.optimal.narrowPeak

CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa

LOGITS_FILE=$PREDICTIONS_DIR/'bpnet_task0.bw'
COUNTS_FILE=$PREDICTIONS_DIR/'bpnet_task0_exponentiated_counts.bw'

logits2profile \
        --logits-file $LOGITS_FILE \
        --counts-file $COUNTS_FILE \
        --output-directory $PREDICTIONS_DIR \
        --output-filename predicted_profile \
        --peaks $PEAKS_F \
        --chroms chr1 \
        --chrom-sizes $CHROM_SIZES
