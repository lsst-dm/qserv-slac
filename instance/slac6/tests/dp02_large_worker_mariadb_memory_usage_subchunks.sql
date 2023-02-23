SELECT
  mt.id_truth_type AS mt_id_truth_type,
  mt.match_objectId AS mt_match_objectId,
  ts.ra AS ts_ra,
  ts.dec AS ts_dec,
  ts.truth_type AS ts_truth_type,
  ts.is_pointsource AS ts_is_pointsource,
  ts.redshift AS ts_redshift,
  scisql_nanojanskyToAbMag(ts.flux_u) AS ts_cModelMag_u,
  scisql_nanojanskyToAbMag(ts.flux_g) AS ts_cModelMag_g,
  scisql_nanojanskyToAbMag(ts.flux_r) AS ts_cModelMag_r,
  scisql_nanojanskyToAbMag(ts.flux_i) AS ts_cModelMag_i,
  scisql_nanojanskyToAbMag(ts.flux_z) AS ts_cModelMag_z,
  scisql_nanojanskyToAbMag(ts.flux_y) AS ts_cModelMag_y,
  obj.coord_ra AS ra,
  obj.coord_dec AS dec,
  obj.refExtendedness,
  scisql_nanojanskyToAbMag(obj.u_cModelFlux) AS cModelMag_u,
  scisql_nanojanskyToAbMag(obj.g_cModelFlux) AS cModelMag_g,
  scisql_nanojanskyToAbMag(obj.r_cModelFlux) AS cModelMag_r,
  scisql_nanojanskyToAbMag(obj.i_cModelFlux) AS cModelMag_i,
  scisql_nanojanskyToAbMag(obj.z_cModelFlux) AS cModelMag_z,
  scisql_nanojanskyToAbMag(obj.y_cModelFlux) AS cModelMag_y
FROM
  dp02_dc2_catalogs.MatchesTruth AS mt
  JOIN dp02_dc2_catalogs.TruthSummary AS ts ON mt.id_truth_type = ts.id_truth_type
  JOIN dp02_dc2_catalogs.Object AS obj ON mt.match_objectId = obj.objectId
WHERE
  obj.refExtendedness = 1
  AND obj.detect_isPrimary = 1
