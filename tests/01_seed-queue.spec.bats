#!/usr/bin/env bats

setup() {
    REDIS_HOST='127.0.0.1'
    REDIS_PORT='6379'
    REDIS_USER='default'
    REDIS_PASS='testPass'
    REPOSITORY='spencerbot/seeded-repo'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    chmod -R +rwx scripts
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../scripts:$PATH"
}

@test "should have added repository to crawl-queue" {
  source seedCrawlQueue.sh $REPOSITORY

  nextInQueue="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS LPOP crawl-queue)"
  [ "$nextInQueue" = $REPOSITORY ]

  queueLength="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS llen crawl-queue)"
  [ "$queueLength" -eq 0 ]
}