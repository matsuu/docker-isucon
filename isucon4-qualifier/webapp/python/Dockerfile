FROM matsuu/isucon4-qualifier-base:latest

MAINTAINER matsuu@gmail.com

WORKDIR /home/isucon/webapp/python
RUN \
  yum -y install bzip2-devel gcc mysql-devel openssl-devel patch readline-devel sqlite-devel zlib-devel && \
  sudo -u isucon /home/isucon/.xbuild/python-install 2.7.8 /home/isucon/.local/python && \
  sudo -u isucon /home/isucon/env.sh pip install gunicorn Flask MySQL-python

EXPOSE 8080
CMD ["/home/isucon/env.sh", "gunicorn", "-c", "gunicorn_config.py", "app:app"]
