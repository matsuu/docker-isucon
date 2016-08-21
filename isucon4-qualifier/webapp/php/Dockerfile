FROM matsuu/isucon4-qualifier-base:latest

MAINTAINER matsuu@gmail.com

WORKDIR /home/isucon/webapp/php
RUN \
  yum -y install epel-release && \
  yum -y install bison gcc libcurl-devel libjpeg-devel libmcrypt-devel libpng-devel libtidy-devel libxml2-devel libxslt-devel openssl-devel re2c readline-devel && \
  sudo -u isucon -i /home/isucon/.xbuild/php-install 5.6.0 /home/isucon/.local/php

CMD ["/home/isucon/env.sh", "php-fpm", "-y", "/home/isucon/webapp/php/php-fpm.conf"]
