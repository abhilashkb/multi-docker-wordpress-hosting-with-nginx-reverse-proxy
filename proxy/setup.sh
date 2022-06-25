#!/bin/bash

mkdir -p /usr/local/proxy/{etc,letsencrypt,www}

cp ./default.conf /usr/local/proxy/etc/

mkdir /usr/local/proxy/etc/{site-enabled,site-available}

docker network create proxy_network

cd /root/docker-hosting/proxy

docker-compose up -d
