FROM centos:6

MAINTAINER matsuu@gmail.com

# 時間がかかるyum updateおよびgolangのダウンロードおよび展開をキャッシュ化
RUN \
  yum -y update && \
  yum -y install git mysql sudo && \
  useradd -G wheel isucon && \
  echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  curl -L http://golang.org/dl/go1.10.3.linux-amd64.tar.gz | tar zxf - -C /usr/local

# goの依存関係の一部を先に打ち込む
COPY prebuild.sh .
RUN \
  chmod a+x prebuild.sh \
  ./prebuild.sh

# ブランチの更新を見て以下を再ビルドします
ADD "https://api.github.com/repos/mattsu6/isucon4/git/refs/heads/master" version.json
RUN  \
  git clone -b mattsu https://github.com/mattsu6/isucon4.git && \
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

WORKDIR /home/isucon/webapp/go
RUN /home/isucon/env.sh ./build.sh 

EXPOSE 8080
CMD ["/home/isucon/env.sh", "./golang-webapp"]
