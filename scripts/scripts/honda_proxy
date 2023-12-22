#!/bin/sh

cd $HOME/projects/honda/socks-to-http-proxy/

docker run \
    -d -it --rm \
    --network=host \
    -v "$HOME"/projects/honda/socks-to-http-proxy/urls:/url_files \
    s2h --filename /url_files/honda.txt --listen 127.0.0.1:6969 --socks5 127.0.0.1:1080

screen -dmS HONDA_PROXY bash -c 'ssh -N honda_proxy ; notify-send -u critical "HRI Proxy closed!"' 
