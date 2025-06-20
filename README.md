# Develop plugin or theme with Docker

It provides WordPress, MariaDB, PHPMyAdmin suite for WordPress development.

## Set-up

1. Clone or fork this repository.

2. Put your plugin or theme code in the root of this folder and adjust the 
   `services/wordpress/volumes` section of `docker-compose.yml` so that it
   syncs to the appropriate directory.

3. Add `mywp.test` to `/etc/hosts` like:

   ```
   127.0.0.1 mywp.test
   ```

## Start environment

```sh
docker-compose up -d
```

The first time you run this, it will take a few minutes to pull in the required
images. On subsequent runs, it should take less than 30 seconds before you can
connect to WordPress in your browser. (Most of this time is waiting for MariaDB
to be ready to accept connections.)

The `-d` flag backgrounds the process and log output. To view logs for a
specific container, use `docker-compose logs [container]`, e.g.:

```sh
docker-compose logs wordpress
```

### WordPress site

Open `http://mywp.test/` in your browser and follow the famous five-second WordPress install.

### WordPress Admin Login
Admin Login: [http://mywp.test/wp-admin/](http://mywp.test/wp-admin/) <br>
Use admin/admin as user/password to login.

### Adminer - Database management
To access the Adminer visit: `http://mywp.test:8080` and use username as `root` and password as blank.

### Runt the below command to login into the docker container
If you want to access the docker container with SSH, you can easily connect to docker by using the below docker command.

```
docker exec -it mywp-wordpress-1 bash
```
