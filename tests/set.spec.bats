#!/usr/bin/env bats

@test "should retrieve key already stored in redis" {
  result="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS get cat-count)"
  [ "$result" -eq 10 ]
}

@test "2 should retrieve key already stored in redis" {
  result="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS get cat-count)"
  [ "$result" -eq 99 ]
}

# seed a url
# fetch from crawl queue
# mark as "crawled" (shouldto)
  # should update key/value pair
  # should empty crawl queue
# 