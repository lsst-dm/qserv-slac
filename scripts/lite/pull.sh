#!/bin/bash

# Start the select services on the select nodes

set -e

# Load parameters of the setup into the corresponding environment
# variables

. $(dirname "$0")/env.sh

if [ -n "${CZAR_DB}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST docker pull $DB_IMAGE_TAG&
fi
if [ -n "${CZAR_CMSD}${CZAR_XROOTD}${CZAR_PROXY}" ]; then
  HOST="qserv-${CZAR}"
  ssh -n $HOST docker pull $QSERV_IMAGE_TAG&
fi
for WORKER in $WORKERS; do
  HOST="qserv-${WORKER}"
  if [ -n "${WORKER_DB}" ]; then
    ssh -n $HOST docker pull $DB_IMAGE_TAG&
  fi
  if [ -n "${WORKER_CMSD}${WORKER_XROOTD}" ]; then
    ssh -n $HOST docker pull $QSERV_IMAGE_TAG&
  fi
done
wait
