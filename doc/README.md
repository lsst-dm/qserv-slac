1 Qserv
========

1.1 Managing containers
-----------------------
TBC...

2 Replication system
====================

2.1 Managing containers
-----------------------
TBC...

2.2 Running interactive commands in container `qserv-replica-tools`
-------------------------------------------------------------------
_NOTE_: this containers runs on the `master` node of a deployment.

First, one has to log into the container using:
```
docker exec -it qserv-replica-tools lsst bash
```
The `lsst` prefix before `bash` will setup the LSST `conda`-based Stack environment. The container provides:

* LSST Stack envirinment
* Replication system's tools (and libraries pre-configured in front of `LD_LIBRARY_PATH`):
```
     /qserv/bin
     /qserv/lib
```
* Environment variables:
```
     CONFIG
     INSTANCE_ID
     QSERV_MASTER_DB_PASSWORD
     AUTH_KET
     ADMIN_AUTH_KEY
```
* Access to the host machine's folders mapped into the container as:
```
     /qserv/replication/config
     /qserv/replication/log
     /qserv/replication/work
     /qserv/data/qserv
     /qserv/data/ingest
```

An example of using the container for debugging:
```
conda install gdb
gdb /qserv/bin/qserv-replica-messenger-test
```
Then in GDB one can do:
```
run db01 --config=$CONFIG --instance-id=$INSTANCE_ID --requests=20000 --max-active-requests=2000 --proc-time-sec=1 --expiration-ival-sec=4 --events-report-ival-sec=1
```

An example of running applications w/o GDB:
```
export LSST_LOG_CONFIG=/qserv/replication/config/log4cxx.replication.client.properties
export CMD="/qserv/bin/qserv-replica-messenger-test --config=$CONFIG --instance-id=$INSTANCE_ID"

$CMD db01 --requests=20000 --max-active-requests=2000 --proc-time-sec=1 --expiration-ival-sec=4 --events-report-ival-sec=1
```

