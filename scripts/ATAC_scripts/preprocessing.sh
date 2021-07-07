BASE_DIR=/wynton/home/corces/allan/BPMVF/ATAC
REFERENCE_DIR=/wynton/home/corces/allan/BPMVF/reference
BAMS_DIR=$BASE_DIR/bams
DATA_DIR=$BASE_DIR/data

# get coverage of 5’ positions
bedtools genomecov -5 -bg \
        -g $REFERENCE_DIR/hg38.chrom.sizes -ibam $BAMS_DIR/Cluster24.sorted.bam \
        | sort -k1,1 -k2,2n > $DATA_DIR/C24signal.bedGraph

# Convert bedGraph file to bigWig file
./bedGraphToBigWig $DATA_DIR/C24signal.bedGraph $REFERENCE_DIR/hg38.chrom.sizes $DATA_DIR/C24signal.bw
