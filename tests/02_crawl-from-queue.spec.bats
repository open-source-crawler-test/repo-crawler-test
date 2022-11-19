#!/usr/bin/env bats

# fetch from crawl queue
# mark as "crawled" (shouldto)
  # should update key/value pair
  # should empty crawl queue
  
@test "should retrieve url added to crawl queue" {
  result="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS get cat-count)"
  [ "$result" -eq "spencerbot@seeded-repo" ]
}