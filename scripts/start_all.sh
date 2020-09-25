#!/bin/sh
set -e
DIR=$(cd "$(dirname "$0")"; pwd -P)
${DIR}/start.sh && ${DIR}/replication/start.sh
