#!/bin/bash

# Reconfigure logger services of select workers

set -e

# Load parameters of the setup into the corresponding environment
# variables

. $(dirname "$0")/env.sh

if [ -n "${CZAR_DB}" ]; then
    >&2 echo "error: czar's mariadb service can't be reconfigured by this tool"
    exit 1
fi
if [ -n "${CZAR_CMSD}" ]; then
    sudo -u qserv vim ${QSERV_BASE_DIR}/config-etc/log/cmsd.cfg
fi
if [ -n "${CZAR_XROOTD}" ]; then
    sudo -u qserv vim ${QSERV_BASE_DIR}/config-etc/log/xrootd.cfg
    exit 1
fi
if [ -n "${CZAR_PROXY}" ]; then
    sudo -u qserv vim ${QSERV_BASE_DIR}/config-etc/log/proxy.cfg
fi
if [ -n "${CZAR_DEBUG}" ]; then
    >&2 echo "error: czar's debug service can't be reconfigured by this tool"
    exit 1
fi
if [ -n "${WORKER_DB}" ]; then
    >&2 echo "error: worker's mariadb service can't be reconfigured by this tool"
    exit 1
fi
if [ -n "${WORKER_CMSD}" ]; then
    update_config ${QSERV_BASE_DIR}/config-etc/log/cmsd.cfg
fi
if [ -n "${WORKER_XROOTD}" ]; then
    update_config ${QSERV_BASE_DIR}/config-etc/log/xrootd.cfg
fi
if [ -n "${REPL_DB}" ]; then
    >&2 echo "error: repolication system's mariadb service can't be reconfigured by this tool"
    exit 1
fi
if [ -n "${REPL_CONTR}" ]; then
    sudo -u qserv vim ${REPL_BASE_DIR}/config/log4cxx.replication.properties
fi
if [ -n "${REPL_WORKER}" ]; then
    update_config ${REPL_BASE_DIR}/config/log4cxx.replication.properties
fi
