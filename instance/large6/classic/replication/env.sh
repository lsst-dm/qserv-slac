#!/bin/bash

# This file is part of qserv.
#
# Developed for the LSST Data Management System.
# This product includes software developed by the LSST Project
# (https://www.lsst.org).
# See the COPYRIGHT file at the top-level directory of this distribution
# for details of code ownership.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
INSTANCE_ID=large6:qserv-dev

# Base directory where Qserv is installed on the worker nodes
QSERV_DATA_DIR="/qserv/qserv-dev/data"

# Base directory of the replication system on both master and worker nodes
REPLICATION_DATA_DIR="/qserv/qserv-dev/replication"

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

# Based on deps_20210520_0632
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-29880"

# Streamlined REST service for locating regular tables
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-30666"

# Automatically creating missing folders at master and worker servers
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-30074"

# Fixed a bug. Includes the previous tag that was already merged into the master branch.
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-31073"

# Improved Ingest system to support the binary data type in the table schema,
# quoted fields in the input files.
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-30103"

# Extended REST services of the Replication-Ingest system
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-31309"

# Extended configuration options for libcurl when pulling files from
# an object store.
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-31478"

# Extended Controller-workers protocol to make worker not depending
# on configuration parameters of the source replicas' workers.
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-26141"

# Added an option for ignoring duplicate keys when creating table-level
# indexes at workers.
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-31718"

# Extended states of the table schema contributions.
# ATTENTION: this requires the schema change for table 'transaction_contrib'.
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-31682"

# Asynchronous ingest. 
# ATTENTION: this requires the schema change for table 'transaction_contrib'.
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-30687"

# Fixed a bug in the ASYNC ingest in the group cancelation of
# the contribution requests by the transaction identifier.
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-32227"

# # Added support for many directors (API version 7)
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-28433"

# Priority-based request dispatcher at the Controller
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-32322"

# Serving static content from the Controller's HTTP server
# REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-32323"

# The first atempt to run the lite container
# REPLICATION_IMAGE_TAG="qserv/lite-qserv:2021.10.1-rc1-25-g8aa830e2a"

# DM-32444: Reinforce table registration service to enforce the right
#           ordering of tables.
# REPLICATION_IMAGE_TAG="qserv/lite-qserv:2021.10.1-rc1-31-ga9f566f8b"

# DM-32395: Qserv Replication system should scan all tables and retain
#           row counters in the persistent state.
# REPLICATION_IMAGE_TAG="qserv/lite-qserv:2021.10.1-rc1-61-gdefd950b0"

# DM-32810: Replication worker reads its identity dirctly from
#           the Qserv worker's database.
REPLICATION_IMAGE_TAG="qserv/lite-qserv:2021.10.1-rc1-83-geb1646869"

# DB_IMAGE_TAG="mariadb:10.2.16"
DB_IMAGE_TAG="qserv/lite-mariadb:2021.10.1-lite-rc2"

DB_CONTAINER_NAME="qserv-6-replica-mariadb"
MASTER_CONTAINER_NAME="qserv-6-replica-master-http"
WORKER_CONTAINER_NAME="qserv-6-replica-worker"
TOOLS_CONTAINER_NAME="qserv-6-replica-tools"

WORKERS="$(get_param workers)"
MASTER="$(get_param master)"

DB_PORT=23306
QSERV_CZAR_DB_PORT=3306
QSERV_WORKER_DB_PORT=3306

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

