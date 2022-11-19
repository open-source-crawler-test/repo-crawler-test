#!/usr/bin/env bash

# Authenticate
redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS ping

# Execute RedisDB. Queries
redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS set cat-count 10

redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS get cat-count



# redis-cli -h $REDIS_HOST -p $REDIS_PORT -a '' ping


# redis-cli -h $REDIS_HOST -p $REDIS_PORT -a '' ping

# AUTH [username] <password> 

# SET
# redis-cli set cat-count 10

# GET
# echo "$(redis-cli get cat-count)"

# UPDATE

# DELETE


# redis-cli rpush cat-breeds persian ragdoll bengal
# $ redis-cli lpush hairless-cats sphynx
# redis-cli hset cat1 breed norwegian
# (integer) 1
# $ redis-cli hmset cat2 breed bobtail coat long