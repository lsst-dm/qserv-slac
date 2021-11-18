#!/bin/sh

set -e
#set -x

QSERV_IMAGE_TAG="qserv/lite-qserv:2021.10.1-lite-rc2"
CMSD_CONTAINER_NAME="qserv-6-czar-cmsd"
CONTAINER_UID=1000
CONTAINER_GID=1000
QSERV_BASE_DIR="/qserv/qserv-dev"
MASTER=master01
HOST="qserv-${MASTER}"

echo "[${MASTER}] starting cmsd service"
ssh -n $HOST docker run \
    --network=host \
    --detach=true \
    --name "${CMSD_CONTAINER_NAME}" \
    -u ${CONTAINER_UID}:${CONTAINER_GID} \
    -v /etc/passwd:/etc/passwd:ro \
    -v "${QSERV_BASE_DIR}/config-etc/cmsd.cnf:/config-etc/cmsd.cnf:ro" \
    -v "${QSERV_BASE_DIR}/config-etc/log/cmsd.cfg:/config-etc/log/cmsd.cfg:ro" \
    -v "${QSERV_BASE_DIR}/var-run-xrootd:/var/run/xrootd" \
    -v "${QSERV_BASE_DIR}/log:/qserv/log" \
    -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
    -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
    -e "LSST_LOG_CONFIG=/config-etc/log/cmsd.cfg" \
    -e "CMSD_CONTAINER_NAME=${CMSD_CONTAINER_NAME}" \
    "${QSERV_IMAGE_TAG}" \
    bash -c \''cmsd -c /config-etc/cmsd.cnf -n manager -I v4 >& /qserv/log/${CMSD_CONTAINER_NAME}.log'\'
