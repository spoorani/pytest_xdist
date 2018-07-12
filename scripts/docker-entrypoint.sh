#!/usr/bin/env sh


COMMON_LOG_FILE="/var/log/logging-bundle-test.log"

mkdir -p /var/log

touch $COMMON_LOG_FILE

python /opt/pytest-xdist/socketserver.py >> $COMMON_LOG_FILE 2>&1 &

xdistpid=$!

echo "Xdist socket pid: $xdistpid"

tail -f $COMMON_LOG_FILE &

wait $xdistpid
