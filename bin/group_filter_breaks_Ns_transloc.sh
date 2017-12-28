#!/bin/bash

data_prefix=/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc leopard_cat fishing_cat 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/leopard_cat.fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc lion leopard
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/lion.leopard.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc lion leopard jaguar
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/lion.leopard.jaguar.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc lion leopard jaguar tiger
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/lion.leopard.jaguar.tiger.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc lion leopard jaguar tiger caracal
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/lion.leopard.jaguar.tiger.caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc lion leopard jaguar tiger caracal lynx
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/lion.leopard.jaguar.tiger.caracal.lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc lion leopard jaguar tiger caracal lynx puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/lion.leopard.jaguar.tiger.caracal.lynx.puma.cheetah.bed
rm ${data_prefix}/*.bed

#for sergeys' tree
./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc lion leopard jaguar tiger caracal puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/lion.leopard.jaguar.tiger.caracal.puma.cheetah.bed
rm ${data_prefix}/*.bed

echo 'attention!'
echo 'check the the dog genome was used as outgroup here - manually add it to the outgroups in the script if necessary'
./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc lion leopard jaguar tiger caracal lynx puma cheetah leopard_cat fishing_cat
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/lion.leopard.jaguar.tiger.caracal.lynx.puma.cheetah.leopard_cat.fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/puma.cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc lion 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/lion.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc leopard 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/leopard.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc jaguar
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/jaguar.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc tiger
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/tiger.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc caracal
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc lynx
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc puma
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/puma.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc fishing_cat
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --clustering_type ovl --suffix prefilterNs --transloc leopard_cat
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_transloc_ovl/leopard_cat.bed
rm ${data_prefix}/*.bed

