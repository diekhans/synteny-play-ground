#!/usr/bin/env python

import os
import sys
from cluster_utils import run_joblist

prefix='/hive/groups/recon/projs/felidae_comp/synteny-play-ground'

def make_joblist(specie, common_name, max_jobs=4):
    chromosomes = range(0,20)
    chromosomes = map(str, chromosomes)
    #chromosomes = map(lambda x: 'scaffold'+x, chromosomes)
    joblist=os.path.join(prefix,'data/jobs.txt')
    with open(joblist, 'w') as f:
       for c in chromosomes:
            script = os.path.join(prefix,'bin/psl_merger_wrapper.sh')
            folder=os.path.join(prefix,'data/felidae/',common_name)
            if not os.path.isdir(folder):
                os.makedirs(folder)
            data = os.path.join(folder,specie+'.FelisCatus.'+c+'.psl')
            #output = data.split('psl')[0] + 'merged.psl' 
            folder=os.path.join(prefix,'data/felidae2/',common_name)
            if not os.path.isdir(folder):
                os.makedirs(folder)
            output = os.path.join(folder,specie+'.FelisCatus.'+c+'.merged.psl')
            line = ' '.join([script, data, output])
            f.write(line+'\n')
    return joblist
   
if __name__ == '__main__' :
    specie = sys.argv[1]
    common_name = sys.argv[2]
    joblist = make_joblist(specie, common_name)
    #print joblist
    run_joblist(joblist, 4)

