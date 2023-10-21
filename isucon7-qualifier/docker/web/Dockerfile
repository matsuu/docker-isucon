FROM nginx:1.10 AS runner

COPY . /home/isucon/isubata
COPY ./web/isucon.conf /etc/nginx/conf.d/isucon.conf

FROM nginx:1.25.2 AS bench

RUN apt update && apt upgrade && apt install -y wget

RUN wget https://github.com/tkuchiki/alp/releases/download/v1.0.20/alp_linux_amd64.tar.gz \
    && tar -xvzf ./alp_linux_amd64.tar.gz
COPY --from=runner /home/isucon/isubata /home/isucon/isubata
COPY --from=runner /etc/nginx/conf.d/isucon.conf /etc/nginx/conf.d/isucon.conf
COPY ./web/bench/log.conf /etc/nginx/conf.d/log.conf