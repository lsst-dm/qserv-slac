#!/bin/bash

# Reconfigure logger services of select workers

set -e

# Load parameters of the setup into the corresponding environment
# variables

. $(dirname "$0")/env.sh

if [ -n "${CZAR_DB}" ]; then
    sudo -u qserv rm -vf ${QSERV_BASE_DIR}/log/${CZAR_DB_CONTAINER_NAME}.*.log&
fi
if [ -n "${CZAR_CMSD}" ]; then
    sudo -u qserv rm -vf ${QSERV_BASE_DIR}/log/${CZAR_CMSD_CONTAINER_NAME}.log&
fi
if [ -n "${CZAR_XROOTD}" ]; then
    sudo -u qserv rm -vf ${QSERV_BASE_DIR}/log/${CZAR_XROOTD_CONTAINER_NAME}.log&
fi
if [ -n "${CZAR_PROXY}" ]; then
    sudo -u qserv rm -vf ${QSERV_BASE_DIR}/log/${CZAR_PROXY_CONTAINER_NAME}.mysql-proxy.log&
    sudo -u qserv rm -vf ${QSERV_BASE_DIR}/log/${CZAR_PROXY_CONTAINER_NAME}.log&
fi
if [ -n "${CZAR_DEBUG}" ]; then
    sudo -u qserv rm -vf ${QSERV_BASE_DIR}/log/${CZAR_DEBUG_CONTAINER_NAME}.log&
fi
if [ -n "${WORKER_DB}" ]; then
  for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    ssh -n $HOST 'sudo -u qserv rm -vf '${QSERV_BASE_DIR}'/log/'${WORKER_DB_CONTAINER_NAME}'.*.log'&
  done
fi
if [ -n "${WORKER_CMSD}" ]; then
  for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    ssh -n $HOST 'sudo -u qserv rm -vf '${QSERV_BASE_DIR}'/log/'${WORKER_CMSD_CONTAINER_NAME}'.log'&
  done
fi
if [ -n "${WORKER_XROOTD}" ]; then
  for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    ssh -n $HOST 'sudo -u qserv rm -vf '${QSERV_BASE_DIR}'/log/'${WORKER_XROOTD_CONTAINER_NAME}'.log'&
  done
fi
if [ -n "${REPL_DB}" ]; then
    sudo -u qserv rm -vf ${REPL_BASE_DIR}/log/${REPL_DB_CONTAINER_NAME}.*.log&
fi
if [ -n "${REPL_CONTR}" ]; then
    sudo -u qserv rm -vf ${REPL_BASE_DIR}/log/${REPL_CONTR_CONTAINER_NAME}.*.log&
fi
if [ -n "${REPL_TOOLS}" ]; then
    sudo -u qserv rm -vf ${REPL_BASE_DIR}/log/${REPL_TOOLS_CONTAINER_NAME}.*.log&
fi
if [ -n "${REPL_WORKER}" ]; then
  for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    ssh -n $HOST 'sudo -u qserv rm -vf '${REPL_BASE_DIR}'/log/'${REPL_WORKER_CONTAINER_NAME}'.log'&
  done
fi
wait
