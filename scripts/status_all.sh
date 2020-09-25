#!/bin/sh
set -t
DIR=$(cd "$(dirname "$0")"; pwd -P)
${DIR}/status.sh && ${DIR}/replication/status.sh
