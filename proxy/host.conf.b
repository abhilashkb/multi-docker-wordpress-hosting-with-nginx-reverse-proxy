server{
        include /etc/nginx/listen_80;
#return 301 https://domainaddress$request_uri;
        server_name domainaddress;
#        access_log /var/log/nginx/domaindocker-access.log;
#        error_log /var/log/nginx/domaindocker-error.log;
        location / {
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
                proxy_pass http://domaindocker.wpress;
           }
include /etc/nginx/real_ip;
