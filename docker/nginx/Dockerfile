FROM nginx:latest

VOLUME /var/www/html
VOLUME /var/www/html/wp-content

# SSL Files
COPY nginx-selfsigned.conf /etc/nginx/snippets/self-signed.conf
COPY nginx-ssl-params.conf /etc/nginx/snippets/ssl-params.conf
COPY dhparam.pem /etc/ssl/certs/dhparam.pem
COPY crt.pem /etc/ssl/certs/nginx-selfsigned.crt
COPY key.pem /etc/ssl/private/nginx-selfsigned.key

# Server Blocks
RUN rm /etc/nginx/conf.d/default.conf
COPY conf.d /etc/nginx/conf.d
