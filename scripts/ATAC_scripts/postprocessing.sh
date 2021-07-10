#!/bin/bash
#$ -S /bin/bash
#$ -o /wynton/home/corces/allan/BPMVF/scripts/job_output
#$ -cwd
#$ -j y
#$ -l mem_free=10G
#$ -l h_rt=24:00:00

BASE_DIR=/wynton/home/corces/allan/BPMVF/ATAC
REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference

DATA_DIR=$BASE_DIR/data
MODEL_DIR=$BASE_DIR/model
PREDICTIONS_DIR=$BASE_DIR/predictions
BOUNDS_DIR=$BASE_DIR/bounds
METRICS_DIR=$BASE_DIR/metrics
SHAP_DIR=$BASE_DIR/shap

INPUT_DATA=$BASE_DIR/input_data.json
CV_SPLITS=$BASE_DIR/splits.json
PEAKS_F=$DATA_DIR/peaks/Cluster24.idr.optimal.narrowPeak
INPUT_BW=$DATA_DIR/Cluster24.bpnet.unstranded.bw

CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa

INPUT_SEQ_LEN=2114
OUTPUT_LEN=1000

mkdir -p $PREDICTIONS_DIR
mkdir -p $BOUNDS_DIR
mkdir -p $METRICS_DIR
mkdir -p $SHAP_DIR

predict \
    --model $MODEL_DIR/bpnet.256.100.001.01_split000.h5 \
    --chrom-sizes $CHROM_SIZES \
    --chroms chr1 \
    --reference-genome $REFERENCE_GENOME \
    --exponentiate-counts \
    --output-dir $PREDICTIONS_DIR \
    --input-data $INPUT_DATA \
    --input-seq-len $INPUT_SEQ_LEN \
    --output-len $OUTPUT_LEN \
    --output-window-size $OUTPUT_LEN \
    --write-buffer-size 4000 \
    --batch-size 1  \
    --predict-peaks

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

bounds \
    --input-profiles $INPUT_BW \
    --output-names bounds \
    --output-directory $BOUNDS_DIR \
    --peaks $PEAKS_F \
    --chroms chr1

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

shap_scores \
    --reference-genome $REFERENCE_GENOME \
    --model $MODEL_DIR/bpnet.256.100.001.01_split000.h5 \
    --bed-file $PEAKS_F \
    --chroms chr1 \
    --output-dir $SHAP_DIR \
    --input-seq-len 2114 \
    --control-len 1000 \
    --task-id 0 \
    --control-info $INPUT_DATA

peaks_valid_scores=$SHAP_DIR/peaks_valid_scores.bed
counts_scores_h5=$SHAP_DIR/counts_scores.h5
counts_out_pfx=$SHAP_DIR/count_scores

python importance_hdf5_to_bigwig_v2.py \
    -h5 $counts_scores_h5 \
    -r $peaks_valid_scores \
    -c $CHROM_SIZES \
    -o $counts_out_pfx.bw \
    -s $counts_out_pfx.stats.txt \
    -t 1

profile_scores_h5=$SHAP_DIR/profile_scores.h5
profile_out_pfx=$SHAP_DIR/profile_scores

python importance_hdf5_to_bigwig_v2.py \
    -h5 $profile_scores_h5 \
    -r $peaks_valid_scores \
    -c $CHROM_SIZES \
    -o $profile_out_pfx.bw \
    -s $profile_out_pfx.stats.txt \
    -t 1
