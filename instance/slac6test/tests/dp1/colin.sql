SELECT Object.coord_dec,Object.coord_ra,Source.coord_ra, Source.coord_dec
FROM dp1.Object as Object
JOIN dp1.Source as Source
WHERE scisql_angSep(Object.coord_ra, Object.coord_dec, Source.coord_ra, Source.coord_dec) < 0.006
LIMIT 1000
