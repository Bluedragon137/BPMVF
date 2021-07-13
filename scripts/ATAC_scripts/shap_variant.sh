#!/bin/bash
#$ -S /bin/bash
#$ -o /wynton/home/corces/allan/BPMVF/scripts/job_output
#$ -cwd
#$ -j y
#$ -l mem_free=20G
#$ -l h_rt=24:00:00

BASE_DIR=/wynton/home/corces/allan/BPMVF/ATAC
REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference
PREDICTIONS_DIR=$BASE_DIR/predictions
DATA_DIR=$BASE_DIR/data
BOUNDS_DIR=$BASE_DIR/bounds
METRICS_DIR=$BASE_DIR/metrics
MODEL_DIR=$BASE_DIR/model

INPUT_DATA=$BASE_DIR/input_data_var.json
CV_SPLITS=$BASE_DIR/splits.json

INPUT_BW=$DATA_DIR/Cluster24.bpnet.unstranded.bw
PEAKS_DIR=$DATA_DIR/peaks
PEAKS_F=$PEAKS_DIR/rs1237999.bed
# PEAKS_F=$PEAKS_DIR/Cluster24.idr.optimal.narrowPeak
# PEAKS_DIR=$BASE_DIR/HINT
# PEAKS_F=$PEAKS_DIR/C24_full.bed

CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa

SHAP_DIR=$BASE_DIR/shap
mkdir -p $SHAP_DIR

var_shap \
    --reference-genome $REFERENCE_GENOME \
    --model $MODEL_DIR/bpnet-hint.256.100.001_split000.h5 \
    --bed-file $PEAKS_F \
    --output-dir $SHAP_DIR \
    --input-seq-len 2114 \
    --control-len 1000 \
    --task-id 0 \
    --control-info $INPUT_DATA