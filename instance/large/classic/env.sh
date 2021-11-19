# Site-specific configuration
# ===========================

# The latest version of the Qserv container
#BRANCH=tickets_DM-26609
# A fix to the workers going unchecked and consuming over 29k threads
# in the heavy load scenario.
#BRANCH=tickets_DM-27334
# A fix to a possible race condition fixed in QueryRequest::ProcessResponse.
# This may cause spurious crashes of Qserv master.
#BRANCH=tickets_DM-27781

# The first version of Qserv build on top of XRootD v5 and the master branch
# of Qserv. Note, this tag excluded the aove explained fix for the race condition
# as per DM-27781. It's possible that race never existed, and crashes were caused
# by bugs in XRootD v4.
#BRANCH=deps_20201209_2324

# Another buf-fix version of Qserv based on XrootD v5. Same Qserv functionality
# as the previous one. This verson may potentially have lower performance due to
# additional reinforcements in the XRootD/SSI protocol.
#BRANCH=deps_20201210_0904

# Migrated worker class QueryRunner to use Boost Protobuf Arena. The container
# is build on top of deps_20201210_0904 plus minor changes in the logging.
# BRANCH=tickets_DM-27781

# Same as deps_20201210_0904 (no changes of DM-27781) plus Protobuf 3.14.0
# instead of 3.9.2 as it was in previous versions.
#BRANCH=deps_20201217_0012

# A new version of DM-27781 with minor changes in setting Protobuf object
# for MySQL where the crash was happening and additional printouts
# of strings in that context. This tag is bsed on deps_20201217_0012.
#BRANCH=tickets_DM-27781

# Includes everything mentioned above
#BRANCH=deps_20210106_0344

# Optimized czar-workers protocol
#BRANCH=tickets_DM-2313

# Includes the previous one. Query cancellation optimization.
#BRANCH=tickets_DM-29840

# Fixed a race condition in the Replication system's monitoring code within
# Qserv workers.
#BRANCH=tickets_DM-26574

# The latest stable branch (it doesn't include the previous fix of DM-26574)
#BRANCH=deps_20210514_1739

# Based on deps_20210514_1739, and included DM-26574 merged into the 'master' branch.
# BRANCH=2021.05.02

# The experimental tag with optimized parametes preventing worker lock ups
# reported in DM-30236.
#BRANCH=tickets_DM-30238

# The latest version for pre-production testing
#BRANCH=2021.06.01-rc1

# Another attempto to fix worker lock ups
#BRANCH=tickets_DM-30818

# The last stable branch that used to work in the "small" cluster
# for many weeks w/o showing any problems.
#BRANCH=deps_20210106_0022

# This branch excluded most problematic "improvements" made in Qserv since deps_20210106_0022
# This has been the most stable version so far. No worker crashes after after intensive testings
# on thousadnds of queries over 2 days.
# BRANCH=tickets_DM-30906

# Same as DM-30906 plus DM-28750
# BAD branch! Locks up on a large mix of queries.
#BRANCH=tickets_DM-30914

# The last stable release base on DM-30906
# BRANCH=2021.6.3-rc1

# Optimized handling of the large result queries
#BRANCH=tickets_DM-30942
#BRANCH=tickets_DM-31123
#BRANCH=tickets_DM-31185
BRANCH=tickets_DM-31537

# The latest stable release
#BRANCH=2021.8.1-rc1

# Scripts for modifying Qserv startup behavior
HOST_SCRIPTS_DIR=/qserv/qserv-prod/scripts

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

# The name of the Qserv containers
CONTAINER_NAME="qserv"

# Override default ports
WMGR_PORT=5013
CMSD_PORT=2132
XROOTD_PORT=1095
PROXY_PORT=4046
MYSQL_PORT=3366

# Advanced configuration
# ======================

DIR=$(cd "$(dirname "$0")"; pwd -P)
. "${DIR}/common.sh"

