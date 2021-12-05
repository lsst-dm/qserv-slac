#!/bin/bash

# This script is supposed to be sourced from the Qserv management scripts
# in order to set up proper values of the corresponding parameters.

basedir=$(dirname "$0")
if [ -z "$basedir" ] || [ "$0" = "bash" ]; then
    >&2 echo "error: variable 'basedir' is not defined"
    return 1 
fi
basedir=$(readlink -e "$basedir")
if [ ! -d "$basedir" ]; then
    >&2 echo "error: path 'basedir' is not a valid directory"
    return 1
fi

function get_param {
    local path="$basedir/$1"
    if [ ! -f "$path" ]; then
        >&2 echo "file not found: $path"
        return 1
    fi
    cat "$path"
}

function update_config {
    local config=$(basename $1)
    if [ -z "${config}" ]; then
        >&2 echo "no config file found in the input path: $1"
        return 1
    fi
    WORKER=$(echo $WORKERS | head -1 | awk '{print $1}')
    if [ ! -z "${WORKER}" ]; then
        HOST="qserv-${WORKER}"
        outfile="${1}"
        infile="/tmp/${config}.$(date +'%s')"
        scp ${HOST}:${outfile} $infile >& /dev/null
        vim $infile > /dev/tty
        for WORKER in $WORKERS; do
            echo "[${WORKER}] updating configuration at ${outfile}"
            HOST="qserv-${WORKER}"
            scp $infile ${HOST}:${infile} >& /dev/null
            ssh -n $HOST "sudo -u qserv cp $infile $outfile; rm $infile"
        done
        rm $infile
    else
        >&2 echo "error: no workers have been selected for the operation"
        exit 1
    fi
}


CZAR="$(get_param czar)"
MASTER="$(get_param master)"
ALL_WORKERS="$(get_param workers)"

CZAR_DB_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}czar-mariadb"
CZAR_CMSD_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}czar-cmsd"
CZAR_XROOTD_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}czar-xrootd"
CZAR_PROXY_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}czar-proxy"
CZAR_DEBUG_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}czar-debug"

WORKER_DB_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}worker-mariadb"
WORKER_CMSD_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}worker-cmsd"
WORKER_XROOTD_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}worker-xrootd"

REPL_DB_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}repl-mariadb"
REPL_CONTR_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}repl-contr"
REPL_TOOLS_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}repl-tools"
REPL_WORKER_CONTAINER_NAME="${CONTAINER_NAME_PREFIX}repl-worker"

QSERV_CZAR_DB_PASSWORD="$(get_param secrets/qserv_czar_db_root_password)"
QSERV_WORKER_DB_PASSWORD="$(get_param secrets/qserv_worker_db_root_password)"
REPL_DB_ROOT_PASSWORD="$(get_param secrets/repl_db_root_password)"
REPL_DB_QSREPLICA_PASSWORD="$(get_param secrets/repl_db_qsreplica_password)"
REPL_AUTH_KEY="$(get_param secrets/repl_auth_key)"
REPL_ADMIN_AUTH_KEY="$(get_param secrets/repl_admin_auth_key)"

QSERV_CZAR_DB_CONN="mysql://root:${QSERV_CZAR_DB_PASSWORD}@localhost:${QSERV_CZAR_DB_PORT}/qservMeta"
QSERV_WORKER_DB_CONN="mysql://root:${QSERV_WORKER_DB_PASSWORD}@localhost:${QSERV_WORKER_DB_PORT}/qservw_worker"
REPL_DB_CONN="mysql://qsreplica:${REPL_DB_QSREPLICA_PASSWORD}@lsst-qserv-${MASTER}:${REPL_DB_PORT}/qservReplica"

# User account under which the containers will be run
CONTAINER_UID=1000
CONTAINER_GID=1000

unset basedir
unset -f get_param

# Parse command-line options

HELP="
Usage:

    ${0} [OPTIONS]

General options:

    -h|--help
        print this help

Options restricting a scope of the operation:

    -a|--all
        Affects all serices of czar and the select workers.

    --worker=<name>
        Select a subset of workers affected by the operation. If '*' is specified
        in place of the worker name then the select services of all workers
        will be assumed. Note that single quotes are required here in order
        to prevent the shell from expanding the wildcard symbol into a list
        of local files in the current working directory.
        Notes:
          * applies to both Qserb and th eReplication system workers.
          * not using this option is equivalent to specifying --worker='*'.
          * passing the empty string --worker='' will exclude all workers.

Selectors for the Qserv czar:

    --czar-all
        Affects all services of czar.

    --czar-db
        MariaDB service of czar.

    --czar-cmsd
        Redirector service of czar.

    --czar-xrootd
        XROOTD service of czar.

    --czar-proxy
        MySQL proxy service of czar (the czar itself).

    ---czar-debug
        The side-cart container with GDB and other tools needed to debug
        problems in Qserv (inspecting core files, etc.).

Selectors for Qserv workers:

    --worker-all
        Affects all services of the select workers.

    --worker-db
        MariaDB service of the select workers.

    --worker-cmsd
        Redirector service of the select workers.

    --worker-xrootd
        XROOTD service of the select worker.

Selectors for the Replication/Ingest system services:

    --repl-all
        Affects all services of the system.

    --repl-contr
        Master Controller.

    --repl-tools
        Replication container that runs on the same host where the Master
        Controller is being run. The container shares the work directory
        of the Controller.

    --repl-db
        MariaDB service.

    --repl-worker
        Worker services (replicaton and ingest). Note that workers
        affected by the scripts are specified via the option --worker.
"

WORKERS="$ALL_WORKERS"

CZAR_ALL_SERVICES=
CZAR_DB=
CZAR_CMSD=
CZAR_XROOTD=
CZAR_PROXY=
CZAR_DEBUG=

WORKER_ALL_SERVICES=
WORKER_DB=
WORKER_CMSD=
WORKER_XROOTD=

REPL_ALL_SERVICES=
REPL_DB=
REPL_CONTR=
REPL_TOOLS=
REPL_WORKER=


for i in "$@"; do
    case $i in
    -a|--all)
        CZAR_DB=1
        CZAR_CMSD=1
        CZAR_XROOTD=1
        CZAR_PROXY=1
        CZAR_DEBUG=1
        WORKER_DB=1
        WORKER_CMSD=1
        WORKER_XROOTD=1
        REPL_DB=1
        REPL_CONTR=1
        REPL_TOOLS=1
        REPL_WORKER=1
        ;;
    --worker=*)
        WORKER="${i#*=}"
        if [ "${WORKER}" != "*" ]; then
            WORKERS=$WORKER
        fi
        unset WORKER
        ;;
    --czar-all)
        CZAR_DB=1
        CZAR_CMSD=1
        CZAR_XROOTD=1
        CZAR_PROXY=1
        CZAR_DEBUG=1
        ;;
    --czar-db)
        CZAR_DB=1
        ;;
    --czar-cmsd)
        CZAR_CMSD=1
        ;;
    --czar-xrootd)
        CZAR_XROOTD=1
        ;;
    --czar-proxy)
        CZAR_PROXY=1
        ;;
    --czar-debug)
        CZAR_DEBUG=1
        ;;
    --worker-all)
        WORKER_DB=1
        WORKER_CMSD=1
        WORKER_XROOTD=1
        ;;
    --worker-db)
        WORKER_DB=1
        ;;
    --worker-cmsd)
        WORKER_CMSD=1
        ;;
    --worker-xrootd)
        WORKER_XROOTD=1
        ;;
    --repl-all)
        REPL_DB=1
        REPL_CONTR=1
        REPL_TOOLS=1
        REPL_WORKER=1
        ;;
    --repl-db)
        REPL_DB=1
        ;;
    --repl-contr)
        REPL_CONTR=1
        ;;
    --repl-tools)
        REPL_TOOLS=1
        ;;
    --repl-worker)
        REPL_WORKER=1
        ;;
    -h|--help)
        (>&2 echo "${HELP}")
        return 2
        ;;
    *)
        >&2 echo "error: unknown option '${i}'${HELP}"
        return 1
        ;;
    esac
done
if [ -z "${CZAR_DB}${CZAR_CMSD}${CZAR_XROOTD}${CZAR_PROXY}${CZAR_DEBUG}${WORKER_DB}${WORKER_CMSD}${WORKER_XROOTD}${REPL_DB}${REPL_CONTR}${REPL_TOOLS}${REPL_WORKER}" ]; then
    >&2
echo "error: please, select services to be affected by the operation, or use -a|--all
       for all services
${HELP}"
    return 2
fi
unset HELP

