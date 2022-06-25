 #!/bin/bash

domainname=$1


if dig a $1 +short | grep 198.244.147.208 ; then


mkdir -p /usr/local/proxy/letsencrypt/validation/${domainname}/.well-known/acme-challenge

docker run --rm -it --name certbot  -v "/usr/local/proxy/letsencrypt/etc:/etc/letsencrypt" -v "/usr/local/proxy/letsencrypt/validation/"${domainname}":/webroot/"  certbot/certbot certonly -d "${domainname}" --verbose --keep-until-expiring  --agree-tos --email issabhilashkb@gmail.com  --preferred-challenges=http  --webroot --webroot-path=/webroot


conf_file=`grep -irlw $domainname /usr/local/proxy/etc/ | xargs`

sed -i "s/domainssl/$domainname/g"  $conf_file
sed -i 's/\#return 301/return 301/g' $conf_file


docker container exec proxy nginx -s reload


fi
