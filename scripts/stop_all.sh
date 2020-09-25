#!/bin/sh
set -e
DIR=$(cd "$(dirname "$0")"; pwd -P)
${DIR}/stop.sh && ${DIR}/replication/stop.sh
