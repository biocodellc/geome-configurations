#!/bin/bash
 
#Script to generate configurations for each project

echo "Putting JSON to server...."

# Biocode Family of Projects
for projectID in 1 3 4 5 6 7 8 9 10 11 13
#for projectID in 1 

do
    curl -X PUT -H 'Content-Type: application/json' --data "@/home/jdeck/code/geome-configurations/bin/biocode.json" https://api.develop.geome-db.org/projects/$projectID/config?access_token=rgSAZnpV_VcaDk5s_upW
done

