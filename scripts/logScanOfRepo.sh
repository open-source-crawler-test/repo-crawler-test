#!/usr/bin/bash

source ./scripts/validateRedisCreds.sh
source ./scripts/validateRepoUrlInput.sh

# { INPUT -> repository string, Redis credentials }
# { OUTPUT -> _ }
# Should mark the repository crawled and remove from all queues
function logScanOfRepo {
    REPOSITORY=$1

    validateRedisCreds $REDIS_HOST $REDIS_PORT $REDIS_USER $REDIS_PASS
    validateRepoUrlInput $REPOSITORY

    redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS HSET $REPOSITORY hasBeenCrawled "true" hasBeenScanned "true"
}

logScanOfRepo $1