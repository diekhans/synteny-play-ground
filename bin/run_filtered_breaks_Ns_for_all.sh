#!/bin/bash

fasta_prefix='/hive/groups/recon/projs/felidae_comp/assemblies/'
#data_prefix='/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae/filterNs/'

echo 'cheetah'
./get_filtered_breaks_Ns.sh AcinonyxJubatus cheetah ${fasta_prefix}/FelisCatus/FelCat_8.0.fixed.fa.masked
#awk '($4 == "False" && $5 <= 0.39 && $6 <= 0.39 ) {print $1"\t"$2"\t"$3}' ${data_prefix}AcinonyxJubatus.bed > ${data_prefix}AcinonyxJubatus.filtered.bed

echo 'puma'
./get_filtered_breaks_Ns.sh PumaConcolor puma ${fasta_prefix}/PumaConcolor/mountain_lion_17Sep2015_MifDV.fasta.masked
#awk '($4 == "False" && $5 <= 0.39 && $6 <= 0.39 ) {print $1"\t"$2"\t"$3}' ${data_prefix}PumaConcolor.bed > ${data_prefix}PumaConcolor.filtered.bed

echo 'jaguar'
./get_filtered_breaks_Ns.sh PantheraOnca jaguar ${fasta_prefix}/PantheraOnca/PanOnc_1.0.fixed.fa.masked 
#awk '($4 == "False" && $5 <= 0.39 && $6 <= 0.39 ) {print $1"\t"$2"\t"$3}' ${data_prefix}PantheraOnca.bed > ${data_prefix}PantheraOnca.filtered.bed

echo 'leopard'
./get_filtered_breaks_Ns.sh PantheraPardus leopard ${fasta_prefix}/PantheraPardus/PanPar_1.0.fixed.fa.masked
#awk '($4 == "False" && $5 <= 0.39 && $6 <= 0.39 ) {print $1"\t"$2"\t"$3}' ${data_prefix}PantheraPardus.bed > ${data_prefix}PantheraPardus.filtered.bed

echo 'lion'
./get_filtered_breaks_Ns.sh PantheraLeo lion ${fasta_prefix}/PantheraLeo/2016-06-22/PanLeo_1.0.fixed.fa.masked
#awk '($4 == "False" && $5 <= 0.39 && $6 <= 0.39 ) {print $1"\t"$2"\t"$3}' ${data_prefix}PantheraLeo.bed > ${data_prefix}PantheraLeo.filtered.bed

echo 'tiger'
./get_filtered_breaks_Ns.sh PantheraTigris tiger ${fasta_prefix}/PantheraTigris/2016-06-22/PanTig_1.0.fixed.fa.masked
#awk '($4 == "False" && $5 <= 0.39 && $6 <= 0.39 ) {print $1"\t"$2"\t"$3}' ${data_prefix}PantheraTigris.bed > ${data_prefix}PantheraTigris.filtered.bed

echo 'leopard cat'
./get_filtered_breaks_Ns.sh PrionailurusBengalensis leopard_cat ${fasta_prefix}/PrionailurusBengalensis/PriBen_1.0.fixed.fa.masked
#awk '($4 == "False" && $5 <= 0.39 && $6 <= 0.39 ) {print $1"\t"$2"\t"$3}' ${data_prefix}PrionailurusBengalensis.bed > ${data_prefix}PrionailurusBengalensis.filtered.bed

echo 'fishing cat'
./get_filtered_breaks_Ns.sh PrionailurusViverrinus fishing_cat ${fasta_prefix}/PrionailurusViverrinus/PriViv_1.0.fixed.fa.masked
#awk '($4 == "False" && $5 <= 0.39 && $6 <= 0.39 ) {print $1"\t"$2"\t"$3}' ${data_prefix}PrionailurusViverrinus.bed > ${data_prefix}PrionailurusViverrinus.filtered.bed

echo 'caracal'
./get_filtered_breaks_Ns.sh CaracalCaracal caracal ${fasta_prefix}/CaracalCaracal/CarCar_1.0.fixed.fa.masked
#awk '($4 == "False" && $5 <= 0.39 && $6 <= 0.39 ) {print $1"\t"$2"\t"$3}' ${data_prefix}CaracalCaracal.bed > ${data_prefix}CaracalCaracal.filtered.bed

echo 'lynx'
./get_filtered_breaks_Ns.sh LynxPardina lynx ${fasta_prefix}/LynxPardina/LynPar_1.0.fixed.fa.masked
#awk '($4 == "False" && $5 <= 0.39 && $6 <= 0.39 ) {print $1"\t"$2"\t"$3}' ${data_prefix}LynxPardina.bed > ${data_prefix}LynxPardina.filtered.bed

echo 'dog'
./get_filtered_breaks_Ns.sh CanisFamiliaris dog ${fasta_prefix}/outgroups/CanisFamiliaris/CanFam_3.1.fixed.fa.masked  
