#!/bin/bash


function defaults {
    : ${LOGSTASH_LOGFILE:="/opt/logstash/logs/logstash.log"}

    echo "JAVA_HOME is ${JAVA_HOME}"
    echo "HOME is ${HOME}"
    echo "WHOAMI is `whoami`"
    echo "LOGFILE is ${LOGSTASH_LOGFILE}"

    export LOGSTASH_LOGFILE
}


defaults

# logstash entrypoint
if [ "$1" = 'logstash' ]; then
    echo "[Run] Starting logstash"

    # allow logstash to use privileged port
    setcap 'cap_net_bind_service=+ep' /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java

    # Logstash logs to stdout even when logfile provided
    # Redirect stdout to /dev/null to prevent recursive ingestion of events via logspout
    su logstash -s /bin/bash -c "/opt/logstash/bin/logstash agent -f /opt/logstash/config/logstash.conf -l ${LOGSTASH_LOGFILE} > /dev/null"
    exit $?
fi

echo "[RUN]: Builtin command not provided [logstash]"
echo "[RUN]: $@"

exec "$@"
