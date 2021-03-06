#!/usr/bin/env python


from pycbio.hgdata.psl import PslReader
from pycbio.hgdata.psl import PslBlock
from pycbio.hgdata.psl import Psl
from argparse import ArgumentParser
from itertools import groupby,chain
import time
import datetime

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


def is_not_overlapping_ordered_pair(a, b, threshold=5000):
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
        merge_group(group, merged)
        i += 1
    return merged
  
def get_next(pos, query_group, max_anchor_distance=5000):
    f = []
    for i in range(pos+1, len(query_group)):
        if is_not_overlapping_ordered_pair(query_group[pos], query_group[i], max_anchor_distance):
            if not f:
                f.append(i)
            elif f and is_not_overlapping_ordered_pair(query_group[f[0]], query_group[i], max_anchor_distance):
                return f
            else:
                f.append(i)
    return f 

def dfs(i, group, path, paths, used) :
    used.add(group[i])
    assert i not in path , "{} not in {}".format(i, path)
    path.append(i)
    nexts = get_next(i, group)
    assert set(nexts) & set(path) == set()
    if not nexts:
        assert not map(lambda x: group[x], path) in paths, "{}".format(group[i].psl.qName)
        paths.append(map(lambda x: group[x], path))
    for e in nexts:
        dfs(e, group, path, paths, used)
    path.pop()

def depth_merge(psl):
    blocks = get_blocks_set(psl)
    blocks = sorted(blocks, key=lambda x: x.psl.qName)
    blocks_grouped_by_query = map(lambda x:list(x[1]), groupby(blocks, key=lambda x:x.psl.qName))
    paths = []
    for group in blocks_grouped_by_query:
        print 'processing group', group[0].psl.qName
        group = sorted(group, key=lambda x: x.qStart)
        used = set()
        for i in range(len(group)):
            if not group[i] in used:
                dfs(i, group, [], paths, used)
    return paths

def best_routes(merged):
    selected = []
    weighted_routes = zip(merged, map(lambda path: sum(map(lambda x: x.qEnd - x.qStart, path)), merged))
    weighted_routes = sorted(weighted_routes, key=lambda x:x[1], reverse=True)
    used = set()
    for route,_ in weighted_routes:
        if not set(route) & used:
            selected.append(route)
            used.update(route)
    return selected

'''
dag is a dict that for a given vertex stores all its possible next verties
hidden is a set of vertices that are already in paths
'''
def weigh_dag(group, dag, hidden,  max_anchor_distance):
    #weight of the edge equals length 
    #of the next block
    #weight of a vertice equals 
    #estimated weight: w_j < w_i + w_e(ij) =>
    #updated w_j
    #also remember how we came here: 
    #(prev_vertex, weight)
    weighted_dag = {}
    for i in range(len(group)):
        if i in hidden:
            continue
        #print i, group[i], len(group)
        if not i in dag:
            nexts = get_next(i, group, max_anchor_distance)
            dag[i] = nexts
        else:
            nexts = dag[i]
        #if never visited this vertex then 
        #weight of it equals to its size
        #because otherwise we will never count its size
        if not i in weighted_dag:
            weighted_dag[i] = (-1, group[i].size)
        for j in nexts:
            if j in hidden:
                continue
            alternative_weight = weighted_dag[i][1] + group[j].size
            if not j in weighted_dag or weighted_dag[j][1] < alternative_weight: 
                #w_i + weight of the next edge 
                weighted_dag[j] = (i, alternative_weight)
    return weighted_dag

def traceback(weighted_dag, hidden, group):
    #get the heaviest path weight
    start_vertex = max(weighted_dag.items(), key=lambda x:x[1][1])[0]
    path = [start_vertex]
    prev_vertex = weighted_dag[start_vertex][0]
    while prev_vertex != -1:
        path.append(prev_vertex)
        prev_vertex = weighted_dag[prev_vertex][0]
    hidden.update(set(path))
    return map(lambda x: group[x], path)[::-1]

def dag_merge(psl, min_block_breath, max_anchor_distance):
    blocks = get_blocks_set(psl)
    blocks = sorted(blocks, key=lambda x: x.psl.qName)
    blocks_grouped_by_query = map(lambda x:list(x[1]), groupby(blocks, key=lambda x:x.psl.qName))
    paths = []
    for group in blocks_grouped_by_query:
        dag = {}
        #set of hidden vertices
        hidden = set()
        #print 'processing group', group[0].psl.qName
        group = sorted(group, key=lambda x: x.qStart)
        while len(group) != len(hidden):
            ts = time.time()
            st = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')
            #print st, len(group), len(hidden)
            weighted_dag = weigh_dag(group, dag, hidden, max_anchor_distance)
            path = traceback(weighted_dag, hidden, group)
            if not path:
                break
            qLen = path[-1].qEnd - path[0].qStart
            tLen = path[-1].tEnd - path[0].tStart
            if qLen >= min_block_breath and tLen >= min_block_breath:
                paths.append(path)
            #think if we should keep path that is not complies with lengths bounds
            #we could traverse these vertices later in other paths
            #for e in path:
            #    group.remove(e)
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
    parser.add_argument('alg', help='type of algorithm: simple/recursion/dag')
    parser.add_argument('min_block_size', nargs='?', default=5000, type=int)
    parser.add_argument('max_anchor_distance', nargs='?', default=5000, type=int)
    parser.add_argument('psl')
    parser.add_argument('out')
    args = parser.parse_args()
    if args.alg == 'simple':
        merged = merge(args.psl)
    elif args.alg == 'recursion':
        print 'performing dfs...'
        merged = depth_merge(args.psl)
        print 'extracting best routes...'
        merged = best_routes(merged) 
    elif args.alg == 'dag':
        print 'dag merge...'
        print 'using min_block_size = ', args.min_block_size, \
            'max_anchor_distance =', args.max_anchor_distance 
        merged = dag_merge(args.psl, args.min_block_size, args.max_anchor_distance)
    print 'storing output...'
    with open(args.out, 'w') as f:
        for blocks in merged:
           psl = construct_psl(blocks)
           f.write('\t'.join(psl.toRow())+'\n')
