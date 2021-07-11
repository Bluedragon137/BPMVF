import pandas as pd

def complete_peaks(hint_bedfile):
    C24=pd.read_csv(hint_bedfile, sep='\t', header=None, names= ['chrom', 'start', 'end', 'name', 'score', 'strand'])
    C24['signalValue']=0
    C24['p']=0
    C24['q']=0
    C24['summit'] = (C24['end']-C24['start'])/2
    C24 = C24.astype({'summit': 'int64'})
    C24.to_csv('full_'+hint_bedfile, sep='\t', encoding='utf-8', header=False, index=False)

if __name__ == '__main__':
    complete_peaks('C24.bed')
