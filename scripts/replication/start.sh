#!/bin/bash

# This file is part of qserv.
#
# Developed for the LSST Data Management System.
# This product includes software developed by the LSST Project
# (https://www.lsst.org).
# See the COPYRIGHT file at the top-level directory of this distribution
# for details of code ownership.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Start services on all nodes

set -e

# Load parameters of the setup into the corresponding environment
# variables

. $(dirname "$0")/env_svc.sh

# Optional setting of the JEMALLOC profiles

OPT_MALLOC_CONF=
OPT_LD_PRELOAD=
if [ ! -z "${USE_JEMALLOC}" ]; then
    OPT_MALLOC_CONF=prof_leak:true,lg_prof_interval:31,lg_prof_sample:22,prof_final:true
    OPT_LD_PRELOAD=/qserv/lib/libjemalloc.so
fi

# Start database services on the master node
#
# The general log is temporarily disabled because it results in a huge size
# of the log file.
#
#   --general-log --general-log-file="${DB_DATA_DIR}/log/${DB_CONTAINER_NAME}.general.log" \

if [ -n "${DB_SERVICE}" ]; then
    HOST="qserv-${MASTER}"
    echo "[${MASTER}] starting database service"
    ssh -n $HOST docker run \
        --detach \
        --name "${DB_CONTAINER_NAME}" \
        -u ${CONTAINER_UID}:${CONTAINER_GID} \
        -v /etc/passwd:/etc/passwd:ro \
        -v "${DB_DATA_DIR}/mysql:/var/lib/mysql" \
        -v "${DB_DATA_DIR}/log:${DB_DATA_DIR}/log" \
        -v "${DB_DATA_DIR}/config/docker/etc/mysql/conf.d/docker.cnf:/etc/mysql/conf.d/docker.cnf:ro" \
        -e "MYSQL_ROOT_PASSWORD=${DB_ROOT_PASSWORD}" \
        -p "${DB_PORT}:${DB_PORT}/tcp" \
        "${DB_IMAGE_TAG}" \
        --port="${DB_PORT}" \
        --max-connections=16384 \
        --connect_timeout=28800 \
        --net_read_timeout=600 \
        --net_write_timeout=600 \
        --query-cache-size=0 \
        --log-error="${DB_DATA_DIR}/log/${DB_CONTAINER_NAME}.error.log" \
        --slow-query-log --slow-query-log-file="${DB_DATA_DIR}/log/${DB_CONTAINER_NAME}.slow-query.log" \
        --log-warnings=2 \
        --pid-file="${DB_DATA_DIR}/log/${DB_CONTAINER_NAME}.pid" &
fi

# Start workers on all nodes
#
# ATTENTION: limit memory size of the containers by 40 GB due to a known memory
# management bug in the implementation of the worker services.

for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] starting worker agent"
    ssh -n $HOST docker run \
        --privileged \
        --cap-add=SYS_PTRACE \
        --detach \
        --network host \
        --memory 42949672960 \
        --name "${WORKER_CONTAINER_NAME}" \
        -u ${CONTAINER_UID}:${CONTAINER_GID} \
        -v /etc/passwd:/etc/passwd:ro \
        -v "${QSERV_DATA_DIR}:/qserv/data" \
        -v "${QSERV_DATA_DIR}/export:/qserv/data/export" \
        -v "${CONFIG_DIR}:/qserv/replication/config:ro" \
        -v "${LOG_DIR}:/qserv/replication/log" \
        -v "/datasets:/datasets:ro" \
        -v "/lsstdata:/lsstdata:ro" \
        -v "${CORE_FILES_DIR}:/tmp/core-files" \
        -e "WORKER_CONTAINER_NAME=${WORKER_CONTAINER_NAME}" \
        -e "LSST_LOG_CONFIG=/qserv/replication/config/${LOG_CONFIG}" \
        -e "CONFIG=${CONFIG}" \
        -e "INSTANCE_ID=${INSTANCE_ID}" \
        -e "WORKER=${WORKER}" \
        -e "QSERV_WORKER_DB=${QSERV_WORKER_DB}" \
        -e "AUTH_KEY=${AUTH_KEY}" \
        -e "ADMIN_AUTH_KEY=${ADMIN_AUTH_KEY}" \
       "${REPLICATION_IMAGE_TAG}" \
        bash -c \''lsst qserv-replica-worker ${WORKER} --config=${CONFIG} --instance-id=${INSTANCE_ID} --qserv-worker-db="${QSERV_WORKER_DB}" --auth-key="${AUTH_KEY}" --admin-auth-key="${ADMIN_AUTH_KEY}" --do-not-create-folders --debug >& /qserv/replication/log/${WORKER_CONTAINER_NAME}.log'\' &
done

# Start master controller

if [ -n "${MASTER_CONTROLLER}" ]; then
    HOST="qserv-${MASTER}"
    echo "[${MASTER}] starting master controller"
    ssh -n $HOST docker run \
        --privileged \
        --cap-add=SYS_PTRACE \
        --detach \
        --network host \
        --name "${MASTER_CONTAINER_NAME}" \
        -u ${CONTAINER_UID}:${CONTAINER_GID} \
        -v "/etc/passwd:/etc/passwd:ro" \
        -v "${WORK_DIR}:/qserv/replication/work" \
        -v "${QSERV_DATA_DIR}/qserv:/qserv/data/qserv" \
        -v "${QSERV_DATA_DIR}/ingest:/qserv/data/ingest" \
        -v "${CONFIG_DIR}:/qserv/replication/config:ro" \
        -v "${LOG_DIR}:/qserv/replication/log" \
        -v "${CORE_FILES_DIR}:/tmp/core-files" \
        -e "MASTER_CONTAINER_NAME=${MASTER_CONTAINER_NAME}" \
        -e "'PARAMETERS=${MASTER_PARAMETERS}'" \
        -e "LSST_LOG_CONFIG=/qserv/replication/config/${LOG_CONFIG}" \
        -e "CONFIG=${CONFIG}" \
        -e "INSTANCE_ID=${INSTANCE_ID}" \
        -e "OPT_MALLOC_CONF=${OPT_MALLOC_CONF}" \
        -e "OPT_LD_PRELOAD=${OPT_LD_PRELOAD}" \
        -e "QSERV_CZAR_DB=${QSERV_CZAR_DB}" \
        -e "AUTH_KEY=${AUTH_KEY}" \
        -e "ADMIN_AUTH_KEY=${ADMIN_AUTH_KEY}" \
        "${REPLICATION_IMAGE_TAG}" \
        bash -c \''lsst qserv-replica-master-http ${PARAMETERS} --config=${CONFIG} --instance-id=${INSTANCE_ID} --qserv-czar-db="${QSERV_CZAR_DB}" --auth-key="${AUTH_KEY}" --admin-auth-key="${ADMIN_AUTH_KEY}" --do-not-create-folders --debug >& /qserv/replication/log/${MASTER_CONTAINER_NAME}.log'\' &
fi

if [ -n "${TOOLS}" ]; then
    HOST="qserv-${MASTER}"
    echo "[${MASTER}] starting tools container for interactive operations"
    ssh -n $HOST docker run \
        --detach \
        --privileged \
        --cap-add=SYS_PTRACE \
        --network host \
        --name "${TOOLS_CONTAINER_NAME}" \
        -u ${CONTAINER_UID}:${CONTAINER_GID} \
        -v "/etc/passwd:/etc/passwd:ro" \
        -v "${WORK_DIR}:/qserv/replication/work" \
        -v "${QSERV_DATA_DIR}/qserv:/qserv/data/qserv" \
        -v "${QSERV_DATA_DIR}/ingest:/qserv/data/ingest" \
        -v "${CONFIG_DIR}:/qserv/replication/config:ro" \
        -v "${LOG_DIR}:/qserv/replication/log" \
        -v "${CORE_FILES_DIR}:/tmp/core-files" \
        -e "CONFIG=${CONFIG}" \
        -e "INSTANCE_ID=${INSTANCE_ID}" \
        -e "OPT_MALLOC_CONF=${OPT_MALLOC_CONF}" \
        -e "OPT_LD_PRELOAD=${OPT_LD_PRELOAD}" \
        -e "QSERV_CZAR_DB=${QSERV_CZAR_DB}" \
        -e "AUTH_KEY=${AUTH_KEY}" \
        -e "ADMIN_AUTH_KEY=${ADMIN_AUTH_KEY}" \
        "${REPLICATION_IMAGE_TAG}" \
        sleep 1000000000
fi

# Start nginx

if [ -n "${NGINX}" ]; then
    HOST="qserv-${MASTER}"
    echo "[${MASTER}] starting nginx"
    ssh -n $HOST docker run \
        --detach \
        --network host \
        --name "${NGINX_CONTAINER_NAME}" \
        -v "${NGINX_ROOT_DIR}:/usr/share/nginx/html:ro" \
        -v "${NGINX_CONFIG_DIR}/conf.d:/etc/nginx/conf.d:ro" \
        -v "/datasets:/datasets:ro" \
        "${NGINX_IMAGE_TAG}"
fi
unset basedir
wait
