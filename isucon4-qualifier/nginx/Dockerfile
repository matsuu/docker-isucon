#FROM centos:6
FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf

RUN apt-get update && apt-get install -y wget unzip vim && \
  wget https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip && \
  unzip alp_linux_amd64.zip && \
  mv alp /usr/local/bin/
