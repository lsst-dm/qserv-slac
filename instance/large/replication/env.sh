#!/bin/bash

# This script is supposed to be sourced from a client script in order
# to set up proper values of the corresponding parameters

basedir=$(dirname "$0")
if [ -z "$basedir" ] || [ "$0" = "bash" ]; then
    >&2 echo "error: variable 'basedir' is not defined"
    return 1 
fi
basedir=$(readlink -e "$basedir")
if [ ! -d "$basedir" ]; then
    >&2 echo "error: path 'basedir' is not a valid directory"
    return 1
fi

function get_param {
    local path="$basedir/$1"
    if [ ! -f "$path" ]; then
        >&2 echo "file not found: $path"
        return 1
    fi
    cat "$path"
}

# A unique identifier of a Qserv instance served by the setup
INSTANCE_ID=large:qserv-prod

# Base directory where Qserv is installed on the worker nodes
QSERV_DATA_DIR="/qserv/qserv-prod/data"

# Base directory of the replication system on both master and worker nodes
REPLICATION_DATA_DIR="/qserv/qserv-prod/replication"

# Base directory where the Replication system's MariaDB/MySQL service
# of the master node will create its folder 'mysql'
DB_DATA_DIR="${REPLICATION_DATA_DIR}"

# Configuration files of the Replication system's processes on both master
# and the worker nodes.   
CONFIG_DIR="${REPLICATION_DATA_DIR}/config"

# Log files of the Replication system's processes on both master
# and the worker nodes.   
LOG_DIR="${REPLICATION_DATA_DIR}/log"

# Configuration file of the Replication system's processes on both master
# and the worker nodes.   
LOG_CONFIG="log4cxx.replication.properties"

# Work directory for the applications. It can be used by applications
# to store core files, as well as various debug information.
WORK_DIR="${REPLICATION_DATA_DIR}/work"

# The home directory of the containers for dumping core files
CORE_FILES_DIR="${REPLICATION_DATA_DIR}/core-files"

# The home folder of the local development version of the Qserv Dashboard
# and other Web apps served by the built-in HTTP server of the Master
# Replication Controller.
HTTP_ROOT_DIR=/qserv/qserv-prod/management/qserv_web/www

# Tags for the relevant containers

# DM-32395: Qserv Replication system should scan all tables and retain
#           row counters in the persistent state.
#REPLICATION_IMAGE_TAG="qserv/lite-qserv:2021.10.1-rc1-61-gdefd950b0"
REPLICATION_IMAGE_TAG="qserv/lite-qserv:2021.10.1-rc1-62-g1b3737d9e-dirty"

# DB_IMAGE_TAG="mariadb:10.2.16"
DB_IMAGE_TAG="qserv/lite-mariadb:2021.10.1-lite-rc2"

DB_CONTAINER_NAME="qserv-replica-mariadb"
MASTER_CONTAINER_NAME="qserv-replica-master-http"
WORKER_CONTAINER_NAME="qserv-replica-worker"
TOOLS_CONTAINER_NAME="qserv-replica-tools"

WORKERS="$(get_param workers)"
MASTER="$(get_param master)"

DB_PORT=23366
QSERV_CZAR_DB_PORT=3366
QSERV_WORKER_DB_PORT=3366

DB_ROOT_PASSWORD="$(get_param secrets/db_root_password)"
QSERV_CZAR_DB_PASSWORD="$(get_param secrets/qserv_czar_db_password)"
QSERV_WORKER_DB_PASSWORD="$(get_param secrets/qserv_worker_db_password)"
DB_QSREPLICA_PASSWORD="$(get_param secrets/db_qsreplica_password)"

AUTH_KEY="$(get_param secrets/auth_key)"
ADMIN_AUTH_KEY="$(get_param secrets/admin_auth_key)"

CONFIG="mysql://qsreplica:${DB_QSREPLICA_PASSWORD}@lsst-qserv-${MASTER}:${DB_PORT}/qservReplica"
QSERV_CZAR_DB="mysql://root:${QSERV_CZAR_DB_PASSWORD}@localhost:${QSERV_CZAR_DB_PORT}/qservMeta"
QSERV_WORKER_DB="mysql://root:${QSERV_WORKER_DB_PASSWORD}@localhost:${QSERV_WORKER_DB_PORT}/qservw_worker"

# Optional parameters of the Master Controller
MASTER_PARAMETERS="--debug --worker-evict-timeout=600 --health-probe-interval=120 --replication-interval=600 --qserv-sync-timeout=600"

# User account under which the containers will be run
CONTAINER_UID=1000
CONTAINER_GID=1000

unset basedir
unset -f get_param

