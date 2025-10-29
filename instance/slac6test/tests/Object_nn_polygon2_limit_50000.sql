SELECT o1.objectId AS id1,
       o2.objectId AS id2,
       scisql_angSep(o1.coord_ra,o1.coord_dec,o2.coord_ra,o2.coord_dec) AS d
FROM dp02_dc2_catalogs.Object AS o1,
     dp02_dc2_catalogs.Object AS o2
WHERE scisql_angSep(o1.coord_ra,o1.coord_dec,o2.coord_ra,o2.coord_dec)<0.005
  AND scisql_s2PtInCPoly(o1.coord_ra,o1.coord_dec,60.0,-30.0,60.05,-30,60.05,-30.05,60,-30.05)=1
  AND scisql_s2PtInCPoly(o2.coord_ra,o2.coord_dec,60.0,-30.0,60.05,-30,60.05,-30.05,60,-30.05)=1
  AND o1.objectId <> o2.objectId
LIMIT 50000
