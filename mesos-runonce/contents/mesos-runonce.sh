#!/usr/bin/env bash

set -e

tmpdir=$(mktemp -d)
secret=$tmpdir/secret

echo -n $MESOS_SECRET > $secret

function finish {
  rm -rf $tmpdir
}
trap finish EXIT ERR SIGINT SIGQUIT

mesos-runonce -master=$MESOS_MASTER:$MESOS_PORT \
        -address=$HOSTNAME \
        -principal=$MESOS_PRINCIPLE \
        -secret-file=$secret $@
