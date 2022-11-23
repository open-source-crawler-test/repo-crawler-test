#!/usr/bin/bash

source ./scripts/validateRedisCreds.sh

function generateRedisDebugLog {
    CRAWL_QUEUE_KEY='dev-crawl-queue'
    SCAN_QUEUE_KEY='dev-scan-queue'

    validateRedisCreds $REDIS_HOST $REDIS_PORT $REDIS_USER $REDIS_PASS

    # Generate log file
    touch REDIS_DEBUG_LOG.md

    echo '# Redis Debug Log' >> REDIS_DEBUG_LOG.md
    echo '' >> REDIS_DEBUG_LOG.md

    echo '## Crawl Queue Usage'
    echo '' >> REDIS_DEBUG_LOG.md
    crawlQueueNextTen=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS LRANGE $CRAWL_QUEUE_KEY 0 10)
    echo '**CrawlQueue next 10:**' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '$crawlQueueNextTen' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '' >> REDIS_DEBUG_LOG.md
    
    crawlQueueMemoryUsage=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS MEMORY USAGE $CRAWL_QUEUE_KEY)
    echo '**CrawlQueue memory usage:**' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '$crawlQueueMemoryUsage' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '' >> REDIS_DEBUG_LOG.md

    echo '## Scan Queue Usage'
    echo '' >> REDIS_DEBUG_LOG.md
    scanQueueNextTen=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS LRANGE $SCAN_QUEUE_KEY 0 10)
    echo '**ScanQueue next 10:**' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '$scanQueueNextTen' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '' >> REDIS_DEBUG_LOG.md
    scanQueueMemoryUsage=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS MEMORY USAGE $SCAN_QUEUE_KEY)
    echo '**ScanQueue memory usage:**' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '$scanQueueMemoryUsage' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '' >> REDIS_DEBUG_LOG.md

    echo '## Overall Memory Usage' >> REDIS_DEBUG_LOG.md
    echo '' >> REDIS_DEBUG_LOG.md
    memoryUsage=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS info memory)
    echo '\`redis-cli info memory\`' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '$memoryUsage' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '' >> REDIS_DEBUG_LOG.md

    # Dbsize – The Redis dbsize command shows the total number of valid keys in a specific database.
    dbSizes=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS -n 0 dbsize)
    echo '\`redis-cli -n 0 dbsize\`' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '$dbSizes' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '' >> REDIS_DEBUG_LOG.md
    
    # Info keyspace – This command shows the keys in each database available in the Redis cluster.
    infoKeyspace=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS info keyspace)
    echo '\`redis-cli info keyspace\`' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '$infoKeyspace' >> REDIS_DEBUG_LOG.md
    echo '\`\`\`' >> REDIS_DEBUG_LOG.md
    echo '' >> REDIS_DEBUG_LOG.md
}

generateRedisDebugLog