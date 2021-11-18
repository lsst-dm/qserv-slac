#!/bin/bash

# This instance-specific script is supposed to be sourced from the Qserv
# management scripts in order to set up proper values of the corresponding
# parameters.

DB_IMAGE_TAG="qserv/lite-mariadb:2021.10.1-lite-rc2"
QSERV_IMAGE_TAG="qserv/lite-qserv:2021.10.1-lite-rc2"

CONTAINER_NAME_PREFIX="qserv-"

CZAR_DB_PORT=3366
WORKER_DB_PORT=3366

QSERV_BASE_DIR="/qserv/qserv-prod"

# Other parameters are set by the following script based on the above defined
# one, or be loaded from predefined locations.
. $(dirname "$0")/../../scripts/lite/common.sh
