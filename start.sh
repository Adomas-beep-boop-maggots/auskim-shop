#!/bin/bash

IP=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
url=http://$IP:1313

echo $url

hugo server --bind 0.0.0.0 --baseURL $url | tee hugo.log |
while read -r line
do
    if [ "$line" = "Press Ctrl+C to stop" ]
    then
        xdg-open $url
    fi
done

trap "killall hugo" SIGINT
sleep 10
