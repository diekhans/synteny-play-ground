#!/usr/bin/env python


from pycbio.hgdata.psl import PslReader
from pycbio.hgdata.psl import PslBlock
from pycbio.hgdata.psl import Psl
from argparse import ArgumentParser
from itertools import groupby
from Bio import SeqIO


def extract_blocks(psl_file):
    entries = []
    for psl in PslReader(psl_file):
        #entry = (psl.qName, int(psl.qStart), int(psl.qEnd), psl.tName, int(psl.tStart), int(psl.tEnd), psl.strand)
        #entries.append(entry)
        entries.append(psl)
    return entries

def print_out(blocks, filename):
    with open(filename, 'w') as f:
        for b in blocks:
            f.write(b+'\n')

def parse_bed(bed):
    d = {}
    with open(bed) as f:
        for line in f:
            line = line.strip().split()
            if not line:
                continue
            d[line[0]] = (int(line[1]), int(line[2]))
    return d

#check if previous scaffold ended and we came to the beginning of the new one
#TOTHINK: and or or - in case we put AND we got some cases when one scaffold is ending
#and the other contniues alignment to target not from the beginning
#this case must reflect the translocation but it's hardly to say exactly where
#this first part of the scaffold was aligned
#in case of OR we may skip some insertions
def scaffold_end_start(prev_end, prev_global_size, this_start, this_global_start):
    threshold = 1000 
    return prev_end >= prev_global_size - threshold \
        or this_start <= this_global_start + threshold

def overlaps(b, accumulated):
    for a in accumulated:
        if b.tStart == a.tEnd or a.tStart == b.tEnd:
            continue
        if b.tStart <= a.tStart <= b.tEnd or \
            a.tStart <= b.tStart <= a.tEnd or \
             a.tStart <= b.tStart <= b.tEnd <= a.tEnd or \
              b.tStart <= a.tStart <= a.tEnd <= b.tEnd:
            return True
    return False

def group_overlapping(sorted_blocks_target):
    res = []
    accumulated = []
    for b in sorted_blocks_target:
        if not accumulated or overlaps(b, accumulated):
            accumulated.append(b)
        else:
            res.append(list(accumulated))
            accumulated = [b]
    return res


def check_abundance_Ns_genome(fasta, seqid, start, end):
    return float(fasta[seqid][start:end].seq.count('N'))/(end-start)

#look into neighborhood on both ends of breakpoints for target and for query
#can not look inside the breakpoint region because some of them are overlapping 
#and it finally causes a mess if end - start + 1 == 0 because they overlap for 1bp
# -> it's a mess
def check_abundance_Ns_for_both(query, target, prev_block, b):
    break_start = prev_block.tEnd - 500
    break_end = prev_block.tEnd + 500
    seqid = prev_block.tName
    target_ns_1 = check_abundance_Ns_genome(target, seqid, break_start, break_end)
    break_start = b.tStart - 500
    break_end = b.tEnd + 500
    target_ns_2 = check_abundance_Ns_genome(target, seqid, break_start, break_end)
    target_ns = max(abs(target_ns_1), abs(target_ns_2))
    break_start = prev_block.qEnd - 500
    break_end = prev_block.qStart + 500
    seqid = prev_block.qName
    query_ns_1 = check_abundance_Ns_genome(query, seqid, break_start, break_end)
    break_start = b.qStart - 500
    break_end = b.qStart + 500
    seqid = b.qName #in case of translocation
    query_ns_2 = check_abundance_Ns_genome(query, seqid, break_start, break_end)
    query_ns = max(abs(query_ns_1), abs(query_ns_2))
    return (query_ns, target_ns)

def find_breaks(blocks, query, fasta_target, fasta_query):
    breaks = []
    #first group by target sequence id
    blocks = sorted(blocks, key=lambda x:x.tName)
    for target, blocks_target in groupby(blocks, key=lambda x:x.tName) :
        blocks_target = list(blocks_target)
        #sort by target start
        sorted_blocks_target = sorted(blocks_target, key=lambda x: x.tStart)
        prev_block = ''
        #group repeats in target together
        for repeat_blocks in group_overlapping(sorted_blocks_target): 
            if len(repeat_blocks) > 1:
               #prev_block = sorted(repeat_blocks, key=lambda x: x[5])[-1]
                continue
            b = repeat_blocks[0]
            if prev_block and not scaffold_end_start(prev_block.qEnd, query[prev_block.qName][1],\
                        b.qStart, query[b.qName][0]):
                            ns = check_abundance_Ns_for_both(fasta_query, fasta_target, prev_block, b)
                            breaks.append((prev_block, b, ns[0], ns[1]))
                           # print prev_block.qName, prev_block.qEnd, query[prev_block.qName][1], b.qName, b.qStart, query[b.qName][0]
            prev_block = b
    #exit()
    return breaks

if __name__ == '__main__':
    #TARGET IS REFERENCE
    parser = ArgumentParser()
    parser.add_argument('psl')
    parser.add_argument('--fasta_target')
    parser.add_argument('--fasta_query')
    parser.add_argument('bed_query',help='bed file for queries chromosomes')
    args = parser.parse_args()
    blocks = extract_blocks(args.psl)
    query_chroms = parse_bed(args.bed_query)
    fasta_target = SeqIO.to_dict(SeqIO.parse(open(args.fasta_target),'fasta'))
    fasta_query = SeqIO.to_dict(SeqIO.parse(open(args.fasta_query),'fasta'))
    breaks = find_breaks(blocks, query_chroms, fasta_target, fasta_query)
    for b in breaks:
        #tName, tStart, tEnd, qNameEnd, qStart, qNameStart, qEnd, ifDeletionInQuery, qNsrate, tNsrate
        print '\t'.join(map(str,[b[0][3], b[0][5], b[1][4], b[0][0], b[0][2], b[1][0], b[1][1], b[2], b[3]]))

