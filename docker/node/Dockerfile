FROM node:10

COPY entrypoint.sh /usr/bin/entrypoint

VOLUME /var/www/html/wp-content
WORKDIR /var/www/html/wp-content

ENTRYPOINT ["entrypoint"]