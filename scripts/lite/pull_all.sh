#!/bin/sh
set -e
DIR=$(cd "$(dirname "$0")"; pwd -P)
${DIR}/pull.sh --all && ${DIR}/replication/pull.sh
