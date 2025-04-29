cmsd -c cmsd.cfg -n manager -I v4 -d -l @libXrdSsiLog.so >& cmsd.log&
xrootd -c xrootd.cfg -n manager -I v4 -d -l @libXrdSsiLog.so >& xrootd.log&
