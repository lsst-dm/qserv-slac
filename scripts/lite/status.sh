#!/bin/bash

# Start the select services on the select nodes

set -e

# Load parameters of the setup into the corresponding environment
# variables

. $(dirname "$0")/env.sh

if [ -n "${CZAR_DB}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST 'echo "["'$CZAR'"] mariadb: "$(docker ps -a | grep '$CZAR_DB_CONTAINER_NAME')'
fi
if [ -n "${CZAR_CMSD}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST 'echo "["'$CZAR'"] cmsd:    "$(docker ps -a | grep '$CZAR_CMSD_CONTAINER_NAME')'
fi
if [ -n "${CZAR_XROOTD}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST 'echo "["'$CZAR'"] xrootd:  "$(docker ps -a | grep '$CZAR_XROOTD_CONTAINER_NAME')'
fi
if [ -n "${CZAR_PROXY}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST 'echo "["'$CZAR'"] proxy:   "$(docker ps -a | grep '$CZAR_PROXY_CONTAINER_NAME')'
fi
for WORKER in $WORKERS; do
  HOST="qserv-${WORKER}"
  if [ -n "${WORKER_DB}" ]; then
    ssh -n $HOST 'echo "["'$WORKER'"] mariadb: "$(docker ps -a | grep '$WORKER_DB_CONTAINER_NAME')'
  fi
  if [ -n "${WORKER_CMSD}" ]; then
    ssh -n $HOST 'echo "["'$WORKER'"] cmsd:    "$(docker ps -a | grep '$WORKER_CMSD_CONTAINER_NAME')'
  fi
  if [ -n "${WORKER_XROOTD}" ]; then
    ssh -n $HOST 'echo "["'$WORKER'"] xrootd:  "$(docker ps -a | grep '$WORKER_XROOTD_CONTAINER_NAME')'
  fi
done
