#!/bin/bash

#data_prefix='/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae/prefilterNs_notree/'
data_prefix='/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae/prefilterNs/'
ltrs='/hive/groups/recon/projs/felidae_comp/analysis/transposons/LTRs/FelCat-ltrs.bed'

for x in `ls ${data_prefix}/*.bed | grep -v comments`; 
do
    basename $x
    #cat $x | awk '{print $1"\t"$2-500"\t"$2+500"\n"$1"\t"$3-500"\t"$3+500}' | bedSort /dev/stdin ${data_prefix}/tmp
    #cat $x | awk '($3-$2>10000) {print $0}' | bedSort /dev/stdin ${data_prefix}/tmp
    cat $x | awk '($3-$2>1000) {print $0}' | awk '{print $1"\t"$2"\t"$2+500"\n"$1"\t"$3-500"\t"$3}' | bedSort /dev/stdin ${data_prefix}/tmp
    bedtools merge -i ${data_prefix}/tmp > ${data_prefix}/breaks_neighb.tmp
    echo 'got break regions:'
    wc -l ${data_prefix}/breaks_neighb.tmp
    total=$(awk '{sum+=$3-$2} END {print sum}' ${data_prefix}/breaks_neighb.tmp)
    echo 'density in breaks:'
    bedtools intersect -a ${data_prefix}/breaks_neighb.tmp -b ${ltrs} | awk -v t=$total '{sum+=$3-$2} END {print sum/t}'
    #cat ${data_prefix}/breaks_neighb.tmp | awk '{print $1"\t"$2-5000"\t"$2"\n"$1"\t"$3"\t"$3+5000}' | bedSort /dev/stdin ${data_prefix}/tmp
    cat $x | awk '($3-$2>1000) {print $0}' | awk '{print $1"\t"$2-500"\t"$2"\n"$1"\t"$3"\t"$3+500}' | bedSort /dev/stdin ${data_prefix}/tmp
    bedtools merge -i ${data_prefix}/tmp > ${data_prefix}/breaks_neighb.tmp
    total=$(awk '{sum+=$3-$2} END {print sum}' ${data_prefix}/breaks_neighb.tmp)
    echo 'density in no-breaks:'
    bedtools intersect -a ${data_prefix}/breaks_neighb.tmp -b ${ltrs} | awk -v t=$total '{sum+=$3-$2} END {print sum/t}'

    #segments=$(awk 'END{print NR}' ${data_prefix}/breaks_neighb.tmp)
    #have_ltrs=$(bedtools intersect -u -a ${data_prefix}/breaks_neighb.tmp -b ${ltrs} | wc -l)
    #echo 'neighb having at least one related ltr'
    #echo  ${have_ltrs}/${segments}
    rm ${data_prefix}/breaks_neighb.tmp ${data_prefix}/tmp
done



echo 'average ltrs density per felcat genome:'
awk '{sum+=$3-$2} END {print sum/2641342258}' $ltrs
