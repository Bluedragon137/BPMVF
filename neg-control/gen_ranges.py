import numpy as np
import pandas as pd
import pysam
import time

def add_sequence(df, chrom, startpos, gc):
    df2 = pd.DataFrame([[chrom, startpos, startpos+2114, gc]], \
        columns = ['chrom', 'startpos', 'endpos', 'gc'])
    return df.append(df2)

def get_GC_content(seq):
    GC=0.001
    BP=0.001
    for base in seq:
        BP += 1
        if base == 'C' or base == 'G':
            GC += 1
    return (GC / BP)*100

def generate_main():
    fasta_ref = pysam.FastaFile('../reference/hg38.genome.fa')
    chrom_sizes = pd.read_csv('data/chrom_sizes', sep='\t', header=None, names=['chrom', 'length'])
    data = {}
    #df = pd.DataFrame(columns=['chrom', 'startpos', 'endpos', 'gc'])

    print("Data Loaded")
    start = time.time()
    entry = 0
    for i in range(1,25):
        chr = 'chr'+str(i)
        if i == 23:
            chr = 'chrX'
        elif i == 24:
            chr = 'chrY'
        counter = -1057
        while(counter-2114 < chrom_sizes['length'][i-1]):
            counter+=1057
            seq = fasta_ref.fetch(chr, counter, counter+2114)
            if 'N' in seq or len(seq)!=2114:
                continue
            else:
                gc_content = get_GC_content(seq)
                #df = add_sequence(df, chr, counter, gc_content)
                data[entry] = {"chrom": chr, "startpos": counter, "endpos": counter+2114, "gc": gc_content}
                entry += 1
            if (counter/1057)%10000 == 0:
                print("completed: " + str(counter/1057))
        print(chr + "complete")
        end = time.time()
        print("Elapsed Time for This Chromosome: " + str(end-start))
        start = time.time()
    df = pd.DataFrame.from_dict(data, "index")
    df.to_csv('ranges.bed', sep='\t', encoding='utf-8', header=False, index=False)

if __name__ == '__main__':
    generate_main()