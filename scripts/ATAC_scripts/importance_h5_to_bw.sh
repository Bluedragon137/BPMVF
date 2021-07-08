#!/bin/bash
#$ -S /bin/bash
#$ -o /wynton/home/corces/allan/BPMVF/scripts/job_output
#$ -cwd
#$ -j y
#$ -l mem_free=10G
#$ -l h_rt=4:00:00

BASE_DIR=/wynton/home/corces/allan/BPMVF/ATAC
REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference
PREDICTIONS_DIR=$BASE_DIR/predictions
DATA_DIR=$BASE_DIR/data
BOUNDS_DIR=$BASE_DIR/bounds
METRICS_DIR=$BASE_DIR/metrics
MODEL_DIR=$BASE_DIR/model
SHAP_DIR=$BASE_DIR/shap

INPUT_BW=$DATA_DIR/Cluster24.bpnet.unstranded.bw
PEAKS_DIR=$DATA_DIR/peaks
PEAKS_F=$PEAKS_DIR/Cluster24.idr.optimal.narrowPeak

CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa

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
