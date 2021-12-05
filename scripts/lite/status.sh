#!/bin/bash

# Start the select services on the select nodes

set -e

# Load parameters of the setup into the corresponding environment
# variables

. $(dirname "$0")/env.sh

if [ -n "${CZAR_DB}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST 'echo "["'$CZAR'"] qserv czar mariadb: "$(docker ps -a | grep '$CZAR_DB_CONTAINER_NAME')'
fi
if [ -n "${CZAR_CMSD}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST 'echo "["'$CZAR'"] qserv czar cmsd:    "$(docker ps -a | grep '$CZAR_CMSD_CONTAINER_NAME')'
fi
if [ -n "${CZAR_XROOTD}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST 'echo "["'$CZAR'"] qserv czar xrootd:  "$(docker ps -a | grep '$CZAR_XROOTD_CONTAINER_NAME')'
fi
if [ -n "${CZAR_PROXY}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST 'echo "["'$CZAR'"] qserv czar proxy:   "$(docker ps -a | grep '$CZAR_PROXY_CONTAINER_NAME')'
fi
if [ -n "${CZAR_DEBUG}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST 'echo "["'$CZAR'"] qserv czar debug:   "$(docker ps -a | grep '$CZAR_DEBUG_CONTAINER_NAME')'
fi
for WORKER in $WORKERS; do
  HOST="qserv-${WORKER}"
  if [ -n "${WORKER_DB}" ]; then
    ssh -n $HOST 'echo "["'$WORKER'"] qserv worker mariadb: "$(docker ps -a | grep '$WORKER_DB_CONTAINER_NAME')'
  fi
  if [ -n "${WORKER_CMSD}" ]; then
    ssh -n $HOST 'echo "["'$WORKER'"] qserv worker cmsd:    "$(docker ps -a | grep '$WORKER_CMSD_CONTAINER_NAME')'
  fi
  if [ -n "${WORKER_XROOTD}" ]; then
    ssh -n $HOST 'echo "["'$WORKER'"] qserv worker xrootd:  "$(docker ps -a | grep '$WORKER_XROOTD_CONTAINER_NAME')'
  fi
done
if [ -n "${REPL_DB}" ]; then
  HOST="qserv-${MASTER}"
  ssh -n $HOST 'echo "["'$MASTER'"] repl mariadb: "$(docker ps -a | grep '$REPL_DB_CONTAINER_NAME')'
fi
if [ -n "${REPL_CONTR}" ]; then
  HOST="qserv-${MASTER}"
  ssh -n $HOST 'echo "["'$MASTER'"] repl contr:   "$(docker ps -a | grep '$REPL_CONTR_CONTAINER_NAME')'
fi
if [ -n "${REPL_TOOLS}" ]; then
  HOST="qserv-${MASTER}"
  ssh -n $HOST 'echo "["'$MASTER'"] repl tools:   "$(docker ps -a | grep '$REPL_TOOLS_CONTAINER_NAME')'
fi
for WORKER in $WORKERS; do
  HOST="qserv-${WORKER}"
  if [ -n "${REPL_WORKER}" ]; then
    ssh -n $HOST 'echo "["'$WORKER'"] repl worker:  "$(docker ps -a | grep '$REPL_WORKER_CONTAINER_NAME')'
  fi
done
