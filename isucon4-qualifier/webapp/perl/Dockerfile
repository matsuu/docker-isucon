FROM matsuu/isucon4-qualifier-base:latest

MAINTAINER matsuu@gmail.com

WORKDIR /home/isucon/webapp/perl
RUN \
  yum -y install gcc mysql-devel patch && \
  sudo -u isucon /home/isucon/.xbuild/perl-install 5.20.0 /home/isucon/.local/perl && \
  sudo -u isucon /home/isucon/env.sh carton install

EXPOSE 8080
CMD ["/home/isucon/env.sh", "carton", "exec", "plackup", "-s", "Starman", "--listen", ":8080", "-E", "prod", "app.psgi"]
