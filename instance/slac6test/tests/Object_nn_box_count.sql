SELECT COUNT(*)
FROM dp02_dc2_catalogs.Object AS o1,
     dp02_dc2_catalogs.Object AS o2
WHERE scisql_angSep(o1.coord_ra,o1.coord_dec,o2.coord_ra,o2.coord_dec) < 0.005
  AND scisql_s2PtInBox(o1.coord_ra,o1.coord_dec,59.4889268,-30.1764704,60.1022112,-29.6470592) = 1
  AND o1.objectId <> o2.objectId;

