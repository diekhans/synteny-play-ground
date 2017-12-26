#!/bin/bash

data_prefix=/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae

./breakpoints_group_filter.py --suffix filtered_breaks leopard_cat fishing_cat 
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/leopard_cat.fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks lion leopard
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/lion.leopard.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks lion leopard jaguar
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/lion.leopard.jaguar.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks lion leopard jaguar tiger
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/lion.leopard.jaguar.tiger.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks lion leopard jaguar tiger caracal
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/lion.leopard.jaguar.tiger.caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks lion leopard jaguar tiger caracal lynx
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/lion.leopard.jaguar.tiger.caracal.lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks lion leopard jaguar tiger caracal lynx puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/lion.leopard.jaguar.tiger.caracal.lynx.puma.cheetah.bed
rm ${data_prefix}/*.bed

echo 'attention!'
echo 'should rerun group filter for only domestic cat genome using dog as outgroup - manually change the outgroups in script'
./breakpoints_group_filter.py --suffix filtered_breaks lion leopard jaguar tiger caracal lynx puma cheetah leopard_cat fishing_cat
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/lion.leopard.jaguar.tiger.caracal.lynx.puma.cheetah.leopard_cat.fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks puma cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/puma.cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks lion 
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/lion.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks leopard 
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/leopard.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks jaguar
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/jaguar.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks tiger
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/tiger.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks caracal
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks lynx
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks puma
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/puma.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks fishing_cat
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/fishing_cat.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter.py --suffix filtered_breaks leopard_cat
cat ${data_prefix}/*.bed > ${data_prefix}/filtered_breaks/leopard_cat.bed
rm ${data_prefix}/*.bed

