#!/bin/bash
 
#Script to generate configurations for each project

usage()
{
    echo "usage: putDipnet.sh [DEV|PROD] [access_token]"
}

run() 
{
    echo "Putting JSON to server...."
    # Set server
    if [ "$1" = "DEV" ]; then
	# Set development DIPNET project_id:
        projectID=2
        url=https://api.develop.geome-db.org/projects/$projectID/config?access_token=$access_token
    else
	# Set production DIPNET project_id:
        projectID=1
        url=https://api.geome-db.org/projects/$projectID/config?access_token=$access_token
    fi
    echo "endpoint: "$url
    curl -X PUT -H 'Content-Type: application/json' --data "@$file_path" $url
}

# Set File path
file_path=/home/jdeck/code/geome-configurations/bin/dipnet.json

# Set access_toekn
access_token=$2

if [ $# -ne 2 ]
then
    usage
    exit
else 
    run
    exit
fi
