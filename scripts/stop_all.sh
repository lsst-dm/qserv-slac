#!/bin/sh
set -t
DIR=$(cd "$(dirname "$0")"; pwd -P)
${DIR}/stop.sh && ${DIR}/replication/stop.sh
