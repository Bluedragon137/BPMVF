#!/bin/bash

BASE_DIR=***Insert base directory path.***
REFERENCE_DIR=***Insert reference directory path.***
PREDICTIONS_DIR=$BASE_DIR/predictions

DATA_DIR=$BASE_DIR/data
PEAKS_F=$DATA_DIR/Cluster24.idr.optimal.narrowPeak

REFERENCE_DIR=/mnt/lab_data3/jelenter/reference/
CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta

LOGITS_FILE=$PREDICTIONS_DIR/***Insert logits file '...split000_task0.bw'***
COUNTS_FILE=$PREDICTIONS_DIR/***Insert counts file '...split000_task0_exponentiated_counts.bw'***

logits2profile \
        --logits-file $LOGITS_FILE \
        --counts-file $COUNTS_FILE \
        --output-directory $PREDICTIONS_DIR \
        --output-filename predicted_profile \
        --peaks $PEAKS_F \
        --chroms chr1 \
        --chrom-sizes $CHROM_SIZES
