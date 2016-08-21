# dockerfile for ISUCON4 qualifier

ISUCON4予選のDockerfile

## Usage(スタンドアロン版)

### サーバ構築

```
docker run -d -n standalone -p 80:80 matsuu/isucon4-qualifiy-standalone:latest
```

### 各サーバへログイン

```
docker exec standalone bash
```

### ベンチマーク
```
/home/isucon/benchmarker --host 127.0.0.1
```

## Usage(Docker分離版)

### 事前準備

```
# go
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-go.yml
# node
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-go.yml
# perl
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-go.yml
# php
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-go.yml
# python
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-go.yml
# ruby
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-go.yml

### サーバ構築

```
docker-compose up -d nginx
```

### ベンチマーク

```
docker-compose up bench
```

### 各サーバへログイン

```
docker-compose exec nginx bash
docker-compose exec webapp bash
docker-compose exec mysql bash
```
