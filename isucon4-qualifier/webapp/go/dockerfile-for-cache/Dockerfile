FROM centos:6

# 本dockerfileはtosukui/docker-isucon4-webapp-go-cacheにあります

MAINTAINER am.businessmail.exp@gmail.com

# 時間がかかるyum updateおよびgolangのダウンロードおよび展開をキャッシュ化
RUN \
  yum -y update && \
  yum -y install git mysql sudo && \
  useradd -G wheel isucon && \
  echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  curl -L http://golang.org/dl/go1.10.3.linux-amd64.tar.gz | tar zxf - -C /usr/local