#!/bin/sh
set -e
DIR=$(cd "$(dirname "$0")"; pwd -P)
${DIR}/status.sh --all && ${DIR}/replication/status.sh
