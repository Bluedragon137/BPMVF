#!/bin/bash

BASE_DIR=/wynton/home/corces/allan/BPMVF/neg-control
SUB_DIR=$BASE_DIR/model.00
REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference
PREDICTIONS_DIR=$SUB_DIR/predictions
DATA_DIR=$BASE_DIR/data
BOUNDS_DIR=$SUB_DIR/bounds
METRICS_DIR=$SUB_DIR/metrics

INPUT_BW=$DATA_DIR/Cluster24.bpnet.unstranded.bw
PEAKS_F=$DATA_DIR/peaks_df_deduped0.20.bed

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