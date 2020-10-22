FROM wordpress:php7.3-fpm

COPY php.ini /usr/local/etc/php
COPY php.conf /usr/local/etc/php-fpm.d/www.conf
RUN rm /usr/local/etc/php-fpm.d/zz-docker.conf

RUN apt-get update && apt-get install -y \
        nano \
        libz-dev \ 
        libmemcached-dev \
        wget \ 
        zip \
        nano

RUN pecl channel-update pecl.php.net	
RUN pecl install memcache memcached

RUN docker-php-ext-enable memcache memcached

RUN addgroup --gid 2000 --system wordpress
RUN adduser --uid 2000 --system --disabled-login --disabled-password --gid 2000 wordpress

RUN wget https://downloads.wordpress.org/plugin/insert-php-code-snippet.1.3.1.zip && unzip insert-php-code-snippet.1.3.1.zip && mv insert-php-code-snippet /var/www/html/wp-content/plugins/
