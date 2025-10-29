#!/bin/bash -f
database=dp02_dc2_catalogs
outdir=management/materialize_subchunks/${database}/chunks
for c in $(cat ${outdir}/chunks.txt); do
    echo $c;
    for table in Object ObjectFullOverlap Source SourceFullOverlap DiaObject DiaObjectFullOverlap TruthSummary TruthSummaryFullOverlap; do
        mysql -h127.0.0.1 -P3368 -uroot -pCHANGEME \
            -e "ALTER TABLE dp02_dc2_catalogs.${table}_${c} REMOVE PARTITIONING"&
    done
    wait
done
