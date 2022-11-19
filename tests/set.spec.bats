#!/usr/bin/env bats

# should be in analyze queue
# should analyze
  # updating keys/values
  # queue is empty now


@test "should fail" {
    run bash -c "source ./scripts/failure.sh"
    assert_failure 
    assert_output --partial "ERROR, did not find the GitLab server running within 4 seconds!"
}
