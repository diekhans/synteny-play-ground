#!/bin/bash

data_prefix=/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion caracal 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/lion.caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion lynx
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/lion.lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion puma
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/lion.puma.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lion cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/lion.cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs tiger caracal
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/tiger.caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs tiger lynx
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/tiger.lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs tiger puma
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/tiger.puma.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs tiger cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/tiger.cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs jaguar caracal
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/jaguar.caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs jaguar lynx
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/jaguar.lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs jaguar puma
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/jaguar.puma.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs jaguar cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/jaguar.cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs leopard caracal
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/leopard.caracal.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs leopard lynx
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/leopard.lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs leopard puma
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/leopard.puma.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs leopard cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/leopard.cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs caracal lynx 
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/caracal.lynx.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs caracal puma
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/caracal.puma.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs caracal cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/caracal.cheetah.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lynx puma
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/lynx.puma.bed
rm ${data_prefix}/*.bed

./breakpoints_group_filter_clustering.py --suffix prefilterNs lynx cheetah
cat ${data_prefix}/*.bed > ${data_prefix}/prefilterNs_notree/lynx.cheetah.bed
rm ${data_prefix}/*.bed
