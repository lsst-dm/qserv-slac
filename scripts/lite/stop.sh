#!/bin/bash

# Start the select services on the select nodes

set -e

# Load parameters of the setup into the corresponding environment
# variables

. $(dirname "$0")/env.sh

if [ -n "${CZAR_DB}" ]; then
    HOST="qserv-${CZAR}"
    ssh -n $HOST 'echo "["'$CZAR'"] qserv czar mariadb: "$(docker stop '$CZAR_DB_CONTAINER_NAME')" "$(docker rm '$CZAR_DB_CONTAINER_NAME')'&
fi
if [ -n "${CZAR_CMSD}" ]; then
    HOST="qserv-${CZAR}"
    ssh -n $HOST 'echo "["'$CZAR'"] qserv czar cmsd: "$(docker stop '$CZAR_CMSD_CONTAINER_NAME')" "$(docker rm '$CZAR_CMSD_CONTAINER_NAME')'&
fi
if [ -n "${CZAR_XROOTD}" ]; then
    HOST="qserv-${CZAR}"
    ssh -n $HOST 'echo "["'$CZAR'"] qserv czar xrootd: "$(docker stop '$CZAR_XROOTD_CONTAINER_NAME')" "$(docker rm '$CZAR_XROOTD_CONTAINER_NAME')'&
fi
if [ -n "${CZAR_PROXY}" ]; then
    HOST="qserv-${CZAR}"
    ssh -n $HOST 'echo "["'$CZAR'"] qserv czar proxy: "$(docker stop '$CZAR_PROXY_CONTAINER_NAME')" "$(docker rm '$CZAR_PROXY_CONTAINER_NAME')'&
fi
if [ -n "${CZAR_DEBUG}" ]; then
    HOST="qserv-${CZAR}"
    ssh -n $HOST 'echo "["'$CZAR'"] qserv czar debug: "$(docker stop '$CZAR_DEBUG_CONTAINER_NAME')" "$(docker rm '$CZAR_DEBUG_CONTAINER_NAME')'&
fi
for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    if [ -n "${WORKER_DB}" ]; then
        ssh -n $HOST 'echo "["'$WORKER'"] qserv worker mariadb: "$(docker stop '$WORKER_DB_CONTAINER_NAME')" "$(docker rm '$WORKER_DB_CONTAINER_NAME')'&
    fi
    if [ -n "${WORKER_CMSD}" ]; then
        ssh -n $HOST 'echo "["'$WORKER'"] qserv worker cmsd: "$(docker stop '$WORKER_CMSD_CONTAINER_NAME')" "$(docker rm '$WORKER_CMSD_CONTAINER_NAME')'&
    fi
    if [ -n "${WORKER_XROOTD}" ]; then
        ssh -n $HOST 'echo "["'$WORKER'"] qserv worker xrootd: "$(docker stop '$WORKER_XROOTD_CONTAINER_NAME')" "$(docker rm '$WORKER_XROOTD_CONTAINER_NAME')'&
    fi
done
if [ -n "${REPL_DB}" ]; then
  HOST="qserv-${MASTER}"
  ssh -n $HOST 'echo "["'$MASTER'"] repl mariadb: "$(docker stop '$REPL_DB_CONTAINER_NAME')" "$(docker rm '$REPL_DB_CONTAINER_NAME')'&
fi
if [ -n "${REPL_CONTR}" ]; then
  HOST="qserv-${MASTER}"
  ssh -n $HOST 'echo "["'$MASTER'"] repl contr: "$(docker stop '$REPL_CONTR_CONTAINER_NAME')" "$(docker rm '$REPL_CONTR_CONTAINER_NAME')'&
fi
if [ -n "${REPL_TOOLS}" ]; then
  HOST="qserv-${MASTER}"
  ssh -n $HOST 'echo "["'$MASTER'"] repl tools: "$(docker stop '$REPL_TOOLS_CONTAINER_NAME')" "$(docker rm '$REPL_TOOLS_CONTAINER_NAME')'&
fi
for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    if [ -n "${REPL_WORKER}" ]; then
        ssh -n $HOST 'echo "["'$WORKER'"] repl worker: "$(docker stop '$REPL_WORKER_CONTAINER_NAME')" "$(docker rm '$REPL_WORKER_CONTAINER_NAME')'&
    fi
done
wait
