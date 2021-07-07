BASE_DIR=***Insert base directory path***
DATA_DIR=$BASE_DIR/data
MODEL_DIR=$BASE_DIR/model
PREDICTIONS_DIR=$BASE_DIR/predictions 
INPUT_DATA=$BASE_DIR/input_data.json

REFERENCE_DIR=***Insert reference directory path***
CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta

INPUT_SEQ_LEN=2114
OUTPUT_LEN=1000

mkdir -p $PREDICTIONS_DIR
predict \
    --model $MODEL_DIR/***Insert model name here with .h5*** \
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