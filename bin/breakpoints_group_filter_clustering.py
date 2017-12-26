#!/usr/bin/env python

from argparse import ArgumentParser
import os
from collections import defaultdict
import numpy as np
from itertools import groupby
from Bio import SeqIO

latin_names = ['PantheraLeo', 'PantheraPardus', 'PantheraOnca', 'PantheraTigris', \
                'CaracalCaracal', 'LynxPardina', 'PumaConcolor', 'AcinonyxJubatus', \
                'PrionailurusBengalensis', 'PrionailurusViverrinus', 'CanisFamiliaris']
#may be add dog , 'CanisFamiliaris'
#or hyena 'CrocutaCrocuta'                
common_names = ['lion', 'leopard', 'jaguar', 'tiger', 'caracal', 'lynx', 'puma', \
                'cheetah', 'leopard_cat', 'fishing_cat', 'dog']
#, 'dog'
#hyena

data_prefix = '/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae/'
sizes_prefix = '/hive/groups/recon/projs/felidae_comp/analysis/cactus/11-01-2017/bed/'

class Breakpoint:
    def __init__(self, chrom, start, end, queryNs, targetNs):
        self.chrom = chrom
        self.start = start
        self.end = end
        self.middle = self.start+float(end - start)/2
        self.queryNs = queryNs
        self.targetNs = targetNs

def load_genome_breakpoints(path, genome, backwards):
    breaks = []
    with open(path) as f:
        for line in f:
            line = line.strip().split()
            b = Breakpoint(line[0], int(line[1]), int(line[2]), float(line[4]), float(line[5]))
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
'''   
def parse_bed(bed):
    d = {}
    with open(bed) as f:
        for line in f:
            line = line.strip().split()
            if not line:
                continue
            d[line[0]] = (int(line[1]), int(line[2]))
    return d

def scaffold_end_start(size, start, end, threshold=100):
    return size - end < threshold \
        or start <= threshold

def check_abundance_Ns_genome(fasta, seqid, start, end):
    return float(fasta[seqid][start:end].seq.count('N'))/(end-start)
'''
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

def run(group_genomes, outgroup_genomes, suffix):
    for chrom in range(0,20):
    #for chrom in range(0,1):
        #first load all the genomes
        backwards= load_breakpoints(data_prefix, chrom, group_genomes, outgroup_genomes, suffix)
        if not backwards.keys():
            continue
        #for b in backwards:
        #    print b.start, b.end, backwards[b]
        r = cluster_lin(sorted(backwards.keys(), key=lambda x:x.middle))
        r = sorted(r, key=lambda x: len(x))
        #print 'number of points', len(backwards.keys())
        #print 'number of clusters', len(r)
        path =  os.path.join(data_prefix, '.'.join(map(lambda x: x[0], group_genomes)+[str(chrom),'bed']))
        get_breaks_for_group(group_genomes, r, backwards, path)
      
      
#def check_start_end(sizes, c): 
#    for b in c:
#        for g in backwards[b]:
#            if scaffold_end_start(sizes[g[1]], b.start, b.end):
#                return False
#    return True

def get_breaks_for_group(group, clusters, backwards, path, threshold_Ns=0.30):
    #i = 1
    with open(path, 'w') as f:
        for c in clusters:
            cur_genomes = set()
            not_ok_start_end = False
            for gs in map(lambda x: backwards[x], c):
                cur_genomes.update(gs)
            #if not check_start_end(sizes, c):
            #    continue
            not_ok_breaks = filter(lambda x: x.queryNs > threshold_Ns or x.targetNs > threshold_Ns, c)
            if cur_genomes == set(group) and not not_ok_breaks:
                ##for breakpoint in c:
                ##    print breakpoint.start, breakpoint.end
                ##print map(lambda x: backwards[x], c)
                #f.write(str(i)+'\n')
                #i += 1
                chrom = c[0].chrom 
                start = min(map(lambda x: x.start, c))
                end = max(map(lambda x: x.end, c))
                l = "\t".join(map(str,[chrom, start, end]))
                f.write(l+'\n')
                #for br in c:
                    #genomes = backwards[br]
                    #l = "\t".join(map(str, [br.chrom, br.start, br.end, br.queryNs, br.targetNs] + map(lambda x:x[0], genomes)))
                    #f.write(l+'\n')


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--suffix', choices=['prefilterNs'])
    parser.add_argument('group',nargs='+',help='list of common names \
                for the group of species to analyze')
    args = parser.parse_args()
    sorted_names = zip(common_names, latin_names)
    group_genomes = filter(lambda x: x[0] in args.group, sorted_names)
    outgroup_genomes = filter(lambda x: x[0] not in args.group, sorted_names)
    run(group_genomes, outgroup_genomes, args.suffix) 
