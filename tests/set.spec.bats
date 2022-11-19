#!/usr/bin/env bats

@test "should retrieve key already stored in redis" {
  result="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS get cat-count)"
  [ "$result" -eq 10 ]
}

@test "2 should retrieve key already stored in redis" {
  result="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS get cat-count)"
  [ "$result" -eq 99 ]
}


# should be in analyze queue
# should analyze
  # updating keys/values
  # queue is empty now


@test "Tests whether an exception is thrown when computing the total nr of lines, if the file is not found." {
    #ACTUAL_RESULT=$(<$TOTAL_NR_OF_LINES_IN_TARGET_FILEPATH)
    #EXPECTED_OUTPUT="1"

    # this will report an error if it has a non-zero return status
    run_main_functions "custom_install_4_energizedprotection" "test/testfiles/nonexistant_filename.txt"

    #assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}
