FROM php:7.2-apache

COPY ./ /var/www
COPY ./vhost.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www

RUN apt-get -y update && apt-get install -y git libicu-dev zlib1g-dev libzip-dev unzip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install mbstring pdo pdo_mysql intl zip \
    && chown -R www-data:www-data /var/www

RUN a2enmod vhost_alias \
    && a2enmod rewrite

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer
