#!/usr/bin/bash

source ./scripts/validateRedisCreds.sh

# { INPUT -> Redis credentials }
# { OUTPUT -> repository string }
# Fetch the next repository in crawlQueue
function fetchNextInCrawlQueue {
    CRAWL_QUEUE_KEY='dev-crawl-queue'

    validateRedisCreds $REDIS_HOST $REDIS_PORT $REDIS_USER $REDIS_PASS

    nextRepository=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS LPOP $CRAWL_QUEUE_KEY)
    echo $nextRepository
}

result=$(fetchNextInCrawlQueue $1)
echo $result