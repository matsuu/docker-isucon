FROM node:18.18

WORKDIR /work
COPY package.json ./
RUN npm install
COPY . .

EXPOSE 5000
ENTRYPOINT ["node", "./index.js"]
