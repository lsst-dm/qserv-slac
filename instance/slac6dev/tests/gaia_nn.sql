SELECT
  gs1.source_id AS source_id_1,
  gs2.source_id AS source_id_2,
  scisql_angSep(gs1.ra, gs1.dec, gs2.ra, gs2.dec) AS distance
FROM
  gaia_dr2_02.gaia_source gs1,
  gaia_dr2_02.gaia_source gs2
WHERE
  scisql_angSep(gs1.ra, gs1.dec, gs2.ra, gs2.dec) < 0.016
  AND gs1.source_id <> gs2.source_id
LIMIT 10;
