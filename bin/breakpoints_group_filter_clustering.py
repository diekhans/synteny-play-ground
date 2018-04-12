#!/usr/bin/env python

from argparse import ArgumentParser
import os
from collections import defaultdict
import numpy as np
from itertools import groupby
from Bio import SeqIO

latin_names = ['PantheraLeo', 'PantheraPardus', 'PantheraOnca', 'PantheraTigris', \
                'CaracalCaracal', 'LynxPardina', 'PumaConcolor', 'AcinonyxJubatus', \
                'PrionailurusBengalensis', 'PrionailurusViverrinus']
#may be add dog , 'CanisFamiliaris'
#or hyena 'CrocutaCrocuta'                
common_names = ['lion', 'leopard', 'jaguar', 'tiger', 'caracal', 'lynx', 'puma', \
                'cheetah', 'leopard_cat', 'fishing_cat']
#, 'dog'
#hyena

data_prefix = '/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae/'
sizes_prefix = '/hive/groups/recon/projs/felidae_comp/analysis/cactus/11-01-2017/bed/'

class Breakpoint:
    def __init__(self, chrom, start, end, qChrom1, qStart, qChrom2, qEnd, queryNs, targetNs):
        self.chrom = chrom
        self.start = start
        self.end = end
        self.qChrom1 = qChrom1
        self.qStart = qStart
        self.qChrom2 = qChrom2
        self.qEnd = qEnd
        self.middle = self.start+float(end - start)/2
        self.queryNs = queryNs
        self.targetNs = targetNs

    def is_transloc(self):
        return self.qChrom1 != self.qChrom2

def load_genome_breakpoints(path, genome, backwards):
    breaks = []
    with open(path) as f:
        for line in f:
            line = line.strip().split()
            b = Breakpoint(line[0], int(line[1]), int(line[2]), line[3], int(line[4]), line[5],\
                 int(line[6]), float(line[7]), float(line[8]))
            breaks.append(b)
            backwards[b].append(genome)
            #backwards[(b.start, b.end)].append(genome)
    return sorted(breaks, key=lambda x:x.start)

def load_breakpoints(data_prefix, chrom, groups, outgroups, suffix):
    backwards = defaultdict(list)
    for genome in groups + outgroups:
        path = os.path.join(data_prefix, genome[0], genome[1]+'.FelisCatus.'+str(chrom)+'.'+suffix+'.bed')
        load_genome_breakpoints(path, genome, backwards)
    return backwards

#b1.start <= b2.start
def if_overlaps(b1, b2):
    #if b1.end == b2.start:
    #    return False
    return b1.end >= b2.start - 1000

def cluster_by_overlap(points):
    clusters = []
    cur = [points[0]]
    for p in points[1:]:
        if if_overlaps(cur[-1],p):
            cur.append(p)
        else:
            clusters.append(list(cur))
            cur = [p]
    return clusters         

def cluster_lin(points, threshold=1000):
    clusters = []
    cur = [points[0]]
    for p in points[1:]:
        if abs(cur[-1].middle-p.middle) < threshold:
            cur.append(p)
        else:
            clusters.append(list(cur))
            cur = [p]
    return clusters         

def run(group_genomes, outgroup_genomes, suffix, transloc, clustering_type):
    for chrom in range(0,20):
    #for chrom in range(0,1):
        #first load all the genomes
        backwards= load_breakpoints(data_prefix, chrom, group_genomes, outgroup_genomes, suffix)
        if not backwards.keys():
            continue
        r = cluster_lin(sorted(backwards.keys(), key=lambda x:x.middle)) if clustering_type=='middle' \
            else cluster_by_overlap(sorted(backwards.keys(), key=lambda x:(x.start, x.end))) 
        r = sorted(r, key=lambda x: len(x))
        #print 'number of points', len(backwards.keys())
        #print 'number of clusters', len(r)
        path =  os.path.join(data_prefix, '.'.join(map(lambda x: x[0], group_genomes)+[str(chrom),'bed']))
        get_breaks_for_group(group_genomes, r, backwards, path, transloc)
      
      
def get_breaks_for_group(group, clusters, backwards, path, transloc, threshold_Ns=0.30):
    #i = 1
    with open(path, 'w') as f:
        for c in clusters:
            cur_genomes = set()
            not_ok_start_end = False
            for gs in map(lambda x: backwards[x], c):
                cur_genomes.update(gs)
            not_ok_breaks = filter(lambda x: x.queryNs > threshold_Ns or x.targetNs > threshold_Ns, c)
            not_transloc_c = filter(lambda x: not x.is_transloc(), c)
            if cur_genomes == set(group) and not not_ok_breaks:
                if not transloc or transloc and not not_transloc_c:
                    chrom = c[0].chrom 
                    start = min(map(lambda x: x.start, c))
                    end = max(map(lambda x: x.end, c))
                    l = "\t".join(map(str,[chrom, start, end]))
                    f.write(l+'\n')

def run_for_all(all_genomes, suffix, transloc, clustering_type):
    for chrom in range(0,20):
    #for chrom in range(0,1):
        #first load all the genomes
        backwards= load_breakpoints(data_prefix, chrom, all_genomes, [], suffix)
        if not backwards.keys():
            continue
        r = cluster_lin(sorted(backwards.keys(), key=lambda x:x.middle)) if clustering_type=='middle' \
            else cluster_by_overlap(sorted(backwards.keys(), key=lambda x:(x.start, x.end))) 
        r = sorted(r, key=lambda x: len(x))
        #print chrom, 'number of points', len(backwards.keys())
        #print chrom, 'number of clusters', len(r)
        path =  os.path.join(data_prefix, '.'.join(['all_breaks',str(chrom),'bed']))
        get_breaks_for_all(r, backwards, path, transloc)
      
 
def get_breaks_for_all(clusters, backwards, path, transloc, threshold_Ns=0.30):
    #i = 1
    print path
    with open(path, 'w') as f:
        for c in clusters:
            cur_genomes = set()
            not_ok_start_end = False
            for gs in map(lambda x: backwards[x], c):
                cur_genomes.update(gs)
            not_ok_breaks = filter(lambda x: x.queryNs > threshold_Ns or x.targetNs > threshold_Ns, c)
            not_transloc_c = filter(lambda x: not x.is_transloc(), c)
            if not not_ok_breaks and (not transloc or transloc and not not_transloc_c):
                    chrom = c[0].chrom 
                    start = min(map(lambda x: x.start, c))
                    end = max(map(lambda x: x.end, c))
                    l = "\t".join(map(str,[chrom, start, end, '.'.join(sorted(map(lambda x: x[0], cur_genomes)))]))
                    f.write(l+'\n')


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--suffix', choices=['prefilterNs'])
    parser.add_argument('--transloc', default=False, action='store_true',help='report only translocs in query?')
    parser.add_argument('--clustering_type', default='middle', choices=['middle', 'ovl']) 
    parser.add_argument('group',nargs='*',help='list of common names \
                for the group of species to analyze')
    args = parser.parse_args()
    sorted_names = zip(common_names, latin_names)
    if args.group:
        group_genomes = filter(lambda x: x[0] in args.group, sorted_names)
        outgroup_genomes = filter(lambda x: x[0] not in args.group, sorted_names)
        run(group_genomes, outgroup_genomes, args.suffix, args.transloc, args.clustering_type) 
    else:
        run_for_all(sorted_names, args.suffix, args.transloc, args.clustering_type)
