SELECT ra,decl FROM dp02_dc2_catalogs.DiaObject WHERE scisql_s2PtInCPoly(ra,decl,60.0,-30.0,60.05,-30,60.05,-30.05,60,-30.05)=1 LIMIT 11
