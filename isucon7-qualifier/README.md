# docker-isucon/isucon7-qualifier

## Overview
ISUCON7予選のDockerfile

## Usage

### 事前準備

```
git clone --depth=1 https://github.com/matsuu/docker-isucon.git
cd docker-isucon/isucon7-qualifier
# 利用するwebappに応じて書き換える
${EDITOR} docker-compose.yml
```

### 起動

ベンチマーク以外のDockerを構築&起動する。そこそこ時間がかかる。
```
docker-compose up -d db
docker-compose up -d app
docker-compose up -d web
```

dbは起動時に流し込みがあるため時間がかかる。ログに「MySQL init process done. Ready for start up.」の文字列があればok。
```
docker-compose logs db | grep 'done'
```

動作確認
```
open http://127.0.0.1
```

### ベンチマーク

```
docker-compose up bench
```

### ログイン

```
docker-compose exec web bash
docker-compose exec app bash
docker-compose exec db bash
```

### チューニングの仕方

- [isucon/isucon7-qualify](https://github.com/isucon/isucon7-qualify/) をfork
- docker-compose.yml内の `GIT_URL` パラメータを自分のリポジトリに書き換える
- `docker-compose up -d --build app`

## References

- [isucon/isucon7-qualify](https://github.com/isucon/isucon7-qualify)
- [matsuu/vagrant-isucon](https://github.com/matsuu/vagrant-isucon)
- [matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)

## TODO

- 全言語の動作確認
- メモリ制限
- トラフィック制限
- 複数台構成
- k8s
- リファクタリング
