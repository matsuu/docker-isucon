# dockerfile for ISUCON4 qualifier

ISUCON4予選のDockerfile

## Usage

### 事前準備
```
git clone https://github.com/matsuu/docker-isucon.git
cd docker-isucon/isucon4-qualifier
# go
cp docker-compose-go.yml docker-compose.yml
# node
cp docker-compose-node.yml docker-compose.yml
# perl
cp docker-compose-perl.yml docker-compose.yml
# php
cp docker-compose-php.yml docker-compose.yml
# python
cp docker-compose-python.yml docker-compose.yml
# ruby
cp docker-compose-ruby.yml docker-compose.yml
```

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
