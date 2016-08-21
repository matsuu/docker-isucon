FROM mysql:5.5

MAINTAINER matsuu@gmail.com

COPY sql/ /docker-entrypoint-initdb.d/
COPY conf.d/ /etc/mysql/conf.d/
