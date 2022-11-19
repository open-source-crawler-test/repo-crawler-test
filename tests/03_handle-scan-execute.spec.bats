#!/usr/bin/env bats

# should be in analyze queue
# should analyze
  # updating keys/values
  # queue is empty now

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

@test "should log the crawl and remove from scan-queue" {
  scanQueueLength="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS llen scan-queue)"
  [ "$scanQueueLength" -eq 0 ]

  # Arrange
  source seedCrawlQueue.sh $REPOSITORY
  source fetchNextInCrawlQueue.sh
  source logCrawlOfRepo.sh $REPOSITORY

  # Act
  source fetchNextInScanQueue.sh
  source logScanOfRepo.sh $REPOSITORY

  # Assert
  scanQueueLength="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS llen scan-queue)"
  [ "$scanQueueLength" -eq 0 ]
}

@test "should update status for repository and remove from all queues" {
  repositoryCrawledKeyStatus="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS HGET $REPOSITORY hasBeenCrawled )"
  [ "$repositoryCrawledKeyStatus" = "true" ]

  repositoryScannedKeyStatus="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS HGET $REPOSITORY hasBeenScanned )"
  [ "$repositoryScannedKeyStatus" = "true" ]

  scanQueueLength="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS llen scan-queue)"
  [ "$scanQueueLength" -eq 0 ]
}