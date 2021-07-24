import numpy as np
import pandas as pd
import json

def remap (filepath):
    negative_ranges = pd.read_csv(filepath, sep='\t', header=None, names=['chrom', 'startpos', 'endpos', 'gc'])
    negative_ranges['gc'] = negative_ranges['gc'].round()
    print(negative_ranges)
    data = {}
    for i in range (101):
        data[i] = []
    print(data)
    
    for index, row in negative_ranges.iterrows():
        data[row['gc']].append((row['chrom'], row['startpos'], row['endpos']))
        if index % 10000 == 0:
            print ('finished sample ' + str(index))
    
    with open('gc_peaks_dict.json', 'w') as f:
        json.dump(data, f)



if __name__ == '__main__':
    remap('negative_ranges.bed')