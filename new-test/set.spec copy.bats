#!/usr/bin/env bats

: '
@test "should retrieve key already stored in redis" {
  result="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS get cat-count)"
  [ "$result" -eq 10 ]
}

@test "2 should retrieve key already stored in redis" {
  result="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS get cat-count)"
  [ "$result" -eq 99 ]
}
'


# should be in analyze queue
# should analyze
  # updating keys/values
  # queue is empty now


@test "should fail" {
    run bash -c "source scripts/failure.sh"
    assert_failure 
    assert_output --partial "ERROR, did not find the GitLab server running within 4 seconds!"
}
