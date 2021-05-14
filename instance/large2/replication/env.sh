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
INSTANCE_ID=large2:qserv-prod

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

# The configuration files of the nginx web proxy
NGINX_CONFIG_DIR=${basedir}/nginx

# The home folder of the nginx web proxy. This folder also containes
# the Qserv Dashboard Web application.
NGINX_ROOT_DIR=/qserv/qserv-prod/management/qserv_web/www

# Tags for the relevant containers

# Running HTTP REST server of Master Controller in its won thread pool.
# The ticket includeds all prior developments mergd into the master branch.
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-27606"

# Reinforced table management operatons in Ingest workers.
# The ticket includeds all prior developments merged into the master branch.
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-27681"

# Improved file I/O error reporting at ingest worker services
# when ingesting from file:/// or http://
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-27772"

# Advanced test for the Messenger. The ticket includes the previous one.
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-27855"

# Testing crashes in client classes communicating with Qserv workers
# The branch is based on qserv/qserv:deps_20210106_0344.
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-27240"

# Same as above. Plus reinforced implementation of the database service
# managing the persistent state of replicas.
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-28047"

# Fixed a bug in the Controller-workers protocol (controller lockups)
# as per DM-27855. On-going develppment of the transaction contributions
# as per DM-26101.
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-26101"

# Includes all mentioned above. Plus a support for transaction contexts (requires
# extended schema for transaction table).
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-26172"

# Add support for XRootD/SSI reconnects
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-28606"

# Optimized implementation of jobs that operate over MySQL partitions
# at the transaction abort/commit time.
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-28603"

# Fixed a bug in the implementation of DatabaseServices::beginTransactionContrib
# that was causing problems when connecting to MySQL.
#REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-28812"

# Refactored the Configuration service to use JSON for the transient state.
REPLICATION_IMAGE_TAG="qserv/replica:tools-DM-28860"

DB_IMAGE_TAG="mariadb:10.2.16"
NGINX_IMAGE_TAG="nginx:latest"

DB_CONTAINER_NAME="qserv-replica-mariadb"
MASTER_CONTAINER_NAME="qserv-replica-master-http"
WORKER_CONTAINER_NAME="qserv-replica-worker"
NGINX_CONTAINER_NAME="qserv-replica-nginx"
TOOLS_CONTAINER_NAME="qserv-replica-tools"

WORKERS="$(get_param workers)"
MASTER="$(get_param master)"

DB_PORT=23306

DB_ROOT_PASSWORD="$(get_param secrets/db_root_password)"
QSERV_WORKER_DB_PASSWORD="$(get_param secrets/qserv_worker_db_password)"
QSERV_MASTER_DB_PASSWORD="$(get_param secrets/qserv_master_db_password)"

AUTH_KEY="$(get_param secrets/auth_key)"
ADMIN_AUTH_KEY="$(get_param secrets/admin_auth_key)"

CONFIG="mysql://qsreplica@lsst-qserv-${MASTER}:${DB_PORT}/qservReplica"

# Optional parameters of the Master Controller
MASTER_PARAMETERS="--debug --worker-evict-timeout=600 --health-probe-interval=120 --replication-interval=600 --qserv-sync-timeout=600"

# User account under which the containers will be run
CONTAINER_UID=1000
CONTAINER_GID=1000

unset basedir
unset -f get_param
