SELECT COUNT(*) FROM kpm50.Object o1,kpm50.Object o2 WHERE scisql_angSep(o1.psRa,o1.psDecl,o2.psRa,o2.psDecl) < 0.015
