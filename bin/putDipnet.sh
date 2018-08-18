#!/bin/bash
 
#Script to generate configurations for each project

echo "Putting JSON to server...."

# Dipnet project
for projectID in 2

do
    curl -X PUT -H 'Content-Type: application/json' --data "@/home/jdeck/code/geome-configurations/bin/dipnet.json" https://api.develop.geome-db.org/projects/$projectID/config?access_token=sas99ceuhYTgRQU7HM5A
done

