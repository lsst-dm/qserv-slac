# Site-specific configuration
# ===========================

# The latest version of the Qserv container
#BRANCH=tickets_DM-26609
# A fix to the workers going unchecked and consuming over 29k threads
# in the heavy load scenario.
BRANCH=tickets_DM-27334

# Data directory location on docker host, optional
HOST_DATA_DIR=/qserv/qserv-prod/data

# Log directory location on docker host, optional
HOST_LOG_DIR=/qserv/qserv-prod/log

# Temporary directory location on docker host, optional
HOST_TMP_DIR=/qserv/qserv-prod/tmp

# The home directory of the containers for dumping core files
HOST_CORE_FILES_DIR=/qserv/qserv-prod/core-files

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
WORKER_LAST_ID=30

# Advanced configuration
# ======================

DIR=$(cd "$(dirname "$0")"; pwd -P)
. "${DIR}/common.sh"

