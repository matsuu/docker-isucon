FROM centos:6

MAINTAINER matsuu@gmail.com

RUN \
  yum -y update && \
  yum -y install git mysql sudo && \
  useradd -G wheel isucon && \
  echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  git clone https://github.com/isucon/isucon4.git && \
  mkdir /tmp/isucon && \
  rsync -a isucon4/qualifier/sql /tmp/isucon/ && \
  rsync -a isucon4/qualifier/webapp /tmp/isucon/ && \
  sed -e 's/127\.0\.0\.1/mysql/' isucon4/qualifier/init.sh > /tmp/isucon/init.sh && \
  chmod a+x /tmp/isucon/init.sh && \
  sed -e 's/localhost/mysql/' isucon4/qualifier/ami/files/env.sh > /tmp/isucon/env.sh && \
  chmod a+x /tmp/isucon/env.sh && \
  cp isucon4/qualifier/ami/files/bashrc /home/isucon/.bashrc && \
  chmod a+x /home/isucon/.bashrc && \
  mkdir -p /tmp/isucon/.local/php/etc && \
  cp isucon4/qualifier/ami/files/php.ini /tmp/isucon/.local/php/etc/php.ini && \
  chown -R isucon:isucon /tmp/isucon && \
  rsync -avz --delete --exclude-from=isucon4/qualifier/ami/files/rsync_exclude.txt /tmp/isucon/ /home/isucon/ && \
  sudo -u isucon git clone https://github.com/tagomoris/xbuild.git /home/isucon/.xbuild && \
  cp isucon4/qualifier/ami/files/golang.sh /etc/profile.d/golang.sh && \
  rm -rf isucon4 /tmp/isucon
