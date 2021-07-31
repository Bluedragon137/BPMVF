#!/bin/bash
#$ -S /bin/bash
#$ -o /wynton/home/corces/allan/BPMVF/scripts/ATAC_scripts/negative-control/job_output
#$ -cwd
#$ -j y
#$ -l mem_free=20G
#$ -l h_rt=24:00:00

BASE_DIR=/wynton/home/corces/allan/BPMVF/neg-control
DATA_DIR=$BASE_DIR/data
MODEL_DIR=$BASE_DIR/models
REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference
CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa
INPUT_BW=$DATA_DIR/Cluster24.bpnet.unstranded.bw


#modify between runs:
MODEL=$MODEL_DIR/bpm24.nc10.local_split000.h5
SUB_DIR=$BASE_DIR/m2.10
PREDICTIONS_DIR=$SUB_DIR/predictions100
BOUNDS_DIR=$SUB_DIR/bounds100
METRICS_DIR=$SUB_DIR/metrics100
INPUT_DATA=$BASE_DIR/parameters/input_data100.json
PEAKS_F=$DATA_DIR/peaks_df_deduped100.bed

LOGITS_FILE=$PREDICTIONS_DIR/'bpm24_task0.bw'
COUNTS_FILE=$PREDICTIONS_DIR/'bpm24_task0_exponentiated_counts.bw'


INPUT_SEQ_LEN=2114
OUTPUT_LEN=1000

mkdir -p $PREDICTIONS_DIR
predict \
    --model $MODEL \
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