#!/bin/bash

BASE_DIR=/Users/alexlan/Desktop/Research/BPMVF/ENCSR000EGM
REFERENCE_DIR=/Users/alexlan/Desktop/Research/BPMVF/reference
DATA_DIR=$BASE_DIR/data
MODEL_DIR=$BASE_DIR/models
CHROM_SIZES=$REFERENCE_DIR/hg38.chrom.sizes
REFERENCE_GENOME=$REFERENCE_DIR/hg38.genome.fa
CV_SPLITS=$BASE_DIR/splits.json
INPUT_DATA=$BASE_DIR/input_data.json

foo=$(paste -s -d ' ' $REFERENCE_DIR/chroms.txt)
echo $foo
echo

train \
    --input-data $INPUT_DATA \
    --stranded \
    --has-control \
    --output-dir $MODEL_DIR \
    --reference-genome $REFERENCE_GENOME \
    --chroms $(paste -s -d ' ' $REFERENCE_DIR/chroms.txt) \
    --chrom-sizes $CHROM_SIZES \
    --splits $CV_SPLITS \
    --model-arch-name BPNet1000d8 \
    --sequence-generator-name BPNet \
    --model-output-filename model \
    --input-seq-len 2114 \
    --output-len 1000 \
    --filters 64 \
    --shuffle \
    --threads 10 \
    --epochs 100 \
    --learning-rate 0.005

