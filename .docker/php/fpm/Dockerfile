FROM php:8.3.11-fpm

# https://stackoverflow.com/q/57048428/4223982
RUN apt update && apt -y upgrade && apt -y install mariadb-client unzip

# install-php-extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && install-php-extensions gd mcrypt pdo_mysql xdebug zip
# /install-php-extensions

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --quiet

RUN groupadd --gid 1000 dockerGroup
RUN useradd --uid 1000 --gid dockerGroup --shell /bin/bash --create-home dockerUser

USER dockerUser
