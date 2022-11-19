#!/usr/bin/env bash

# Authenticate
# redis-cli -u redis://<username>:<password>@<host>:<port>/<database-number>
# redis-cli -u redis://$1:$2@$3:$4/$5
# redis://<host>:<port>/<database-number>
redis-cli -u redis://$1:$2/1

# SET
redis-cli set cat-count 10 OK

# GET
echo "$(redis-cli get cat-count)"

# UPDATE

# DELETE


# redis-cli rpush cat-breeds persian ragdoll bengal
# $ redis-cli lpush hairless-cats sphynx
# redis-cli hset cat1 breed norwegian
# (integer) 1
# $ redis-cli hmset cat2 breed bobtail coat long