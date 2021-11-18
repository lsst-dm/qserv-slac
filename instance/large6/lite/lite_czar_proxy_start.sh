#!/bin/sh

set -e
#set -x

QSERV_IMAGE_TAG="qserv/lite-qserv:2021.10.1-lite-rc2"
PROXY_CONTAINER_NAME="qserv-6-czar-proxy"
CONTAINER_UID=1000
CONTAINER_GID=1000
QSERV_BASE_DIR="/qserv/qserv-dev"
MASTER=master01
HOST="qserv-${MASTER}"

echo "[${MASTER}] starting mysql-proxy service"
ssh -n $HOST docker run \
    --network=host \
    --detach=true \
    --name "${PROXY_CONTAINER_NAME}" \
    -u ${CONTAINER_UID}:${CONTAINER_GID} \
    -v /etc/passwd:/etc/passwd:ro \
    -v "${QSERV_BASE_DIR}/config-etc/my-proxy.cnf:/config-etc/my-proxy.cnf:ro" \
    -v "${QSERV_BASE_DIR}/config-etc/qserv-czar.cnf:/config-etc/qserv-czar.cnf:ro" \
    -v "${QSERV_BASE_DIR}/config-etc/log/proxy.cfg:/config-etc/log/proxy.cfg:ro" \
    -v "${QSERV_BASE_DIR}/data/qserv:/qserv/data/qserv:ro" \
    -v "${QSERV_BASE_DIR}/log:/qserv/log" \
    -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
    -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
    -e "QSERV_CONFIG=/config-etc/qserv-czar.cnf" \
    -e "LSST_LOG_CONFIG=/config-etc/log/proxy.cfg" \
    -e "PROXY_CONTAINER_NAME=${PROXY_CONTAINER_NAME}" \
    "${QSERV_IMAGE_TAG}" \
    bash -c \''mysql-proxy --proxy-lua-script=/usr/local/lua/qserv/scripts/mysqlProxy.lua --lua-cpath=/usr/local/lua/qserv/lib/czarProxy.so --defaults-file=/config-etc/my-proxy.cnf >& /qserv/log/${PROXY_CONTAINER_NAME}.log'\'
