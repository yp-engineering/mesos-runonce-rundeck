#!/usr/bin/env bash

set -e

tmpdir=$(mktemp -d)
secret=$tmpdir/secret

echo -n $MESOS_SECRET > $secret

# If the user runs the job with rundeck debug on, debug this script as well.
if [ $RD_JOB_LOGLEVEL == "DEBUG" ]; then
  set -x
  DEBUG_OPTS="-logtostderr=true -v=2"
fi

function finish {
  rm -rf $tmpdir
}
trap finish EXIT ERR SIGINT SIGQUIT

mesos-runonce -master=$MESOS_MASTER:$MESOS_PORT \
        -address=$HOSTNAME \
        -principal=$MESOS_PRINCIPAL \
        -secret-file=$secret \
        $DEBUG_OPTS \
        $@
