#!/usr/bin/env bats

setup() {
    REDIS_HOST='127.0.0.1'
    REDIS_PORT='6379'
    REDIS_USER='default'
    REDIS_PASS='testPass' 
    REPOSITORY='spencerbot/seeded-repo'
    CRAWL_QUEUE_KEY='dev-crawl-queue'
    SCAN_QUEUE_KEY='dev-scan-queue'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    chmod -R +rwx scripts
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../scripts:$PATH"
}

@test "should log the crawl and remove from crawl-queue" {
  scanQueueLength="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS llen $SCAN_QUEUE_KEY)"
  [ "$scanQueueLength" -eq 0 ]

  # Arrange
  source seedCrawlQueue.sh $REPOSITORY
  source fetchNextInCrawlQueue.sh

  # Act
  source logCrawlOfRepo.sh $REPOSITORY
  
  # Assert
  queueLength="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS llen $CRAWL_QUEUE_KEY)"
  [ "$queueLength" -eq 0 ]
}

@test "should update status for repository and add to scan queue" {
  repositoryCrawledKeyStatus="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS HGET $REPOSITORY 'hasBeenCrawled' )"
  [ "$repositoryCrawledKeyStatus" = "true" ]

  repositoryCrawledKeyStatus="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS HGET $REPOSITORY 'hasBeenScanned' )"
  echo $repositoryScannedKeyStatus
  [ "$repositoryScannedKeyStatus" != "true" ]

  scanQueueLength="$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS llen $SCAN_QUEUE_KEY)"
  [ "$scanQueueLength" -eq 1 ]

  # Cleanup
  redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS LPOP $SCAN_QUEUE_KEY
}