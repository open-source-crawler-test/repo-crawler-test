#!/usr/bin/bash

source ./scripts/validateRedisCreds.sh
source ./scripts/validateRepoUrlInput.sh

# { INPUT -> Redis credentials, repository string}
# Fetch HTML page for repository and parse README
function executeRepositoryWebCrawl {
    REPOSITORY=$1
    CRAWL_QUEUE_KEY='dev-crawl-queue'
    url="https://github.com/$REPOSITORY"

    # validateRedisCreds $REDIS_HOST $REDIS_PORT $REDIS_USER $REDIS_PASS
    validateRepoUrlInput $REPOSITORY

    # Validate the URL has not been crawled already
    hasBeenCrawled=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS HGET $REPOSITORY hasBeenCrawled)
    if [ "$hasBeenCrawled" == "true" ]
    then
        echo "[SKIPPING] Web crawler has already visited: ($url)"
        exit 0
    fi

    # Parse all the URLs found in the README
    curl -s $REPOSITORY | grep -ioE "github.com[/][a-zA-Z0-9\-]+[/][a-zA-Z0-9\-]+" >> parsedURLs.txt

    # Filter out unique values
    sort -fu parsedURLs.txt >> parsedUniqueURLs.txt

    # Add each URL found to redis crawl queue
    while IFS="" read -r p || [ -n "$p" ]
    do
        # printf '%s\n' "$p"
        PARSED_REPOSITORY=${p#*github.com/}
        echo "Adding [$PARSED_REPOSITORY] to crawl queue"
        echo "redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS RPUSH $CRAWL_QUEUE_KEY $PARSED_REPOSITORY" >> redisBatchQueueCommands.txt
    done < parsedUniqueURLs.txt

    # Execute batch redis queue push
    cat redisBatchQueueCommands.txt | redis-cli --pipe

    echo "Finished Crawling: $url"

    # File cleanup
    rm parsedUniqueURLs.txt
    rm parsedURLs.txt
    rm redisBatchQueueCommands.txt
}

executeRepositoryWebCrawl $1

# Download the index page
# Attempt to fetch repository web page
# repoWebPage=$(wget $url -q -O -)
# Validate HTML was correctly fetched
# if [ -n "$repoWebPage" ]
# then
#     echo $repoWebPage >> index.html
# else
#     echo "[FAILED] Web crawler unable to fetch DOM for $url"
#     exit 1
# fi