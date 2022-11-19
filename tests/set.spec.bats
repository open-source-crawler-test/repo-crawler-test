#!/usr/bin/env bats

redis-cli -u redis://$1:$2/1

@test "should retrieve key already stored in redis" {
  result="$(redis-cli get cat-count)"
  [ "$result" -eq 10 ]
}