SELECT o1.objectId AS id1,
       o2.objectId AS id2,
       scisql_angSep(o1.coord_ra,o1.coord_dec,o2.coord_ra,o2.coord_dec) AS d
FROM dp02_dc2_catalogs.Object AS o1,
     dp02_dc2_catalogs.Object AS o2
WHERE scisql_angSep(o1.coord_ra,o1.coord_dec,o2.coord_ra,o2.coord_dec) < 0.005
  AND o1.objectId <> o2.objectId
LIMIT 50000
