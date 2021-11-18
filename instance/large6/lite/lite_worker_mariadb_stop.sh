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
DB_CONTAINER_NAME="qserv-6-worker-mariadb"
WORKERS=$(get_param lite_workers)

for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] stopping ${DB_CONTAINER_NAME}"
    ssh -n $HOST "docker stop ${DB_CONTAINER_NAME}"&
done
wait
for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] removing ${DB_CONTAINER_NAME}"
    ssh -n $HOST "docker rm ${DB_CONTAINER_NAME}"&
done
wait
