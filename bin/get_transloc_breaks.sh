#!/bin/bash

org=$2
latin_name=$1
data_prefix='/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae/'
bin_prefix='/hive/groups/recon/projs/felidae_comp/synteny-play-ground/bin'
cactus_prefix='/hive/groups/recon/projs/felidae_comp/analysis/cactus/11-01-2017/bed/'
for c in {0..19}; do
    echo 'scaffold' $c
    ${bin_prefix}/find_breakpoints.py ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.merged.psl ${cactus_prefix}/${latin_name}.bed | awk '{print $1"\t"$3"\t"$4}' > ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.transloc.bed
done
#cat ${data_prefix}/${org}/${latin_name}.FelisCatus.transloc.[0-9]* > ${data_prefix}/${org}/${latin_name}.FelisCatus.transloc.bed
#rm ${data_prefix}/${org}/${latin_name}.FelisCatus.transloc.[0-9]*
