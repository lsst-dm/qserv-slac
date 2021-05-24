# Site-specific configuration
# ===========================

# Based on deps_20210514_1739, and included DM-26574 merged into the 'master' branch.
BRANCH=2021.05.02

# The experimental tag with optimized parametes preventing worker lock ups
# reported in DM-30236.
#BRANCH=tickets_DM-30238

# Scripts for modifying Qserv startup behavior
HOST_SCRIPTS_DIR=/qserv/qserv-dev/scripts

# Data directory location on docker host, optional
HOST_DATA_DIR=/qserv/qserv-dev/data

# Log directory location on docker host, optional
HOST_LOG_DIR=/qserv/qserv-dev/log

# Temporary directory location on docker host, optional
HOST_TMP_DIR=/qserv/qserv-dev/tmp

# The home directory of the containers for dumping core files
HOST_CORE_FILES_DIR=/qserv/qserv-dev/core-files

# ulimit memory lock setting, in bytes, optional
ULIMIT_MEMLOCK=10737418240

# Master id
MASTER_ID=01

# Optional, default to <HOSTNAME_FORMAT>
MASTER_FORMAT="lsst-qserv-master%02g"

# Optional, default to <SSH_HOSTNAME_FORMAT>
# then $MASTER"
SSH_MASTER_FORMAT="qserv-master${MASTER_ID}"

# Format for all node's hostname
HOSTNAME_FORMAT="lsst-qserv-db%02g"

# Optional, format for node's ssh name
# Used at NCSA
SSH_HOSTNAME_FORMAT="qserv-db%02g"

# Workers range
WORKER_FIRST_ID=01
WORKER_LAST_ID=06

# The name of the Qserv containers
CONTAINER_NAME="qserv-6"

# Override efault ports
WMGR_PORT=5013
CMSD_PORT=2132
XROOTD_PORT=1095
PROXY_PORT=4046
MYSQL_PORT=3366

# Advanced configuration
# ======================

DIR=$(cd "$(dirname "$0")"; pwd -P)
. "${DIR}/common.sh"

