SELECT o1.objectId AS id1,o2.objectId AS id2,scisql_angSep(o1.psRa,o1.psDecl,o2.psRa,o2.psDecl) AS distance FROM kpm50.Object AS o1,kpm50.Object AS o2 WHERE scisql_s2PtInCircle(o1.psRa,o1.psDecl,234.0,-90.0,0.40)=1 AND scisql_angSep(o1.psRa,o1.psDecl,o2.psRa,o2.psDecl) < 0.0016 AND o1.objectId <> o2.objectId

