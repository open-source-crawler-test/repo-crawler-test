#!/usr/bin/bash

function validateRedisCreds {
    if [[ $1 && $2 && $3 && $4 ]] ; then
        echo "Redis credentials are valid" 
    else 
        echo "Invalid redis credentials provided"
        exit 1
    fi
}
