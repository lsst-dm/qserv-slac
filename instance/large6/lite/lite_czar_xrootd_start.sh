#!/bin/sh

set -e
#set -x

QSERV_IMAGE_TAG="qserv/lite-qserv:2021.10.1-lite-rc2"
XROOTD_CONTAINER_NAME="qserv-6-czar-xrootd"
CONTAINER_UID=1000
CONTAINER_GID=1000
QSERV_BASE_DIR="/qserv/qserv-dev"
MASTER=master01
HOST="qserv-${MASTER}"

echo "[${MASTER}] starting xrootd service"
ssh -n $HOST docker run \
    --network=host \
    --detach=true \
    --name "${XROOTD_CONTAINER_NAME}" \
    -u ${CONTAINER_UID}:${CONTAINER_GID} \
    -v /etc/passwd:/etc/passwd:ro \
    -v "${QSERV_BASE_DIR}/config-etc/xrootd.cnf:/config-etc/xrootd.cnf:ro" \
    -v "${QSERV_BASE_DIR}/config-etc/log/xrootd.cfg:/config-etc/log/xrootd.cfg:ro" \
    -v "${QSERV_BASE_DIR}/var-run-xrootd:/var/run/xrootd" \
    -v "${QSERV_BASE_DIR}/log:/qserv/log" \
    -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
    -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
    -e "LSST_LOG_CONFIG=/config-etc/log/xrootd.cfg" \
    -e "XROOTD_CONTAINER_NAME=${XROOTD_CONTAINER_NAME}" \
    "${QSERV_IMAGE_TAG}" \
    bash -c \''xrootd -c /config-etc/xrootd.cnf -n manager -I v4 >& /qserv/log/${XROOTD_CONTAINER_NAME}.log'\'
