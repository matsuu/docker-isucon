FROM matsuu/isucon4-qualifier-base:latest

MAINTAINER matsuu@gmail.com

WORKDIR /home/isucon/webapp/ruby
RUN \
  yum -y install gcc mysql-devel openssl-devel readline-devel zlib-devel && \
  sudo -u isucon /home/isucon/.xbuild/ruby-install 2.1.3 /home/isucon/.local/ruby && \
  sudo -u isucon /home/isucon/env.sh gem install --no-rdoc --no-ri foreman && \
  sudo -u isucon /home/isucon/env.sh bundle install

EXPOSE 8080
CMD ["/home/isucon/env.sh", "foreman", "start"]
