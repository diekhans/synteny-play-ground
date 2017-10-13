#!/usr/bin/env python


from pycbio.hgdata.psl import PslReader
from pycbio.hgdata.psl import PslBlock
from pycbio.hgdata.psl import Psl
from argparse import ArgumentParser
from itertools import groupby


def get_blocks_set(psl_file):
    blocks = []
    for psl in PslReader(psl_file):
        blocks += psl.blocks
    return set(blocks)

#assume a.start < b.start
def is_not_overlapping_ordered_pair(a, b, threshold=1000):
    return a.qEnd <= b.qStart and\
            a.tEnd <= b.tStart and\
             a.psl.tName == b.psl.tName and\
              a.psl.strand == b.psl.strand and\
               b.qStart - a.qEnd < threshold and\
                b.tStart - a.tEnd < threshold 

def merge_group(group, merged):
    group = sorted(group, key=lambda x: x.qStart)
    mergeable = [group[0]]
    for i in range(1,len(group)):
        if  is_not_overlapping_ordered_pair(group[i-1], group[i]):
            mergeable.append(group[i])
        else:
            merged.append(mergeable)
            mergeable = [group[i]]
    merged.append(mergeable)

def merge(psl):
    blocks = get_blocks_set(psl)
    blocks = sorted(blocks, key=lambda x: x.psl.qName)
    blocks_grouped_by_query = map(lambda x:list(x[1]), groupby(blocks, key=lambda x:x.psl.qName))    
    merged = []
    for group in blocks_grouped_by_query:
        merge_group(group, merged)
    return merged
   
def construct_psl(blocks):
    psl = Psl()
    psl.match = sum(map(lambda x: x.qEnd-x.qStart, blocks))
    psl.misMatch = 0
    psl.repMatch = 0
    psl.nCount = 0
    psl.qNumInsert = len(filter(lambda x: x>0, map(lambda x: x[1].qStart-x[0].qEnd, zip(blocks,blocks[1:]))))
    psl.qBaseInsert = sum(map(lambda x: x[1].qStart-x[0].qEnd, zip(blocks,blocks[1:])))
    psl.tNumInsert = len(filter(lambda x: x>0, map(lambda x: x[1].tStart-x[0].tEnd, zip(blocks,blocks[1:]))))
    psl.tBaseInsert = sum(map(lambda x: x[1].tStart-x[0].tEnd, zip(blocks,blocks[1:])))
    psl.qName = blocks[0].psl.qName
    psl.qSize = blocks[0].psl.qSize
    psl.qStart = blocks[0].qStart
    psl.qEnd = blocks[-1].qEnd
    psl.tName = blocks[0].psl.tName
    psl.tSize = blocks[0].psl.tSize
    psl.strand = blocks[0].psl.strand
    if psl.strand == '++':
        psl.tStart = blocks[0].tStart
        psl.tEnd = blocks[-1].tEnd
    elif psl.strand == '+-':
        psl.tEnd = psl.tSize - blocks[0].tStart
        psl.tStart = psl.tSize - blocks[-1].tEnd
    psl.blockCount = len(blocks)
    for b in blocks:
        b.psl = psl
    psl.blocks = blocks
    return psl
    
if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('psl')
    parser.add_argument('out')
    args = parser.parse_args()
    merged = merge(args.psl)
    with open(args.out, 'w') as f:
        for blocks in merged:
           psl = construct_psl(blocks)
           f.write('\t'.join(psl.toRow())+'\n')
