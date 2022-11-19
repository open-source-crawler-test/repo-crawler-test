#!/usr/bin/bash

source ./scripts/validateRedisCreds.sh
source ./scripts/validateRepoUrlInput.sh

# { INPUT -> repository string, Redis credentials }
# { OUTPUT -> _ }
# Should mark the repository crawled and add to scan queue
function logCrawlOfRepo {
    REPOSITORY=$1
    SCAN_QUEUE_KEY='dev-scan-queue'

    validateRedisCreds $REDIS_HOST $REDIS_PORT $REDIS_USER $REDIS_PASS
    validateRepoUrlInput $REPOSITORY

    redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS HSET $REPOSITORY hasBeenCrawled "true" hasBeenScanned "false"

    redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS RPUSH $SCAN_QUEUE_KEY $REPOSITORY
}

logCrawlOfRepo $1