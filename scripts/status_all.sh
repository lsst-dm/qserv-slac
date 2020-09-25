#!/bin/sh
set -e
DIR=$(cd "$(dirname "$0")"; pwd -P)
${DIR}/status.sh && ${DIR}/replication/status.sh
