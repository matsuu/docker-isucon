FROM matsuu/isucon4-qualifier-base:latest

MAINTAINER matsuu@gmail.com

WORKDIR /home/isucon/webapp/node
RUN \
  sudo -u isucon /home/isucon/.xbuild/node-install v0.10.31 /home/isucon/.local/node && \
  sudo -u isucon /home/isucon/env.sh npm install

EXPOSE 8080
CMD ["/home/isucon/env.sh", "node", "app.js"]
