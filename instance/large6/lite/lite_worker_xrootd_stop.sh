#!/bin/sh

set -e
#set -x

function get_param {
    local path="$1"
    if [ ! -f "$path" ]; then
        >&2 echo "file not found: $path"
        return 1
    fi
    cat "$path"
}
XROOTD_CONTAINER_NAME="qserv-6-worker-xrootd"
WORKERS=$(get_param lite_workers)

for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] stopping ${XROOTD_CONTAINER_NAME}"
    ssh -n $HOST "docker stop ${XROOTD_CONTAINER_NAME}"&
done
wait
for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] removing ${XROOTD_CONTAINER_NAME}"
    ssh -n $HOST "docker rm ${XROOTD_CONTAINER_NAME}"&
done
wait
