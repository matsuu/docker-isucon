FROM node:6.11

COPY . /home/isucon/isubata
WORKDIR /home/isucon/isubata/webapp/nodejs
RUN npm install

EXPOSE 5000

ENTRYPOINT ["node", "/home/isucon/isubata/webapp/nodejs"]
