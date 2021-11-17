SELECT MIN(ra),MAX(ra),MIN(`dec`),MAX(`dec`) FROM dp01_dc2_catalogs.object;
+------------+------------+-------------+-------------+
| MIN(ra)    | MAX(ra)    | MIN(dec)    | MAX(dec)    |
+------------+------------+-------------+-------------+
| 49.4925469 | 74.2189082 | -44.6446955 | -26.9350876 |
+------------+------------+-------------+-------------+


SELECT o1.ObjectId AS id1,
       o2.ObjectId AS id2,
       scisql_angSep(o1.ra,o1.dec,o2.ra,o2.dec) AS distance
FROM dp01_dc2_catalogs.object AS o1,
     dp01_dc2_catalogs.object AS o2
WHERE scisql_s2PtInCircle(o1.ra,o1.dec,60.0,-30.0,0.40)=1
  AND scisql_angSep(o1.ra,o1.dec,o2.ra,o2.dec) < 0.0016
  AND o1.ObjectId <> o2.ObjectId;


SELECT o1.objectId AS id1,
       o2.objectId AS id2, 
       scisql_angSep(o1.psRa,o1.psDecl,o2.psRa,o2.psDecl) AS distance
FROM kpm50.Object AS o1, 
     kpm50.Object AS o2
WHERE scisql_s2PtInCircle(o1.psRa,o1.psDecl,60.0,-30.0,0.40)=1
  AND scisql_angSep(o1.psRa,o1.psDecl,o2.psRa,o2.psDecl) < 0.0016 
  AND o1.objectId <> o2.objectId;

