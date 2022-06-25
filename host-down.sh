#!/bin/bash

client_user=$1
url="$client_user.wpress"
php="$client_user.wps"



livesite=$2

if cat /etc/passwd | cut -d':' -f1 | grep -w $client_user ; then

sudo userdel $client_user


cd /home/$client_user/docker-compose

docker-compose down


rm -fr /home/$client_user/mysql

rm -fr /home/$client_user/www/

rm -fr /home/$client_user/docker-compose

rm -fr /home/$client_user/redis

rm -fr /home/$client_user/php-fpm

rm -fr /home/$client_user/nginx


rm -f  /usr/local/proxy/etc/site-enabled/"$client_user.wps"
rm -f /usr/local/proxy/etc/site-available/"$client_user.wps"

docker container restart proxy

fi
