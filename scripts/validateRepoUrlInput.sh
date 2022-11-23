#!/usr/bin/bash

function validateRepoUrlInput {
    if ! [[ $1 =~ ^[a-zA-Z0-9\-]+[/][a-zA-Z0-9\-]+$ ]] ; then
        echo "Invalid repository user/name input provided"
        exit 1
    fi
}
