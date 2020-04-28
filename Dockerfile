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
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer
