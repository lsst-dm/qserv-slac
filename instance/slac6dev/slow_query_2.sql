SELECT obj.objectId AS Object_ID,
       obj.coord_ra AS RA,
       obj.coord_dec AS DEC,
       obj.detect_isPrimary,
       obj.refExtendedness,
       obj.g_extendedness,
       obj.g_inputCount,
       src.ObjectId,
       src.ccdVisitId,
       src.band AS Filter,
       src.psfFlux,
       src.psfFluxErr,cv.expMidptMJD AS Epoch,scisql_nanojanskyToAbMag(src.psfFlux) AS Mag,mt.id_truth_type,mt.match_objectId,ts.ra,ts.dec,ts.truth_type,ts.is_variable,ts.is_pointsource 
FROM dp02_dc2_catalogs.Object AS obj
JOIN dp02_dc2_catalogs.ForcedSource AS src ON src.objectId=obj.objectId
JOIN dp02_dc2_catalogs.CcdVisit AS cv ON cv.ccdVisitId=src.ccdVisitId
JOIN dp02_dc2_catalogs.MatchesTruth AS mt ON mt.match_objectId=obj.objectId
JOIN dp02_dc2_catalogs.TruthSummary AS ts ON mt.id_truth_type=ts.id_truth_type
     WHERE ts.is_variable=1
       AND ts.truth_type=2
       AND ts.is_pointsource=1
       AND obj.detect_isPrimary=1
