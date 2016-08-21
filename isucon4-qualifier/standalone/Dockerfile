FROM centos:6

MAINTAINER matsuu@gmail.com

RUN \
  yum update -y && \
  yum -y install epel-release http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm http://nginx.org/packages/old/centos/6/x86_64/nginx-1.6.1-1.el6.ngx.x86_64.rpm && \
  yum -y install python-meld3 rubygems git gcc patch openssl-devel mysql-community-devel mysql-community-server libcurl libcurl-devel bison bison-devel libjpeg-turbo libjpeg-turbo-devel libpng libpng-devel libmcrypt libmcrypt-devel readline readline-devel libtidy libtidy-devel autoconf automake libxml2-devel libxslt-devel nginx MySQL-python python-setuptools mercurial bzr sudo && \
  useradd -G wheel isucon && \
  echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  ( \
      cd /tmp && \
      git clone https://github.com/isucon/isucon4.git && \
      cp /tmp/isucon4/qualifier/ami/files/nginx.conf /etc/nginx/nginx.conf && \
      cp /tmp/isucon4/qualifier/ami/files/nginx.php.conf /etc/nginx/nginx.php.conf && \
      cp /tmp/isucon4/qualifier/ami/files/my.cnf /etc/my.cnf \
  ) && \
  mkdir /tmp/isucon && \
  rsync -a /tmp/isucon4/qualifier/sql /tmp/isucon/ && \
  rsync -a /tmp/isucon4/qualifier/webapp /tmp/isucon/ && \
  cp /tmp/isucon4/qualifier/init.sh /tmp/isucon/init.sh && \
  chmod a+x /tmp/isucon/init.sh && \
  cp /tmp/isucon4/qualifier/ami/files/env.sh /tmp/isucon/env.sh && \
  chmod a+x /tmp/isucon/env.sh && \
  cp /tmp/isucon4/qualifier/ami/files/bashrc /home/isucon/.bashrc && \
  chmod a+x /home/isucon/.bashrc && \
  chown -R isucon:isucon /tmp/isucon && \
  rsync -avz --delete --exclude-from=/tmp/isucon4/qualifier/ami/files/rsync_exclude.txt /tmp/isucon/ /home/isucon/ && \
  service mysqld start && \
  sudo -u isucon -i ./init.sh && \
  echo "GRANT ALL ON *.* TO isucon@localhost IDENTIFIED BY 'isucon'" | mysql && \
  service mysqld stop && \
  easy_install supervisor && \
  cp /tmp/isucon4/qualifier/ami/files/supervisord.init /etc/init.d/supervisord && \
  chmod a+x /etc/init.d/supervisord && \
  sudo -u isucon -i git clone https://github.com/tagomoris/xbuild.git /home/isucon/.xbuild && \
  sudo -u isucon -i /home/isucon/.xbuild/ruby-install 2.1.3 /home/isucon/.local/ruby && \
  sudo -u isucon -i /home/isucon/env.sh gem install --no-rdoc --no-ri foreman && \
  ( cd /home/isucon/webapp/ruby && sudo -u isucon /home/isucon/env.sh bundle install ) && \
  sudo -u isucon -i /home/isucon/.xbuild/node-install v0.10.31 /home/isucon/.local/node && \
  ( cd /home/isucon/webapp/node && sudo -u isucon /home/isucon/env.sh npm install ) && \
  sudo -u isucon -i /home/isucon/.xbuild/python-install 2.7.8 /home/isucon/.local/python && \
  sudo -u isucon -i /home/isucon/env.sh pip install gunicorn Flask MySQL-python && \
  sudo -u isucon -i /home/isucon/.xbuild/perl-install 5.20.0 /home/isucon/.local/perl && \
  ( cd /home/isucon/webapp/perl && sudo -u isucon /home/isucon/env.sh carton install ) && \
  sudo -u isucon -i /home/isucon/.xbuild/php-install 5.6.0 /home/isucon/.local/php && \
  sudo -u isucon -i cp /tmp/isucon4/qualifier/ami/files/php.ini /home/isucon/.local/php/etc/php.ini && \
  sudo -u isucon -i chown isucon:isucon /home/isucon/.local/php/etc/php.ini && \
  curl -L http://golang.org/dl/go1.3.linux-amd64.tar.gz | tar zxf - -C /usr/local && \
  cp /tmp/isucon4/qualifier/ami/files/golang.sh /etc/profile.d/golang.sh && \
  /usr/bin/gem install --no-rdoc --no-ri gondler -v 0.2.0 && \
  ( cd /home/isucon/webapp/go && sudo -u isucon /home/isucon/env.sh ./build.sh ) && \
  chown -R isucon:isucon /home/isucon/gocode && \
  rsync -aL --delete /tmp/isucon4/qualifier/benchmarker /tmp/ && \
  chown -R isucon:isucon /tmp/benchmarker && \
  sed -i -e 's/^GIT_COMMIT=.*/GIT_COMMIT=""/' /tmp/benchmarker/Makefile && \
  sed -i -e '/checkInstanceMetadata()/d' /tmp/benchmarker/main.go && \
  ( cd /tmp/benchmarker && sudo -u isucon env TERM=xterm /home/isucon/env.sh make release ) && \
  mv /tmp/benchmarker/benchmarker /home/isucon/ && \
  rm -rf /tmp/benchmarker /tmp/isucon /tmp/isucon4 /var/log/nginx/*.log /var/log/mysqld.log /home/isucon/sql/*.old /home/isucon/sql/*.rb /home/isucon/php/nginx.local.conf /home/isucon/php/Procfile && \
  find /home/isucon/webapp -maxdepth 2 -name 'README.*' -delete && \
  yum clean all

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord", "--nodaemon"]
