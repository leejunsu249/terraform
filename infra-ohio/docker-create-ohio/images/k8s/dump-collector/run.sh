#!/usr/bin/env bash

while true; do
    echo "syncing /var/log/dumps to $S3bucket"
    rclone copy /var/log/dumps remote:$S3bucket

    echo "Checking /var/log/dumps size on the host"
    dumps_size=`du -s /var/log/dumps | awk '{print $1}'`
    if [ "$dumps_size" -ge 1000000 ]; then
        echo "Dumps size more than 1G, cleaning /dumps"
        rm -rf /var/log/dumps/*
    else echo "/var/log/dumps size is $dumps_size bytes and less than 1000000 (1G), nothing to do"
    fi

    sleep 60s
done