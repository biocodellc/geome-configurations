#!/bin/bash
 
#Script to generate configurations for each project

usage()
{
    echo "usage: putBiocode.sh [DEV|PROD] [access_token] [projectID] [file_path]"
}

run() 
{
    echo "Putting JSON to server...."
    # Set server
    if [ "$server" = "DEV" ]; then
        url=https://api.develop.geome-db.org/projects/$projectID/config?access_token=$access_token
    else
        url=https://api.geome-db.org/projects/$projectID/config?access_token=$access_token
    fi
    echo "endpoint: "$url
    curl -X PUT -H 'Content-Type: application/json' --data "@$file_path" $url
}

# Set access_toekn
server=$1
access_token=$2
projectID=$3
file_path=$4

if [ $# -ne 4 ]
then
    usage
    exit
else 
    run
    exit
fi

