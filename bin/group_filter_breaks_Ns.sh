#!/bin/bash

data_prefix=/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae

./breakpoints_group_filter_clustering.py --suffix prefilterNs leopard_cat fishing_cat 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/leopard_cat.fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion leopard
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/lion.leopard.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion leopard jaguar
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/lion.leopard.jaguar.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion leopard jaguar tiger
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/lion.leopard.jaguar.tiger.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion leopard jaguar tiger caracal
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/lion.leopard.jaguar.tiger.caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion leopard jaguar tiger caracal lynx
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/lion.leopard.jaguar.tiger.caracal.lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion leopard jaguar tiger caracal lynx puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/lion.leopard.jaguar.tiger.caracal.lynx.puma.cheetah.bed
rm ${data_prefix}/*.bed

#for sergeys' tree
./breakpoints_group_filter_clustering.py --suffix prefilterNs lion leopard jaguar tiger caracal puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/lion.leopard.jaguar.tiger.caracal.puma.cheetah.bed
rm ${data_prefix}/*.bed

echo 'attention!'
echo 'check the the dog genome was used as outgroup here - manually add it to the outgroups in the script if necessary'
./breakpoints_group_filter_clustering.py --suffix prefilterNs lion leopard jaguar tiger caracal lynx puma cheetah leopard_cat fishing_cat
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/lion.leopard.jaguar.tiger.caracal.lynx.puma.cheetah.leopard_cat.fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/puma.cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/lion.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs leopard 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/leopard.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs jaguar
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/jaguar.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs tiger
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/tiger.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs caracal
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lynx
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs puma
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/puma.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs fishing_cat
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs leopard_cat
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs/leopard_cat.bed
rm ${data_prefix}/*.bed

