FROM wordpress:6.8-php8.2-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev \
    zlib1g-dev \
    git-core \
    unzip \
    libgraphicsmagick1-dev \
    mariadb-client \
    gnupg2

RUN pecl uninstall imagick
RUN rm /usr/local/etc/php/conf.d/docker-php-ext-imagick.ini

RUN pecl install gmagick-beta && \
    pecl install xdebug

RUN docker-php-ext-enable gmagick && \
    docker-php-ext-enable xdebug

COPY docker/wordpress/php.ini-development /usr/local/etc/php/php.ini
COPY docker/wordpress/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY --chown=www-data:www-data docker/wait-for-it.sh /usr/local/bin/wait-for-it
COPY --chown=www-data:www-data docker/wordpress/init-entrypoint.sh /usr/local/bin/

# Install Composer
RUN curl -s https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN mkdir /var/cache/composer
VOLUME /var/cache/composer
RUN chown -R www-data:www-data /var/cache/composer

# WP CLI Setup
ENV WORDPRESS_CLI_GPG_KEY 63AF7AA15067C05616FDDD88A3A2E8F226F0BC06
ENV WORDPRESS_CLI_VERSION 2.5.0
ENV WORDPRESS_CLI_SHA512 08dd9035fda1d529807380d5b757839e2809e289eb1a698fe33e7e21a1431d3f77c551c2b2db5adc55083d5075ea4137407994111890f765e790a97e6d9ca7af

RUN set -ex; \
	curl -o /usr/local/bin/wp.gpg -fSL "https://github.com/wp-cli/wp-cli/releases/download/v${WORDPRESS_CLI_VERSION}/wp-cli-${WORDPRESS_CLI_VERSION}.phar.gpg"; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$WORDPRESS_CLI_GPG_KEY"; \
	gpg --batch --decrypt --output /usr/local/bin/wp /usr/local/bin/wp.gpg; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/wp.gpg; \
	\
	echo "$WORDPRESS_CLI_SHA512 */usr/local/bin/wp" | sha512sum -c -; \
	chmod +x /usr/local/bin/wp; \
	\
	wp --allow-root --version

RUN chmod -R 777 /var/www/html

VOLUME /var/www/html
VOLUME /var/www/html/wp-content

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html/wp-content
