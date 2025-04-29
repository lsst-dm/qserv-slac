SELECT
  o1.objectId AS objectId_1,
  o2.objectId AS objectId_2,
  scisql_angSep(o1.coord_ra, o1.coord_dec, o2.coord_ra, o2.coord_dec) AS distance,
  fs.*
FROM
  dp02_dc2_catalogs.Object o1,
  dp02_dc2_catalogs.Object o2,
  dp02_dc2_catalogs.ForcedSource fs
WHERE
  scisql_angSep(o1.coord_ra, o1.coord_dec, o2.coord_ra, o2.coord_dec) < 0.016
  AND o1.objectId <> o2.objectId
  AND o1.objectId = fs.objectId
LIMIT 10;
