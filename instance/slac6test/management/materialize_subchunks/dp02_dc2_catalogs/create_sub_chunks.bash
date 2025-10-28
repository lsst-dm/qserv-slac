#!/bin/bash -f
database=dp02_dc2_catalogs
outdir=management/materialize_subchunks/${database}/chunks
for c in $(cat ${outdir}/chunks.txt); do
    echo $c;
    for table in Object ObjectFullOverlap Source SourceFullOverlap DiaObject DiaObjectFullOverlap; do
        for sc in 0 1 2 12 13 14 24 25 26; do
            mysql -h127.0.0.1 -P3368 -uroot -pCHANGEME \
                -e "CREATE TABLE IF NOT EXISTS dp02_dc2_catalogs.${table}_${c}_${sc} ENGINE MyISAM SELECT * FROM dp02_dc2_catalogs.${table}_${c} WHERE subChunkId=${sc}"&
        done
    done
    wait
done
