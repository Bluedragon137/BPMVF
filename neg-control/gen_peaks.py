import numpy as np
from numpy.lib.npyio import save
import pandas as pd
import json
import pysam
import math
from random import randrange


def get_GC_content(seq):
    GC=0.001
    BP=0.001
    for base in seq:
        BP += 1
        if base == 'C' or base == 'G':
            GC += 1
    return round((GC / BP)*100)

def query_gc(gc, data):
    terms = len(data[str(gc)])
    if terms == 0 and gc >= 50:
        return query_gc(gc-1, data)
    elif terms == 0 and gc < 50:
        return query_gc(gc+1, data)
    index = randrange(terms)
    val = data[str(gc)][index]
    data[str(gc)].pop(index)
    return val, data

def save_peaks(origp, neg_sample_list, rate):
    negdf = pd.DataFrame(neg_sample_list, columns = ['chrom', 'st', 'en'])
    negdf['name'] = '.'
    negdf['score'] = 500
    negdf['strand'] = '.'
    negdf['signalValue'] = 0
    negdf['p'] = 0
    negdf['q'] = 0
    negdf['summit'] = 1057
    peaks_df = negdf.append(origp)
    peaks_df = peaks_df.sample(frac=1).reset_index(drop=True)
    print(peaks_df.info(), negdf.info(), origp.info())
    peaks_df.to_csv('data/peaks_df_deduped'+str(int(rate*100))+'.bed', sep='\t', encoding='utf-8', header=False, index=False)

def gen_peaks_main(origpeaks, negpeaks, rate):
    #Load original peaks, negative sample datasets
    origp = pd.read_csv(origpeaks, sep='\t', header=None, \
        names=['chrom', 'st', 'en', 'name', 'score', 'strand', 'signalValue', 'p', 'q', 'summit'])
    with open(negpeaks) as f:
        negp = json.load(f)
    fasta_ref = pysam.FastaFile('../reference/hg38.genome.fa')

    #Calculate 
    orig_samples = origp.shape[0]
    neg_samples = math.floor(orig_samples*rate)
    print (orig_samples, neg_samples)
    neg_sample_list = []
    
    # Get the distribution of GC content in the original dataset 
    # and scale down to the negative sample quantity
    distribution = np.zeros([101], dtype=int)
    for index, row in origp.iterrows():
        seq = fasta_ref.fetch(row['chrom'], row['st'], row['en'])
        gc = round(get_GC_content(seq))
        distribution[gc-1] += 1
    distribution = np.multiply(distribution, rate)
    distribution = distribution.astype(int)

    #Generate the proper number of negative samples
    for gc in range(101):
        for i in range(distribution[gc]):
            val, negp = query_gc(gc, negp)
            neg_sample_list.append(val)
    
    #Save the negative samples to the original dataset and save to bedfile
    save_peaks(origp, neg_sample_list, rate)

if __name__ == '__main__':
    rates = [0.0, 0.05, 0.10, 0.15, 0.20, 0.30, 0.40, 0.50, 0.75, 1.00]
    for rate in rates:
        gen_peaks_main('../ATAC/data/peaks/Cluster24.filtered.deduped.bed', 'data/gc_peaks_dict.json', rate)
    