# docker-isucon/isucon4-qualifier

## Overview
ISUCON4予選のDockerfile

## Usage(Standalone)

### 起動

```
docker run -d --name standalone -p 80:80 matsuu/isucon4-qualifier-standalone:latest
```

### ベンチマーク

```
docker exec standalone /home/isucon/benchmarker bench
```

### ログイン

```
docker exec standalone bash
```

## Usage(Microservice)

### 事前準備

```
# go
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-go.yml
# node
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-node.yml
# perl
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-perl.yml
# php
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-php.yml
# python
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-python.yml
# ruby
curl -o docker-compose.yml -L https://github.com/matsuu/docker-isucon/raw/master/isucon4-qualifier/docker-compose-ruby.yml
```

### 起動

```
docker-compose up -d nginx
```

### ベンチマーク

```
docker-compose up bench
```

### ログイン

```
docker-compose exec nginx bash
docker-compose exec webapp bash
docker-compose exec mysql bash
```

## References

- [ISUCON4(2014) オンライン予選レギュレーション](http://isucon.net/archives/39979344.html)
- [ISUCON4 予選当日マニュアル](https://gist.github.com/mirakui/e394ed543415852d34a6)
- [isucon/isucon4](https://github.com/isucon/isucon4)
- [matsuu/vagrant-isucon](https://github.com/matsuu/vagrant-isucon)
- [matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)

## TODO

- 全言語の動作確認
- メモリ制限
- リファクタリング
