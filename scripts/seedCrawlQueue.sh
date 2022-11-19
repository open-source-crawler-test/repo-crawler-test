#!/usr/bin/bash

source ./scripts/validateRedisCreds.sh
source ./scripts/validateRepoUrlInput.sh

# { INPUT -> repository string, Redis credentials }
# { OUTPUT -> _ }
# Add the repository to crawlQueue
function seedCrawlQueue {
    REPOSITORY=$1
    CRAWL_QUEUE_KEY='dev-crawl-queue'

    validateRedisCreds $REDIS_HOST $REDIS_PORT $REDIS_USER $REDIS_PASS
    validateRepoUrlInput $REPOSITORY

    redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS RPUSH $CRAWL_QUEUE_KEY $REPOSITORY
}

seedCrawlQueue $1