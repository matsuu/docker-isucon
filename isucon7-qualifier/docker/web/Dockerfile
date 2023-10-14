FROM alpine AS build-dev

COPY . /isubata

FROM nginx:1.10

COPY --from=build-dev /isubata /home/isucon/isubata
#COPY --from=build-dev /isubata/files/app/nginx.conf /etc/nginx/conf.d/isucon.conf
COPY --from=build-dev /isubata/web/isucon.conf /etc/nginx/conf.d/isucon.conf
