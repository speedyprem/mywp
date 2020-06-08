#!/usr/bin/env sh

# Install WordPress.
wp core install \
  --title="Just another WordPress project" \
  --admin_user="wordpress" \
  --admin_password="wordpress" \
  --admin_email="admin@mywp.test" \
  --url="http://mywp.test" \
  --skip-email

# Update permalink structure.
wp option update permalink_structure "/%postname%/" --skip-themes --skip-plugins
