#!/bin/bash
#
client_user=$1
url="$client_user.wpress"
php="$client_user.wps"

livesite=$2


if ! echo $livesite | grep -E "^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}$" ; then

echo invalid domain name
exit 0

fi




if ! cat /etc/passwd | cut -d':' -f1 | grep -w $client_user ; then

if ! grep -irl " $livesite" /usr/local/proxy/etc/ ; then

sudo useradd -d /home/$client_user $client_user

mkdir -p /home/$client_user/mysql

mkdir -p /home/$client_user/www/

mkdir -p /home/$client_user/docker-compose

mkdir -p /home/$client_user/redis

mkdir -p /home/$client_user/php-fpm

mkdir -p /home/$client_user/nginx


echo "COMPOSE_PROJECT_NAME=$client_user" > /home/$client_user/docker-compose/.env
echo "user=$client_user" >> /home/$client_user/docker-compose/.env
echo "mysqlroot=`openssl rand -base64 12|tr -dc 'a-zA-Z0-9' `" >> /home/$client_user/docker-compose/.env
echo "wppass=`openssl rand -base64 12|tr -dc 'a-zA-Z0-9' `" >> /home/$client_user/docker-compose/.env
echo "domain=$livesite" >> /home/$client_user/docker-compose/.env


cp /root/docker-hosting/docker-compose.yml /home/$client_user/docker-compose/docker-compose.yml
cp /root/docker-hosting/nginx.conf /home/$client_user/nginx/nginx.conf
sed -i "s/domain/$url/g" /home/$client_user/nginx/nginx.conf
sed -i "s/wordpress/$php/g" /home/$client_user/nginx/nginx.conf


cd /home/$client_user/docker-compose/ && docker-compose up -d

cp /root/docker-hosting/proxy/host.conf /usr/local/proxy/etc/site-available/"$client_user.wps"

sed -i "s/domaindocker/$client_user/g"  /usr/local/proxy/etc/site-available/"$client_user.wps"
sed -i "s/domainaddress/$livesite/g"  /usr/local/proxy/etc/site-available/"$client_user.wps"


cp -r /root/docker-hosting/phpMyAdmin /home/${client_user}/www/
sed -i "s/dockermysqlhost/${client_user}.mql/g" /home/${client_user}/www/phpMyAdmin/config.inc.php

ln  /usr/local/proxy/etc/site-available/"$client_user.wps" /usr/local/proxy/etc/site-enabled/"$client_user.wps"

docker container restart proxy
else

echo 'Domain already exists!!!'
fi

else

echo 'User already exists!!!'
fi
#docker network connect "${client_user}_wp-net" proxy
