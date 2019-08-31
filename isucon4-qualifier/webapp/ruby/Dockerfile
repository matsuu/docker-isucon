FROM matsuu/isucon4-qualifier-base:latest

WORKDIR /home/isucon/webapp/ruby
COPY ./Gemfile /home/isucon/webapp/ruby/Gemfile
COPY ./Gemfile.lock /home/isucon/webapp/ruby/Gemfile.lock

RUN \
  yum -y install gcc mysql-devel openssl-devel readline-devel zlib-devel && \
  sudo -u isucon /home/isucon/.xbuild/ruby-install 2.3.0 /home/isucon/.local/ruby && \
  sudo -u isucon /home/isucon/env.sh gem install --no-rdoc --no-ri foreman && \
  chown -R isucon /home/isucon/ && \
  chmod +w /home/isucon/webapp/ruby/Gemfile.lock && \
  sudo -u isucon /home/isucon/env.sh bundle install

EXPOSE 8080
CMD ["/home/isucon/env.sh", "foreman", "start"]
