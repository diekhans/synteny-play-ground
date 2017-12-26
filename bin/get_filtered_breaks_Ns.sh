#!/bin/bash

org=$2
latin_name=$1
query_fasta=$3
target_fasta='/hive/groups/recon/projs/felidae_comp/assemblies/FelisCatus/FelCat_8.0.fixed.fa.masked'
data_prefix='/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae/'
bin_prefix='/hive/groups/recon/projs/felidae_comp/synteny-play-ground/bin'
cactus_prefix='/hive/groups/recon/projs/felidae_comp/analysis/cactus/11-01-2017/bed/'
#rm /hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae/filterNs/${latin_name}.bed
for c in {0..19}; do
    echo 'scaffold' $c
    ${bin_prefix}/find_breakpoints.py --fasta_target ${target_fasta} --fasta_query ${query_fasta} ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.merged.psl ${cactus_prefix}/${latin_name}.bed > ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.prefilterNs.bed
    
    #cut -f 1,2,3 ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.prefilterNs.bed | diff ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.all.bed /dev/stdin | grep '>' | sed 's/> //' | awk '($3!=$2) {print $0}' | awk '{if ($3<$2) {print $1"\t"$3"\t"$2} else {print $0}}' > ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.tmp
    #cat ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.prefilterNs.bed | awk '{if ($3<$2) {print $1"\t"$3"\t"$2"\t"$4"\t"$5"\t"$6} else {print $0}}' > ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.tmp3 
    #bedtools subtract -f 1.0 -a ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.tmp3 -b ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.tmp > ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.tmp2
    #mv ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.tmp2 ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.prefilterNs.bed
    #rm ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.tmp ${data_prefix}/${org}/${latin_name}.FelisCatus.${c}.tmp3
done
