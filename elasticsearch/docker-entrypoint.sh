#!/bin/bash

echo "HOME is ${HOME}"
echo "WHOAMI is `whoami`"

# elasticsearch entrypoint
if [ "$1" = 'elasticsearch' ]; then
    echo "[Run] Starting elasticsearch"

    su elasticsearch -s /bin/bash -c '/opt/elasticsearch/bin/elasticsearch'
    exit $?
fi

echo "[RUN]: Builtin command not provided [elasticsearch]"
echo "[RUN]: $@"

exec "$@"
