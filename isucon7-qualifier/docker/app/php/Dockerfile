FROM php:7.1.9

ARG GIT_URL=https://github.com/isucon/isucon7-qualify.git

RUN \
  apt-get update && \
  apt-get install -y git && \
  git clone $GIT_URL /home/isucon/isubata && \
  cp /home/isucon/isubata/files/app/php.ini /etc/ && \
  cp /home/isucon/isubata/files/app/isubata.php-fpm.conf /etc/ && \
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
  php composer-setup.php --install-dir=/usr/bin --filename=composer && \
  php -r "unlink('composer-setup.php');"
WORKDIR /home/isucon/isubata/webapp/php
RUN composer install

EXPOSE 5000

ENTRYPOINT ["php-fpm", "-c", "/etc/isubata.php-fpm.conf"]
