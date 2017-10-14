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
def are_syntenic(a, b):
    return a.qEnd <= b.qStart and\
            a.tEnd <= b.tStart and\
             a.psl.tName == b.psl.tName and\
                a.psl.strand == b.psl.strand


def is_not_overlapping_ordered_pair(a, b, threshold=1000):
    return are_syntenic(a, b) and\
             0 <= b.qStart - a.qEnd < threshold and\
              0 <=  b.tStart - a.tEnd < threshold 

def merge_group(group, merged):
    group = sorted(group, key=lambda x: x.qStart)
    mergeable = [group[0]]
    for i in range(1,len(group)):
        if is_not_overlapping_ordered_pair(group[i-1], group[i]):
            mergeable.append(group[i])
        else:
            merged.append(mergeable)
            mergeable = [group[i]]
    merged.append(mergeable)

def merge(psl):
    print 'getting block set....'
    blocks = get_blocks_set(psl)
    print 'sorting block set....'
    blocks = sorted(blocks, key=lambda x: x.psl.qName)
    blocks_grouped_by_query = map(lambda x:list(x[1]), groupby(blocks, key=lambda x:x.psl.qName))    
    merged = []
    i = 0
    for group in blocks_grouped_by_query:
        #print 'processing group', i 
        merge_group(group, merged)
        i += 1
    return merged
  
def get_next(block, query_group):
    f = filter(lambda x: is_not_overlapping_ordered_pair(block, x), query_group)
    f = sorted(f, key=lambda x: x.qStart)
    if len(f) < 2:
        return f
    return [f[0]] + filter(lambda x: x.qStart < f[0].qEnd, f[1:])

def dfs(start_block, group, path, paths, used) :
    used.add(start_block)
    assert start_block not in path , "{} not in {}".format(start_block, path)
    path.append(start_block)
    nexts = get_next(start_block, group)
    print 'start block:', start_block
    for e in nexts:
        print e
    print
    for e in path:
        print e
    print
    assert set(nexts) & set(path) == set()
    if not nexts:
        paths.append(path)
    for e in nexts:
        dfs(e, group, path, paths, used)

def depth_merge(psl):
    blocks = get_blocks_set(psl)
    blocks = sorted(blocks, key=lambda x: x.psl.qName)
    blocks_grouped_by_query = map(lambda x:list(x[1]), groupby(blocks, key=lambda x:x.psl.qName))
    paths = []
    for group in blocks_grouped_by_query:
        group = sorted(group, key=lambda x: x.qStart)
        used = set()
        for block in group:
            if not block in used:
                dfs(block, group, [], paths, used) 
    return paths

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
    merged = depth_merge(args.psl)
    #for path in merged:
    #    for m in path:
    #        print m,
    #    print 
    #merged = merge(args.psl)
    with open(args.out, 'w') as f:
        for blocks in merged:
           psl = construct_psl(blocks)
           f.write('\t'.join(psl.toRow())+'\n')
