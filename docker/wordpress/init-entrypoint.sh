#!/usr/bin/env bash

echo "Waiting for database to be available"
wait-for-it $DB_HOST:$DB_PORT -t 180

echo "Waiting for WP to be installed"
while [ ! -f /var/www/html/wp-config.php ]; do sleep 1; done

echo "Installing Wordpress site"
wp core install --url="mywp.test" --title="MyWP WordPress site" --admin_user="admin" --admin_password="admin" --admin_email="admin@mywp.test" --skip-email --allow-root

SUPERUSERNAME=${SUPERUSERNAME:-'admin'}
SUPERPASSWORD=${SUPERPASSWORD:-'admin'}
echo "Creating user: $SUPERUSERNAME with pass: $SUPERPASSWORD"
wp user create $SUPERUSERNAME superadmin@mywp.test --role=administrator --user_pass=$SUPERPASSWORD --allow-root
wp super-admin add $SUPERUSERNAME --allow-root

pushd wp-content
chown -R ${UID:-'1000'}:${GID:-'1000'} .
chmod -R 777 uploads
popd