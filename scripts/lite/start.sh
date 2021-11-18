#!/bin/bash

# Start the select services on the select nodes

set -e

# Load parameters of the setup into the corresponding environment
# variables

. $(dirname "$0")/env.sh

if [ -n "${CZAR_DB}" ]; then
  HOST="qserv-${CZAR}"
  echo "[${CZAR}] starting mariadb"
  ssh -n $HOST docker run \
    --network=host \
    --detach=true \
    --name "${CZAR_DB_CONTAINER_NAME}" \
    -u ${CONTAINER_UID}:${CONTAINER_GID} \
    -v /etc/passwd:/etc/passwd:ro \
    -v "${QSERV_BASE_DIR}/data/mysql:/var/lib/mysql" \
    -v "${QSERV_BASE_DIR}/log:${QSERV_BASE_DIR}/log" \
    -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
    -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
    -e "MYSQL_ROOT_PASSWORD=${CZAR_DB_ROOT_PASSWORD}" \
    "${DB_IMAGE_TAG}" \
    --port="${CZAR_DB_PORT}" \
    --max-connections=16384 \
    --connect_timeout=28800 \
    --net_read_timeout=600 \
    --net_write_timeout=600 \
    --query-cache-size=0 \
    --log-error="${QSERV_BASE_DIR}/log/${CZAR_DB_CONTAINER_NAME}.error.log" \
    --slow-query-log --slow-query-log-file="${QSERV_BASE_DIR}/log/${CZAR_DB_CONTAINER_NAME}.slow-query.log" \
    --log-warnings=2 \
    --pid-file="${QSERV_BASE_DIR}/log/${CZAR_DB_CONTAINER_NAME}.pid"
fi

if [ -n "${CZAR_CMSD}" ]; then
  HOST="qserv-${CZAR}"
  echo "[${CZAR}] starting cmsd"
  ssh -n $HOST docker run \
    --network=host \
    --detach=true \
    --name "${CZAR_CMSD_CONTAINER_NAME}" \
    -u ${CONTAINER_UID}:${CONTAINER_GID} \
    -v /etc/passwd:/etc/passwd:ro \
    -v "${QSERV_BASE_DIR}/config-etc/cmsd.cnf:/config-etc/cmsd.cnf:ro" \
    -v "${QSERV_BASE_DIR}/config-etc/log/cmsd.cfg:/config-etc/log/cmsd.cfg:ro" \
    -v "${QSERV_BASE_DIR}/var-run-xrootd:/var/run/xrootd" \
    -v "${QSERV_BASE_DIR}/log:/qserv/log" \
    -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
    -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
    -e "LSST_LOG_CONFIG=/config-etc/log/cmsd.cfg" \
    -e "CONTAINER_NAME=${CZAR_CMSD_CONTAINER_NAME}" \
    "${QSERV_IMAGE_TAG}" \
    bash -c \''cmsd -c /config-etc/cmsd.cnf -n manager -I v4 >& /qserv/log/${CONTAINER_NAME}.log'\'
fi

if [ -n "${CZAR_XROOTD}" ]; then
  HOST="qserv-${CZAR}"
  echo "[${CZAR}] starting xrootd"
  ssh -n $HOST docker run \
    --network=host \
    --detach=true \
    --name "${CZAR_XROOTD_CONTAINER_NAME}" \
    -u ${CONTAINER_UID}:${CONTAINER_GID} \
    -v /etc/passwd:/etc/passwd:ro \
    -v "${QSERV_BASE_DIR}/config-etc/xrootd.cnf:/config-etc/xrootd.cnf:ro" \
    -v "${QSERV_BASE_DIR}/config-etc/log/xrootd.cfg:/config-etc/log/xrootd.cfg:ro" \
    -v "${QSERV_BASE_DIR}/var-run-xrootd:/var/run/xrootd" \
    -v "${QSERV_BASE_DIR}/log:/qserv/log" \
    -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
    -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
    -e "LSST_LOG_CONFIG=/config-etc/log/xrootd.cfg" \
    -e "CONTAINER_NAME=${CZAR_XROOTD_CONTAINER_NAME}" \
    "${QSERV_IMAGE_TAG}" \
    bash -c \''xrootd -c /config-etc/xrootd.cnf -n manager -I v4 >& /qserv/log/${CONTAINER_NAME}.log'\'
fi

if [ -n "${CZAR_PROXY}" ]; then
  HOST="qserv-${CZAR}"
  echo "[${CZAR}] starting proxy"
  ssh -n $HOST docker run \
      --network=host \
      --detach=true \
      --name "${CZAR_PROXY_CONTAINER_NAME}" \
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
      -e "CONTAINER_NAME=${CZAR_PROXY_CONTAINER_NAME}" \
      "${QSERV_IMAGE_TAG}" \
      bash -c \''mysql-proxy --proxy-lua-script=/usr/local/lua/qserv/scripts/mysqlProxy.lua --lua-cpath=/usr/local/lua/qserv/lib/czarProxy.so --defaults-file=/config-etc/my-proxy.cnf >& /qserv/log/${CONTAINER_NAME}.log'\'
fi

for WORKER in $WORKERS; do
  HOST="qserv-${WORKER}"
  if [ -n "${WORKER_DB}" ]; then
    echo "[${WORKER}] starting mariadb"
    ssh -n $HOST docker run \
        --network=host \
        --detach=true \
        --name "${WORKER_DB_CONTAINER_NAME}" \
        -u ${CONTAINER_UID}:${CONTAINER_GID} \
        -v /etc/passwd:/etc/passwd:ro \
        -v "${QSERV_BASE_DIR}/data/mysql:/var/lib/mysql" \
        -v "${QSERV_BASE_DIR}/log:${QSERV_BASE_DIR}/log" \
        -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
        -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
        -e "MYSQL_ROOT_PASSWORD=${WORKER_DB_ROOT_PASSWORD}" \
        "${DB_IMAGE_TAG}" \
        --port="${WORKER_DB_PORT}" \
        --max-connections=16384 \
        --connect_timeout=28800 \
        --net_read_timeout=600 \
        --net_write_timeout=600 \
        --query-cache-size=0 \
        --log-error="${QSERV_BASE_DIR}/log/${WORKER_DB_CONTAINER_NAME}.error.log" \
        --slow-query-log --slow-query-log-file="${QSERV_BASE_DIR}/log/${WORKER_DB_CONTAINER_NAME}.slow-query.log" \
        --log-warnings=2 \
        --pid-file="${QSERV_BASE_DIR}/log/${WORKER_DB_CONTAINER_NAME}.pid"&
  fi
  if [ -n "${WORKER_CMSD}" ]; then
    echo "[${WORKER}] starting cmsd"
    ssh -n $HOST docker run \
        --network=host \
        --detach=true \
        --name "${WORKER_CMSD_CONTAINER_NAME}" \
        -u ${CONTAINER_UID}:${CONTAINER_GID} \
        -v /etc/passwd:/etc/passwd:ro \
        -v "${QSERV_BASE_DIR}/config-etc/cmsd.cfg:/config-etc/cmsd.cfg:ro" \
        -v "${QSERV_BASE_DIR}/config-etc/xrdssi.cfg:/config-etc/xrdssi.cfg:ro" \
        -v "${QSERV_BASE_DIR}/config-etc/log/cmsd.cfg:/config-etc/log/cmsd.cfg:ro" \
        -v "${QSERV_BASE_DIR}/var-run-xrootd:/var/run/xrootd" \
        -v "${QSERV_BASE_DIR}/log:/qserv/log" \
        -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
        -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
        -e "LSST_LOG_CONFIG=/config-etc/log/cmsd.cfg" \
        -e "CONTAINER_NAME=${WORKER_CMSD_CONTAINER_NAME}" \
        "${QSERV_IMAGE_TAG}" \
        bash -c \''cmsd -c /config-etc/cmsd.cfg -n worker -I v4 -l @libXrdSsiLog.so -+xrdssi /config-etc/xrdssi.cfg >& /qserv/log/${CONTAINER_NAME}.log'\'
  fi
  if [ -n "${WORKER_XROOTD}" ]; then
    echo "[${WORKER}] starting xrootd"
    ssh -n $HOST docker run \
        --network=host \
        --detach=true \
        --name "${WORKER_XROOTD_CONTAINER_NAME}" \
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
        -e "CONTAINER_NAME=${WORKER_XROOTD_CONTAINER_NAME}" \
        "${QSERV_IMAGE_TAG}" \
        bash -c \''xrootd -c /config-etc/cmsd.cfg -n worker -I v4 -l @libXrdSsiLog.so -+xrdssi /config-etc/xrdssi.cfg >& /qserv/log/${CONTAINER_NAME}.log'\'
  fi
done
