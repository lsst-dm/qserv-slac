# Site-specific configuration
# ===========================

# Based on deps_20210514_1739, and included DM-26574 merged into the 'master' branch.
#BRANCH=2021.05.01
#BRANCH=2021.05.02

# Rolled back to the older stable version due to lock ups in the Qserv workers
# (presumably) cased by a change in the czar/workers protocol. The change was
# introduces in branch DM-2313.
#
# UPDATE: This branch has been tested and doesn't seem to have any worker lock-ups.
#BRANCH=deps_20210413_0808

# This container was built right after merging DM-2313. It's meant to test if the problem
# was caused by DM-2313, and not anyting else after that.
#BRANCH=deps_20210421_0122

# The experimental tag with optimized parametes preventing worker lock ups
# reported in DM-30236.
# UPDATE: still locks up.
#BRANCH=tickets_DM-30238

# The last stable branch that used to work in the "small" cluster
# for many weeks w/o showing any problems.
BRANCH=deps_20210106_0022

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
MASTER_ID=03

# Optional, default to <HOSTNAME_FORMAT>
MASTER_FORMAT="lsst-qserv-master%02g"

# Optional, default to <SSH_HOSTNAME_FORMAT>
# then $MASTER"
SSH_MASTER_FORMAT="qserv-master03"

# Format for all node's hostname
HOSTNAME_FORMAT="lsst-qserv-db%02g"

# Optional, format for node's ssh name
# Used at NCSA
SSH_HOSTNAME_FORMAT="qserv-db%02g"

# Workers range
WORKER_FIRST_ID=31
WORKER_LAST_ID=36

# The name of the Qserv containers
CONTAINER_NAME="qserv"

# Advanced configuration
# ======================

DIR=$(cd "$(dirname "$0")"; pwd -P)
. "${DIR}/common.sh"

