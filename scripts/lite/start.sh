#!/bin/bash

# Start the select services on the select nodes

set -e

# Load parameters of the setup into the corresponding environment
# variables

. $(dirname "$0")/env.sh

if [ -n "${CZAR_DB}" ]; then
  HOST="qserv-${CZAR}"
  echo "[${CZAR}] starting czar mariadb"
  ssh -n $HOST docker run \
    --network=host \
    --detach=true \
    --name="${CZAR_DB_CONTAINER_NAME}" \
    -u ${CONTAINER_UID}:${CONTAINER_GID} \
    -v /etc/passwd:/etc/passwd:ro \
    -v "${QSERV_BASE_DIR}/data/mysql:/var/lib/mysql" \
    -v "${QSERV_BASE_DIR}/log:${QSERV_BASE_DIR}/log" \
    -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
    -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
    -v "${QSERV_BASE_DIR}/var-run-mysqld:/var/run/mysqld" \
    -e "MYSQL_ROOT_PASSWORD=${QSERV_CZAR_DB_ROOT_PASSWORD}" \
    "${QSERV_DB_IMAGE_TAG}" \
    --port="${QSERV_CZAR_DB_PORT}" \
    --socket=/var/run/mysqld/mysqld.sock \
    --max-connections=16384 \
    --connect_timeout=28800 \
    --net_read_timeout=90000 \
    --net_write_timeout=90000 \
    --wait_timeout=90000 \
    --symbolic-links=0 \
    --tmp_table_size=4G \
    --max_heap_table_size=4G \
    --use_stat_tables=PREFERABLY \
    --optimizer_use_condition_selectivity=3 \
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
    --name="${CZAR_CMSD_CONTAINER_NAME}" \
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
    bash -c \''cmsd -c /config-etc/cmsd.cnf -n manager -I v4 2>&1 >> /qserv/log/${CONTAINER_NAME}.log'\'
fi

if [ -n "${CZAR_XROOTD}" ]; then
  HOST="qserv-${CZAR}"
  echo "[${CZAR}] starting xrootd"
  ssh -n $HOST docker run \
    --network=host \
    --detach=true \
    --name="${CZAR_XROOTD_CONTAINER_NAME}" \
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
    bash -c \''xrootd -c /config-etc/xrootd.cnf -n manager -I v4 2>&1 >> /qserv/log/${CONTAINER_NAME}.log'\'
fi

if [ -n "${CZAR_PROXY}" ]; then
  HOST="qserv-${CZAR}"
  echo "[${CZAR}] starting proxy"
  ssh -n $HOST docker run \
      --network=host \
      --detach=true \
      --name="${CZAR_PROXY_CONTAINER_NAME}" \
      -u ${CONTAINER_UID}:${CONTAINER_GID} \
      -v /etc/passwd:/etc/passwd:ro \
      -v "${QSERV_BASE_DIR}/config-etc/my-proxy.cnf:/config-etc/my-proxy.cnf:ro" \
      -v "${QSERV_BASE_DIR}/config-etc/qserv-czar.cnf:/config-etc/qserv-czar.cnf:ro" \
      -v "${QSERV_BASE_DIR}/config-etc/log/proxy.cfg:/config-etc/log/proxy.cfg:ro" \
      -v "${QSERV_BASE_DIR}/var-run-mysqld:/var/run/mysqld:ro" \
      -v "${QSERV_BASE_DIR}/data/qserv:/qserv/data/qserv:ro" \
      -v "${QSERV_BASE_DIR}/log:/qserv/log" \
      -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
      -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
      -e "QSERV_CONFIG=/config-etc/qserv-czar.cnf" \
      -e "LSST_LOG_CONFIG=/config-etc/log/proxy.cfg" \
      -e "CONTAINER_NAME=${CZAR_PROXY_CONTAINER_NAME}" \
      --ulimit=memlock=${ULIMIT_MEMLOCK} \
      "${QSERV_IMAGE_TAG}" \
      bash -c \''mysql-proxy --proxy-lua-script=/usr/local/lua/qserv/scripts/mysqlProxy.lua --lua-cpath=/usr/local/lua/qserv/lib/czarProxy.so --defaults-file=/config-etc/my-proxy.cnf --log-file=/qserv/log/${CONTAINER_NAME}.mysql-proxy.log 1>&2 >> /qserv/log/${CONTAINER_NAME}.log'\'
fi

# --cap-add sys_admin --cap-add sys_ptrace

if [ -n "${CZAR_DEBUG}" ]; then
  HOST="qserv-${CZAR}"
  echo "[${CZAR}] starting debug"
  ssh -n $HOST docker run \
      --privileged \
      --cap-add=SYS_PTRACE \
      --network=host \
      --detach=true \
      --name="${CZAR_DEBUG_CONTAINER_NAME}" \
      -u root \
      -v /etc/passwd:/etc/passwd:ro \
      -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
      -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
      -e "CONTAINER_NAME=${CZAR_DEBUG_CONTAINER_NAME}" \
      "${QSERV_IMAGE_TAG}" \
      bash -c \''yum -y install gdb && tail -f /dev/null'\'
fi

if [ -n "${WORKER_DB}" ]; then
  for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] starting mariadb"
    ssh -n $HOST docker run \
        --network=host \
        --detach=true \
        --name="${WORKER_DB_CONTAINER_NAME}" \
        -u ${CONTAINER_UID}:${CONTAINER_GID} \
        -v /etc/passwd:/etc/passwd:ro \
        -v "${QSERV_BASE_DIR}/data/mysql:/var/lib/mysql" \
        -v "${QSERV_BASE_DIR}/log:${QSERV_BASE_DIR}/log" \
        -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
        -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
        -e "MYSQL_ROOT_PASSWORD=${QSERV_WORKER_DB_ROOT_PASSWORD}" \
        "${QSERV_DB_IMAGE_TAG}" \
        --port="${QSERV_WORKER_DB_PORT}" \
        --max-connections=16384 \
        --connect_timeout=28800 \
        --net_read_timeout=90000 \
        --net_write_timeout=90000 \
        --wait_timeout=90000 \
        --symbolic-links=0 \
        --tmp_table_size=4G \
        --max_heap_table_size=4G \
        --use_stat_tables=PREFERABLY \
        --optimizer_use_condition_selectivity=3 \
        --query-cache-size=0 \
        --log-error="${QSERV_BASE_DIR}/log/${WORKER_DB_CONTAINER_NAME}.error.log" \
        --slow-query-log --slow-query-log-file="${QSERV_BASE_DIR}/log/${WORKER_DB_CONTAINER_NAME}.slow-query.log" \
        --log-warnings=2 \
        --pid-file="${QSERV_BASE_DIR}/log/${WORKER_DB_CONTAINER_NAME}.pid"&
  done
  wait
fi

if [ -n "${WORKER_CMSD}" ]; then
  for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] starting cmsd"
    ssh -n $HOST docker run \
        --network=host \
        --detach=true \
        --name="${WORKER_CMSD_CONTAINER_NAME}" \
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
        bash -c \''cmsd -c /config-etc/cmsd.cfg -n worker -I v4 -l @libXrdSsiLog.so -+xrdssi /config-etc/xrdssi.cfg 2>&1 >> /qserv/log/${CONTAINER_NAME}.log'\'&
  done
  wait
fi

if [ -n "${WORKER_XROOTD}" ]; then
  for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] starting xrootd"
    ssh -n $HOST docker run \
        --network=host \
        --detach=true \
        --name="${WORKER_XROOTD_CONTAINER_NAME}" \
        -u ${CONTAINER_UID}:${CONTAINER_GID} \
        -v /etc/passwd:/etc/passwd:ro \
        -v "${QSERV_BASE_DIR}/config-etc/cmsd.cfg:/config-etc/cmsd.cfg:ro" \
        -v "${QSERV_BASE_DIR}/config-etc/xrdssi.cfg:/config-etc/xrdssi.cfg:ro" \
        -v "${QSERV_BASE_DIR}/config-etc/log/xrootd.cfg:/config-etc/log/xrootd.cfg:ro" \
        -v "${QSERV_BASE_DIR}/var-run-xrootd:/var/run/xrootd" \
        -v "${QSERV_BASE_DIR}/data/mysql:/qserv/data/mysql:ro" \
        -v "${QSERV_BASE_DIR}/log:/qserv/log" \
        -v "${QSERV_BASE_DIR}/core-files:/tmp/core-files" \
        -v "${QSERV_BASE_DIR}/qserv:/home/qserv" \
        -e "LSST_LOG_CONFIG=/config-etc/log/xrootd.cfg" \
        -e "CONTAINER_NAME=${WORKER_XROOTD_CONTAINER_NAME}" \
        --ulimit memlock=${ULIMIT_MEMLOCK} \
        "${QSERV_IMAGE_TAG}" \
        bash -c \''xrootd -c /config-etc/cmsd.cfg -n worker -I v4 -l @libXrdSsiLog.so -+xrdssi /config-etc/xrdssi.cfg 2>&1 >> /qserv/log/${CONTAINER_NAME}.log'\'&
  done
  wait
fi

if [ -n "${REPL_DB}" ]; then
  HOST="qserv-${MASTER}"
  echo "[${MASTER}] starting repl mariadb"
  ssh -n $HOST docker run \
      --detach=true \
      --network=host \
      --name="${REPL_DB_CONTAINER_NAME}" \
      -u ${CONTAINER_UID}:${CONTAINER_GID} \
      -v /etc/passwd:/etc/passwd:ro \
      -v "${REPL_BASE_DIR}/mysql:/var/lib/mysql" \
      -v "${REPL_BASE_DIR}/log:${REPL_BASE_DIR}/log" \
      -v "${REPL_BASE_DIR}/config/docker/etc/mysql/conf.d/docker.cnf:/etc/mysql/conf.d/docker.cnf:ro" \
      -e "MYSQL_ROOT_PASSWORD=${REPL_DB_ROOT_PASSWORD}" \
      "${REPL_DB_IMAGE_TAG}" \
      --port="${REPL_DB_PORT}" \
      --max-connections=16384 \
      --connect_timeout=28800 \
      --net_read_timeout=86400 \
      --net_write_timeout=86400 \
      --wait_timeout=86400 \
      --innodb_lock_wait_timeout=3600 \
      --symbolic-links=0 \
      --tmp_table_size=4G \
      --max_heap_table_size=4G \
      --query-cache-size=0 \
      --log-error="${REPL_BASE_DIR}/log/${REPL_DB_CONTAINER_NAME}.error.log" \
      --slow-query-log --slow-query-log-file="${REPL_BASE_DIR}/log/${REPL_DB_CONTAINER_NAME}.slow-query.log" \
      --log-warnings=2 \
      --pid-file="${REPL_BASE_DIR}/log/${REPL_DB_CONTAINER_NAME}.pid"&
fi

if [ -n "${REPL_CONTR}" ]; then
  HOST="qserv-${MASTER}"
  echo "[${MASTER}] starting repl contr"
  ssh -n $HOST docker run \
      --privileged \
      --cap-add=SYS_PTRACE \
      --detach=true \
      --network=host \
      --memory=${REPL_MEMORY_LIMIT} \
      --name="${REPL_CONTR_CONTAINER_NAME}" \
      -u ${CONTAINER_UID}:${CONTAINER_GID} \
      -v "/etc/passwd:/etc/passwd:ro" \
      -v "${QSERV_BASE_DIR}/qserv:/qserv/data/qserv" \
      -v "${QSERV_BASE_DIR}/data/ingest:/qserv/data/ingest" \
      -v "${REPL_BASE_DIR}/work:/qserv/replication/work" \
      -v "${REPL_BASE_DIR}/config:/qserv/replication/config:ro" \
      -v "${REPL_BASE_DIR}/log:/qserv/replication/log" \
      -v "${REPL_BASE_DIR}/core-files:/tmp/core-files" \
      -v "${REPL_HTTP_ROOT_DIR}:/usr/local/qserv/www/" \
      -e "'REPL_CONTR_CONTAINER_NAME=${REPL_CONTR_CONTAINER_NAME}'" \
      -e "'REPL_CONTR_PARAMETERS=${REPL_CONTR_PARAMETERS}'" \
      -e "'LSST_LOG_CONFIG=/qserv/replication/config/${REPL_LSST_LOG_CONFIG}'" \
      -e "'REPL_DB_CONN=${REPL_DB_CONN}'" \
      -e "'REPL_INSTANCE_ID=${REPL_INSTANCE_ID}'" \
      -e "'QSERV_CZAR_DB_CONN=${QSERV_CZAR_DB_CONN}'" \
      -e "'REPL_AUTH_KEY=${REPL_AUTH_KEY}'" \
      -e "'REPL_ADMIN_AUTH_KEY=${REPL_ADMIN_AUTH_KEY}'" \
      "${REPL_IMAGE_TAG}" \
      bash -c \''qserv-replica-master-http ${REPL_CONTR_PARAMETERS} --config=${REPL_DB_CONN} --instance-id=${REPL_INSTANCE_ID} --qserv-czar-db="${QSERV_CZAR_DB_CONN}" --auth-key="${REPL_AUTH_KEY}" --admin-auth-key="${REPL_ADMIN_AUTH_KEY}" --http-root=/usr/local/qserv/www/ >& /qserv/replication/log/${REPL_CONTR_CONTAINER_NAME}.log'\'&
fi

if [ -n "${REPL_TOOLS}" ]; then
  HOST="qserv-${MASTER}"
  echo "[${MASTER}] starting repl tools"
  ssh -n $HOST docker run \
      --privileged \
      --cap-add=SYS_PTRACE \
      --detach=true \
      --network=host \
      --memory=${REPL_MEMORY_LIMIT} \
      --name="${REPL_TOOLS_CONTAINER_NAME}" \
      -u root \
      -v "/etc/passwd:/etc/passwd:ro" \
      -v "${QSERV_BASE_DIR}/qserv:/qserv/data/qserv" \
      -v "${QSERV_BASE_DIR}/data/ingest:/qserv/data/ingest" \
      -v "${REPL_BASE_DIR}/work:/qserv/replication/work" \
      -v "${REPL_BASE_DIR}/config:/qserv/replication/config:ro" \
      -v "${REPL_BASE_DIR}/log:/qserv/replication/log" \
      -v "${REPL_BASE_DIR}/core-files:/tmp/core-files" \
      -e "'LSST_LOG_CONFIG=/qserv/replication/config/${REPL_LSST_LOG_CONFIG}'" \
      -e "'REPL_DB_CONN=${REPL_DB_CONN}'" \
      -e "'REPL_INSTANCE_ID=${REPL_INSTANCE_ID}'" \
      -e "'QSERV_CZAR_DB_CONN=${QSERV_CZAR_DB_CONN}'" \
      -e "'REPL_AUTH_KEY=${REPL_AUTH_KEY}'" \
      -e "'REPL_ADMIN_AUTH_KEY=${REPL_ADMIN_AUTH_KEY}'" \
      "${REPL_IMAGE_TAG}" \
      bash -c \''yum -y install gdb && tail -f /dev/null'\'&
fi

if [ -n "${REPL_WORKER}" ]; then
  for WORKER in $WORKERS; do
    HOST="qserv-${WORKER}"
    echo "[${WORKER}] starting repl worker"
    ssh -n $HOST docker run \
        --privileged \
        --cap-add=SYS_PTRACE \
        --detach=true \
        --network=host \
        --memory=${REPL_MEMORY_LIMIT} \
        --name="${REPL_WORKER_CONTAINER_NAME}" \
        -u ${CONTAINER_UID}:${CONTAINER_GID} \
        -v /etc/passwd:/etc/passwd:ro \
        -v "${QSERV_BASE_DIR}/data:/qserv/data" \
        -v "${REPL_BASE_DIR}/config:/qserv/replication/config:ro" \
        -v "${REPL_BASE_DIR}/log:/qserv/replication/log" \
        -v "/datasets:/datasets:ro" \
        -v "/lsstdata:/lsstdata:ro" \
        -v "${REPL_BASE_DIR}/core-files:/tmp/core-files" \
        -e "'REPL_WORKER_CONTAINER_NAME=${REPL_WORKER_CONTAINER_NAME}'" \
        -e "'LSST_LOG_CONFIG=/qserv/replication/config/${REPL_LSST_LOG_CONFIG}'" \
        -e "'REPL_DB_CONN=${REPL_DB_CONN}'" \
        -e "'REPL_INSTANCE_ID=${REPL_INSTANCE_ID}'" \
        -e "'QSERV_WORKER_DB_CONN=${QSERV_WORKER_DB_CONN}'" \
        -e "'REPL_AUTH_KEY=${REPL_AUTH_KEY}'" \
        -e "'REPL_ADMIN_AUTH_KEY=${REPL_ADMIN_AUTH_KEY}'" \
       "${REPL_IMAGE_TAG}" \
        bash -c \''qserv-replica-worker ${REPL_WORKER_PARAMETERS} --config=${REPL_DB_CONN} --instance-id=${REPL_INSTANCE_ID} --qserv-worker-db="${QSERV_WORKER_DB_CONN}" --auth-key="${REPL_AUTH_KEY}" --admin-auth-key="${REPL_ADMIN_AUTH_KEY}" >& /qserv/replication/log/${REPL_WORKER_CONTAINER_NAME}.log'\' &
  done
fi
wait
