SELECT COUNT(*)
FROM `dp02_dc2_catalogs`.`Object` AS `o`
JOIN `dp02_dc2_catalogs`.`Source` AS `s`
WHERE scisql_angSep(`o`.`coord_ra`,`o`.`coord_dec`,`s`.`coord_ra`,`s`.`coord_dec`) < 0.006
  AND scisql_s2PtInBox(`o`.`coord_ra`,`o`.`coord_dec`,59.4889268,-30.1764704,60.1022112,-29.6470592) = 1;
