#!/bin/bash

prefix="/hive/groups/recon/projs/felidae_comp/synteny-play-ground/data/felidae/"

bed=$prefix/caracal/CaracalCaracal.FelisCatus.blocks.bed
echo 'caracal'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout| bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2420813187}' tmp
printf '\n'

bed=$prefix/cheetah/AcinonyxJubatus.FelisCatus.blocks.bed
echo 'cheetah'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2375874546}' tmp
printf '\n'

bed=$prefix/hyena/CrocutaCrocuta.FelisCatus.blocks.bed
echo 'hyena'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout |  bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2367466658}' tmp
printf '\n'

bed=$prefix/lynx/LynxPardina.FelisCatus.blocks.bed 
echo 'lynx'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2413209059}' tmp
printf '\n'

bed=$prefix/fishing_cat/PrionailurusViverrinus.FelisCatus.blocks.bed 
echo 'fishing cat'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2445568386}' tmp
printf '\n'

bed=$prefix/puma/PumaConcolor.FelisCatus.blocks.bed 
echo 'puma'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2525216212}' tmp
printf '\n'

bed=$prefix/lion/PantheraLeo.FelisCatus.blocks.bed
echo 'lion'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2442522584}' tmp
printf '\n'

bed=$prefix/jaguar/PantheraOnca.FelisCatus.blocks.bed
echo 'jaguar'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2405344986}' tmp
printf '\n'

bed=$prefix/leopard/PantheraPardus.FelisCatus.blocks.bed
echo 'leopard'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2578022254}' tmp
printf '\n'

bed=$prefix/tiger/PantheraTigris.FelisCatus.blocks.bed
echo 'tiger'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2391065193}' tmp
printf '\n'

bed=$prefix/leopard_cat/PrionailurusBengalensis.FelisCatus.blocks.bed
echo 'leopard cat'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2488918643}' tmp
printf '\n'

bed=$prefix/dog/CanisFamiliaris.FelisCatus.blocks.bed
echo 'dog'
wc -l $bed
cut -f4,5,6 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2419229919}' tmp
cut -f1,2,3 $bed | bedSort stdin stdout | bedtools merge -i stdin > tmp
awk '{sum+=$3-$2} END {print sum/2410976875}' tmp
printf '\n'
