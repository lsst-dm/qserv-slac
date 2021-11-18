#!/bin/sh

set -e
#set -x

DB_IMAGE_TAG="qserv/lite-mariadb:2021.10.1-lite-rc2"
DB_CONTAINER_NAME="qserv-6-czar-mariadb"
DB_PORT=3306
DB_ROOT_PASSWORD=CHANGEME
CONTAINER_UID=1000
CONTAINER_GID=1000
QSERV_BASE_DIR="/qserv/qserv-dev"
MASTER=master01
HOST="qserv-${MASTER}"

echo "[${MASTER}] starting database service"
ssh -n $HOST docker run \
    --network=host \
    --detach=true \
    --name "${DB_CONTAINER_NAME}" \
    -u ${CONTAINER_UID}:${CONTAINER_GID} \
    -v /etc/passwd:/etc/passwd:ro \
    -v "${QSERV_BASE_DIR}/data/mysql:/var/lib/mysql" \
    -v "${QSERV_BASE_DIR}/log:${QSERV_BASE_DIR}/log" \
    -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
    -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
    -e "MYSQL_ROOT_PASSWORD=${DB_ROOT_PASSWORD}" \
    "${DB_IMAGE_TAG}" \
    --port="${DB_PORT}" \
    --max-connections=16384 \
    --connect_timeout=28800 \
    --net_read_timeout=600 \
    --net_write_timeout=600 \
    --query-cache-size=0 \
    --log-error="${QSERV_BASE_DIR}/log/${DB_CONTAINER_NAME}.error.log" \
    --slow-query-log --slow-query-log-file="${QSERV_BASE_DIR}/log/${DB_CONTAINER_NAME}.slow-query.log" \
    --log-warnings=2 \
    --pid-file="${QSERV_BASE_DIR}/log/${DB_CONTAINER_NAME}.pid"

