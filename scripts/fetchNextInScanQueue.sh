#!/usr/bin/bash

source ./scripts/validateRedisCreds.sh

# { INPUT -> Redis credentials }
# { OUTPUT -> repository string }
# Fetch the next repository in scanQueue
function fetchNextInScanQueue {
    validateRedisCreds $REDIS_HOST $REDIS_PORT $REDIS_USER $REDIS_PASS

    nextRepository=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS LPOP scan-queue)
    echo $nextRepository
}

result=$(fetchNextInScanQueue $1)
echo $result