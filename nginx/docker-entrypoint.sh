#!/bin/bash


# wait for a given host:port to become available
#
# $1 host
# $2 port
function dockerwait {
    while ! exec 6<>/dev/tcp/$1/$2; do
        echo "$(date) - waiting to connect $1 $2"
        sleep 5
    done
    echo "$(date) - connected to $1 $2"

    exec 6>&-
    exec 6<&-
}


# wait for services to become available
# this prevents race conditions using fig
function wait_for_services {
    if [[ "$WAIT_FOR_KIBANA" ]] ; then
        dockerwait $KIBANASERVER $KIBANAPORT
    fi
}


function defaults {
    : ${KIBANASERVER="kibana"}
    : ${KIBANAPORT="5601"}

    export KIBANAPORT KIBANASERVER
}


echo "HOME is ${HOME}"
echo "WHOAMI is `whoami`"

defaults
wait_for_services

# nginx entrypoint
if [ "$1" = 'nginx' ]; then
    echo "[Run] Starting nginx"

    /usr/sbin/nginx -g "daemon off;"
    exit $?
fi

echo "[RUN]: Builtin command not provided [nginx]"
echo "[RUN]: $@"

exec "$@"
