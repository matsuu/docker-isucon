docker compose exec db sh -c "perl /tmp/mysqldumpslow.sh -s t /tmp/slow.log | head -30"