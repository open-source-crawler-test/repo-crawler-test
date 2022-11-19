#!/usr/bin/bash

source ./scripts/validateRedisCreds.sh

# { INPUT -> Redis credentials }
# { OUTPUT -> repository string }
# Fetch the next repository in scanQueue
function fetchNextInScanQueue {
    SCAN_QUEUE_KEY='dev-scan-queue'

    validateRedisCreds $REDIS_HOST $REDIS_PORT $REDIS_USER $REDIS_PASS

    nextRepository=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS LPOP $SCAN_QUEUE_KEY)
    echo $nextRepository
}

result=$(fetchNextInScanQueue $1)
echo $result