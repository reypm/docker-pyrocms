# Docker version of the great [PyroCMS](https://pyrocms.com/).

## Before start ...

 - [Install Docker](https://docs.docker.com/engine/installation/)
 - [Install Docker Compose](https://docs.docker.com/compose/install/)
 - Gets familiar with Docker and Docker Compose (command line, options, docs). There is a great documentation in [this repository](https://github.com/veggiemonk/awesome-docker)

> Note: in order to use this stack you *must* install Docker Compose 1.10+

## What's included
 - httpd 2.4.6
 - PHP 7.1.1 (php-fpm)
 - MariaDB (latest)
 - PyroCMS 3.2.2

## Steps to get all up and running
### Set up MySQL service values
- Create a copy of `.env.dist` or rename `.env.dist` to `.env`:
```shell
$ cp .env.dist .env
```
- Open the file `.env` and update the values as desired

### Set up PyroCMS install values
- Create a copy of `docker/php-fpm/container-files/tmp/.env.dist`:
```shell
$ cp docker/php-fpm/container-files/tmp/.env.dist docker/php-fpm/container-files/tmp/.env
```
- Open the file `.env` and update the values as desired

This is an example of the default values used:

```
APP_ENV=local
APP_DEBUG=true
APP_KEY=zfesbnTkXvooWVcsKMw2r4SmPVNGbFoS
DB_DRIVER=mysql
DB_HOST=db
DB_DATABASE=pyrocms
DB_USERNAME=root
DB_PASSWORD=1qazxsw2
APPLICATION_NAME=Default
APPLICATION_REFERENCE=default
APPLICATION_DOMAIN=localhost
ADMIN_EMAIL=test@email.com
ADMIN_USERNAME=admin
ADMIN_PASSWORD=1qazxsw2
LOCALE=en
TIMEZONE=UTC
```

> Note: if you've changed values for MySQL service at .env file then you need to
> change DB_DATABASE, DB_USERNAME and DB_PASSWORD at PyroCSM .env file

### Setting up PHP extensions

By default the `php-fpm` image ships with latest Composer installed but you can enable the following PHP extensions:
 - Xdebug
 - Mongo
 - Redis
 - Extended HTTP
 - Upload Progress
 - Extended Attributes

For example to enable Xdebug, open the file `.env` and change the `ARG` to `true`:
```shell
INSTALL_XDEBUG: "true"
```
The next time you run the command `docker-compose up -d --build --force-recreate` the new image will ship with Xdebug installed and enabled

### Persisting data
By default this stack is not persisting data so on each start|build you will have a clean instance of PyroCMS without any previous changes. If you want to persist data then setup the `docker-compose.yml` file as follow:

```shell
db:
    image: mariadb
    healthcheck:
        test: "exit 0"
    environment:
        MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
        MYSQL_DATABASE: ${MYSQL_DATABASE}
        MYSQL_USER: ${MYSQL_USER}
        MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
        - sql-data:/var/lib/mysql
volumes:
sql-data:
    external: true
```

### Bringing all services up & running
- Run the following command:
```shell
$ docker-compose up -d --build --force-recreate
```

The installation take a while, if you're impatient and want to know what's happening then take a look to the logs:

```shell
# Show the logs from all containers
$ docker-compose logs -f 

# Show the logs from php-fpm
$ docker logs -f dockerpyrocms_php-fpm_1

# Show the logs from httpd
$ docker logs -f dockerpyrocms_httpd_1
```

### Add the host name to your hosts files
- The name `pyrocms.local` should be added to the hosts files pointing to `localhost` or `127.0.0.1` for the application to work properly.

### Testing the application
- Open your preferred browser and type: `http://pyrocms.local/`
