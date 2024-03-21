SELECT mt.id_truth_type, mt.match_objectId, obj.objectId, obj.detect_isPrimary, ts.ra, ts.dec, ts.redshift, ts.flux_u_noMW, ts.flux_g_noMW, ts.flux_r_noMW, ts.flux_i_noMW, ts.flux_z_noMW, ts.flux_y_noMW 
FROM dp02_dc2_catalogs.MatchesTruth AS mt 
JOIN dp02_dc2_catalogs.TruthSummary AS ts ON mt.id_truth_type=ts.id_truth_type 
JOIN dp02_dc2_catalogs.Object AS obj ON mt.match_objectId=obj.objectId 
WHERE obj.objectId IN(1248684569339625874, 1248684569339655215, 1248675773246632823)
AND ts.truth_type=1 
AND obj.detect_isPrimary=1
