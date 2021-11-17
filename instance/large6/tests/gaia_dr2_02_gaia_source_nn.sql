SELECT o1.source_id AS id1,
       o2.source_id AS id2, 
       scisql_angSep(o1.ra,o1.dec,o2.ra,o2.dec) AS distance
FROM gaia_dr2_02.gaia_source AS o1, 
     gaia_dr2_02.gaia_source AS o2
WHERE scisql_s2PtInCircle(o1.ra,o1.dec,60.0,-30.0,0.40)=1
  AND scisql_angSep(o1.ra,o1.dec,o2.ra,o2.dec) < 0.0016 
  AND o1.source_id <> o2.source_id
