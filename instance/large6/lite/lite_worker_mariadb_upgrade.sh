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
DB_ROOT_PASSWORD=CHANGEME
WORKERS=$(get_param lite_workers)

for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] upgrading ${DB_CONTAINER_NAME}"
    ssh -n $HOST "docker exec ${DB_CONTAINER_NAME} mysql_upgrade -p${DB_ROOT_PASSWORD}"&
done
wait
