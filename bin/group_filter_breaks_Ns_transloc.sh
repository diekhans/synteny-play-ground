#!/bin/bash

data_prefix=/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc leopard_cat fishing_cat 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/leopard_cat.fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc lion leopard
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/lion.leopard.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc lion leopard jaguar
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/lion.leopard.jaguar.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc lion leopard jaguar tiger
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/lion.leopard.jaguar.tiger.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc lion leopard jaguar tiger caracal
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/lion.leopard.jaguar.tiger.caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc lion leopard jaguar tiger caracal lynx
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/lion.leopard.jaguar.tiger.caracal.lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc lion leopard jaguar tiger caracal lynx puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/lion.leopard.jaguar.tiger.caracal.lynx.puma.cheetah.bed
rm ${data_prefix}/*.bed

#for sergeys' tree
./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc lion leopard jaguar tiger caracal puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/lion.leopard.jaguar.tiger.caracal.puma.cheetah.bed
rm ${data_prefix}/*.bed

echo 'attention!'
echo 'check the the dog genome was used as outgroup here - manually add it to the outgroups in the script if necessary'
./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc lion leopard jaguar tiger caracal lynx puma cheetah leopard_cat fishing_cat
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/lion.leopard.jaguar.tiger.caracal.lynx.puma.cheetah.leopard_cat.fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/puma.cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc lion 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/lion.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc leopard 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/leopard.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc jaguar
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/jaguar.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc tiger
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/tiger.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc caracal
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc lynx
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc puma
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/puma.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc fishing_cat
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs --transloc leopard_cat
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc/leopard_cat.bed
rm ${data_prefix}/*.bed

