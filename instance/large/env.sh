#!/bin/bash

# This instance-specific script is supposed to be sourced from the Qserv
# management scripts in order to set up proper values of the corresponding
# parameters.

DB_IMAGE_TAG="qserv/lite-mariadb:2021.10.1-lite-rc2"

# The curreht stable branch deployed in IDF
QSERV_IMAGE_TAG="qserv/lite-qserv:2021.10.1-lite-rc2"

# Igor's tag base on he master branch plus extended message logging
#QSERV_IMAGE_TAG="qserv/lite-qserv:2021.10.1-rc1-62-g1b3737d9e-dirty"

# John's original tag based on the PR of https://jira.lsstcorp.org/browse/DM-31537.
#QSERV_IMAGE_TAG="qserv/lite-qserv:2021.10.1-rc1-79-g86efba8bb"

# John's latest tag based on the PR of https://jira.lsstcorp.org/browse/DM-31537.
#QSERV_IMAGE_TAG="qserv/lite-qserv:2021.10.1-rc1-80-g34de04a0f"

# John's latest tag based on the PR of https://jira.lsstcorp.org/browse/DM-31537
# that that puts back the "LIMIT N" optimization implemented
# in https://jira.lsstcorp.org/browse/DM-30942
#QSERV_IMAGE_TAG="qserv/lite-qserv:2021.10.1-rc1-84-ga799207f0"

CONTAINER_NAME_PREFIX="qserv-"

CZAR_DB_PORT=3366
WORKER_DB_PORT=3366

QSERV_BASE_DIR="/qserv/qserv-prod"

# 10 GB
ULIMIT_MEMLOCK=10995116277760

# Other parameters are set by the following script based on the above defined
# one, or be loaded from predefined locations.
. $(dirname "$0")/../../scripts/lite/common.sh
