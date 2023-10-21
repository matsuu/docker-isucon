FROM golang:1.9 AS build-dev

COPY . /home/isucon/isubata

RUN \
  cd /home/isucon/isubata/bench && \
  go get github.com/constabulary/gb/... && \
  gb vendor restore && \
  make && \
  bin/gen-initial-dataset

FROM mysql:5.7 AS runner

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes MYSQL_DATABASE=isubata MYSQL_USER=isucon MYSQL_PASSWORD=isucon

COPY --from=build-dev /home/isucon/isubata/db/isubata.sql /docker-entrypoint-initdb.d/01_isubata.sql
COPY --from=build-dev /home/isucon/isubata/bench/isucon7q-initial-dataset.sql.gz /docker-entrypoint-initdb.d/isucon7q-initial-dataset.sql.gz 

CMD ["--character-set-server=utf8mb4"]

FROM runner AS analyze

COPY db/analyze.cnf /etc/mysql/conf.d/

RUN \
  yum install -y perl && \
  cd /tmp && \
  curl -O https://raw.githubusercontent.com/mysql/mysql-server/mysql-5.7.43/scripts/mysqldumpslow.sh && \
  sed -i -e '1d' /tmp/mysqldumpslow.sh
