#!/usr/bin/env python

from argparse import ArgumentParser
import subprocess
import os

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

#add extra column to bedfile telling which genome it belongs to
def label_bed(common_name, latin_name, chrom, tempfile, suffix, ref_name='FelisCatus'):
    #get bedfile with breaks
    path = os.path.join(data_prefix, common_name, '.'.join([latin_name,ref_name ,str(chrom), suffix,  'bed']))
    command = 'awk \'{print $0\"\t' + common_name +'\"}\' ' + path +'  >> ' + tempfile
    subprocess.call(command, shell=True)

#find common breaks in a group of genomes stored in filename
def merge(filename):
    result = filename+'.merged'
    command = ' '.join(['bedtools merge -i', filename, '-c 4 -o collapse >', result])
    subprocess.call(command, shell=True)
    return result

def rm(name):
    os.remove(name) if os.path.exists(name) else None

def preprocess_group(groups, chrom, tempfile, suffix):
    rm(tempfile)
    #if not groups:
    #    f = open(tempfile, 'w')
    #    f.close()
    for g in groups:
        label_bed(g[0], g[1], chrom, tempfile, suffix)        
    sorted_group = sort(tempfile)
    rm(tempfile)
    #print 'tmp files:', tempfile
    merged_group = merge(sorted_group)
    #print 'tmp files:', sorted_group
    rm(sorted_group)
    return merged_group

def sort(filename):
    result = filename+'.sorted'
    command = ' '.join(['bedSort', filename, result])
    subprocess.call(command, shell=True)
    return result

def subtract(fileA, fileB, result):
    command = ' '.join(['bedtools subtract -A -a', fileA, '-b', fileB, '>', result])
    subprocess.call(command, shell=True)

def extract_group_specific(overlap_file, group):
    group_file = overlap_file + '.group'
    with open(overlap_file) as f:
        with open(group_file, 'w') as outf:
            for line in f:
                line = line.strip()
                if len(line.split()[-1].split(',')) == len(group):
                    outf.write(line+'\n')
    return group_file

def run(group_genomes, outgroup_genomes, suffix):
    for chrom in range(0,20):
        print 'processing chromosome', chrom
        tempfile_group = os.path.join(data_prefix,'groups')
        result_group = preprocess_group(group_genomes, chrom, tempfile_group, suffix)
        if outgroup_genomes:
            tempfile_outgroups = os.path.join(data_prefix,'outgroups')
            result_outgroups = preprocess_group(outgroup_genomes, chrom, tempfile_outgroups, suffix='all')
        filtered_group_file = extract_group_specific(result_group, group_genomes)
        final_result = os.path.join(data_prefix,'.'.join(map(lambda x: x[0], group_genomes) + [str(chrom),'bed']))
        if outgroup_genomes:
            subtract(filtered_group_file, result_outgroups, final_result)
        else:
            command = ' '.join(['mv', filtered_group_file, final_result])
            subprocess.call(command, shell=True)
        print 'result at', final_result
        #print 'tmp files:', result_group, result_outgroups
        #print 'tmp_file:', filtered_group_file
        rm(filtered_group_file)
        rm(result_group)
        if outgroup_genomes:
            rm(result_outgroups)

if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--suffix', default='all', choices=['all','transloc','filtered_breaks', 'filterNs'])
    parser.add_argument('group',nargs='+',help='list of common names \
                for the group of species to analyze')
    args = parser.parse_args()
    sorted_names = zip(common_names, latin_names)
    group_genomes = filter(lambda x: x[0] in args.group, sorted_names)
    outgroup_genomes = filter(lambda x: x[0] not in args.group, sorted_names)
    run(group_genomes, outgroup_genomes, args.suffix) 
