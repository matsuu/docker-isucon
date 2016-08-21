FROM centos:6

MAINTAINER matsuu@gmail.com

RUN \
  yum -y update && \
  yum -y install gcc git libxml2-devel mysql rubygems sudo && \
  useradd -G wheel isucon && \
  git clone https://github.com/isucon/isucon4.git && \
  curl -L http://golang.org/dl/go1.3.linux-amd64.tar.gz | tar zxf - -C /usr/local && \
  rsync -a isucon4/qualifier/sql /home/isucon/ && \
  sed -e 's/127\.0\.0\.1/mysql/' isucon4/qualifier/init.sh > /home/isucon/init.sh && \
  chmod a+x /home/isucon/init.sh && \
  sed -e 's/localhost/mysql/' isucon4/qualifier/ami/files/env.sh > /home/isucon/env.sh && \
  chmod a+x /home/isucon/env.sh && \
  cp isucon4/qualifier/ami/files/bashrc /home/isucon/.bashrc && \
  chmod a+x /home/isucon/.bashrc && \
  cp isucon4/qualifier/ami/files/golang.sh /etc/profile.d/golang.sh && \
  /usr/bin/gem install --no-rdoc --no-ri gondler -v 0.2.0 && \
  rsync -aL --delete isucon4/qualifier/benchmarker /tmp/ && \
  chown -R isucon:isucon /tmp/benchmarker && \
  cp isucon4/qualifier/ami/files/bashrc /home/isucon/.bashrc && \
  chmod a+x /home/isucon/.bashrc && \
  sed -i -e 's/^GIT_COMMIT=.*/GIT_COMMIT=""/' /tmp/benchmarker/Makefile && \
  sed -i -e '/checkInstanceMetadata()/d' /tmp/benchmarker/main.go && \
  ( \
    cd /tmp/benchmarker && \
    sudo -u isucon env TERM=xterm /home/isucon/env.sh make release \
  ) && \
  mv /tmp/benchmarker/benchmarker /home/isucon/ && \
  rm -rf /tmp/benchmarker isucon4

CMD ["sudo", "-u", "isucon", "-i", "./benchmarker", "bench", "--host", "nginx"]
