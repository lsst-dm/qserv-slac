#!/bin/sh

set -e
set -x

function get_param {
    local path="$1"
    if [ ! -f "$path" ]; then
        >&2 echo "file not found: $path"
        return 1
    fi
    cat "$path"
}

QSERV_IMAGE_TAG="qserv/lite-qserv:2021.10.1-lite-rc2"
XROOTD_CONTAINER_NAME="qserv-6-worker-xrootd"
CONTAINER_UID=1000
CONTAINER_GID=1000
QSERV_BASE_DIR="/qserv/qserv-dev"
WORKERS=$(get_param lite_workers)

for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] starting ${XROOTD_CONTAINER_NAME}"
    ssh -n $HOST docker run \
        --network=host \
        --detach=true \
        --name "${XROOTD_CONTAINER_NAME}" \
        -u ${CONTAINER_UID}:${CONTAINER_GID} \
        -v /etc/passwd:/etc/passwd:ro \
        -v "${QSERV_BASE_DIR}/config-etc/cmsd.cfg:/config-etc/cmsd.cfg:ro" \
        -v "${QSERV_BASE_DIR}/config-etc/xrdssi.cfg:/config-etc/xrdssi.cfg:ro" \
        -v "${QSERV_BASE_DIR}/config-etc/log/xrootd.cfg:/config-etc/log/xrootd.cfg:ro" \
        -v "${QSERV_BASE_DIR}/var-run-xrootd:/var/run/xrootd" \
        -v "${QSERV_BASE_DIR}/log:/qserv/log" \
        -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
        -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
        -e "LSST_LOG_CONFIG=/config-etc/log/xrootd.cfg" \
        -e "XROOTD_CONTAINER_NAME=${XROOTD_CONTAINER_NAME}" \
        "${QSERV_IMAGE_TAG}" \
        bash -c \''xrootd -c /config-etc/cmsd.cfg -n worker -I v4 -l @libXrdSsiLog.so -+xrdssi /config-etc/xrdssi.cfg >& /qserv/log/${XROOTD_CONTAINER_NAME}.log'\'&
done;
wait
