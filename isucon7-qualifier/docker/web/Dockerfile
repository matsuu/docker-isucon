FROM nginx:1.25.2 AS base
FROM base as runner

COPY . /home/isucon/isubata
COPY ./web/isucon.conf /etc/nginx/conf.d/isucon.conf

FROM runner AS analyze

RUN apt-get update && apt-get upgrade -y && apt install -y wget

RUN wget https://github.com/tkuchiki/alp/releases/download/v1.0.20/alp_linux_amd64.tar.gz \
    && tar -xvzf ./alp_linux_amd64.tar.gz
COPY ./web/bench/log.conf /etc/nginx/conf.d/log.conf