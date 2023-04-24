# Wordpress Hosting Setup with Docker Compose and Nginx Reverse Proxy

This project aims to provide a simple and flexible solution for hosting multiple WordPress websites on a single server using Docker Compose and Nginx Reverse Proxy.

## Requirements

- Docker Engine
- Docker Compose
- Git

## Installation

1. Clone the repository:

```sh
git clone https://github.com/abhilashkb/multi-docker-wordpress-hosting-with-nginx-reverse-proxy.git
cd multi-docker-wordpress-hosting-with-nginx-reverse-proxy
```
2. Setup front-end proxy server:

```sh
cd multi-docker-wordpress-hosting-with-nginx-reverse-proxy/proxy/
./host-up.sh username domainname.com
```
This will start Nginx reverse proxy server route the traffic to internal docker websites.


3. Start the containers:

```sh
./host-up.sh username domainname.com
```

This will start the following containers:

- `mysql`: the MySQL database server
- `phpmyadmin`: the web-based MySQL client
- `wordpress`: the WordPress application server

4. Configure the WordPress websites:

Visit `http://your-domain.com` in your web browser to configure your WordPress websites.

## Usage

### Start the containers

```sh
cd /home/username/docker-compose/
docker-compose up -d
```

### Stop the containers

```sh
cd /home/username/docker-compose/
docker-compose down
```

### Check the logs

```sh
docker-compose logs -f
```

### Backup the MySQL database

```sh
docker exec -t username_mysql sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > backup.sql
```

### Restore the MySQL database

```sh
cat backup.sql | docker exec -i username_mysql sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"'
```
