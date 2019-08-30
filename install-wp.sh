#!/usr/bin/env sh

set -ex

echo "Done! You are ready to run \`docker-compose up -d\`."

docker-compose up -d

apt-get update
apt-get install git

# Install Node.
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get install -y nodejs
apt-get install npm

# Install Node.
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get install -y nodejs
apt-get install npm

# Install Composer
sudo curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install WP-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp --info


# Install WordPress.
wp core multisite-install --title="TheSun" --admin_user="wordpress" --admin_password="wordpress" --admin_email="admin@admin.lc" --skip-email --allow-root
# Update permalink structure.
wp option update permalink_structure "/%year%/%monthnum%/%day%/%postname%/" --skip-themes --skip-plugins --allow-root
