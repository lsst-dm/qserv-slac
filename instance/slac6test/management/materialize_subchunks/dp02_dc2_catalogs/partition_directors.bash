#!/bin/bash -f
database=dp02_dc2_catalogs
outdir=management/materialize_subchunks/${database}/chunks
for c in $(cat ${outdir}/chunks.txt); do
    echo $c;
    for table in Object ObjectFullOverlap Source SourceFullOverlap DiaObject DiaObjectFullOverlap TruthSummary TruthSummaryFullOverlap; do
        mysql -h127.0.0.1 -P3368 -uroot -pCHANGEME \
            -e "ALTER TABLE dp02_dc2_catalogs.${table}_${c} PARTITION BY LIST (subChunkId) (PARTITION p0 VALUES IN (0), PARTITION p1 VALUES IN (1), PARTITION p2 VALUES IN (2), PARTITION p12 VALUES IN (12), PARTITION p13 VALUES IN (13),PARTITION p14 VALUES IN (14), PARTITION p24 VALUES IN (24), PARTITION p25 VALUES IN (25), PARTITION p26 VALUES IN (26))"&
    done
    wait
done
