# Docker version of the great [PyroCMS](https://pyrocms.com/).

## Before start ...

 - [Install Docker](https://docs.docker.com/engine/installation/)
 - [Install Docker Compose](https://docs.docker.com/compose/install/)
 - Gets familiar with Docker and Docker Compose (command line, options, docs). There is a great documentation in [this repository](https://github.com/veggiemonk/awesome-docker)

## Steps to get all up and running
### Set up MySQL service values
- Create a copy of `.env.dist`:
```shell
$ cp .env.dist .env
```
- Open the file `.env` and update the values as desired

### Set up PyroCMS install values
- Create a copy of `docker/php-fpm/.env.dist`:
```shell
$ cp docker/php-fpm/.env.dist docker/php-fpm/.env
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

### Bringing all services up
- Run the following commands:
```shell
$ docker-compose up -d --build --force-recreate

### Add the host name to your hosts files
- The name `pyrocms.local` should be added to the hosts files pointing to `localhost` or `127.0.0.1` for the application to work properly.

### Testing the application
- Open your preferred browser and type: `http://pyrocms.local/`
