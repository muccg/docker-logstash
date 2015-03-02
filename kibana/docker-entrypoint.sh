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
    if [[ "$WAIT_FOR_ELASTICSEARCH" ]] ; then
        dockerwait $ELASTICSEARCHSERVER $ELASTICSEARCHPORT
    fi
}


function defaults {
    : ${ELASTICSEARCHSERVER="elasticsearch"}
    : ${ELASTICSEARCHPORT="9200"}

    export ELASTICSEARCHPORT ELASTICSEARCHSERVER
}


echo "HOME is ${HOME}"
echo "WHOAMI is `whoami`"

defaults
wait_for_services

# kibana entrypoint
if [ "$1" = 'kibana' ]; then
    echo "[Run] Starting kibana"

    su kibana -s /bin/bash -c '/opt/kibana/bin/kibana'
    exit $?
fi

echo "[RUN]: Builtin command not provided [kibana]"
echo "[RUN]: $@"

exec "$@"
