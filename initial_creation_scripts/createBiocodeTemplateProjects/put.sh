#!/bin/bash
 
#Script to generate configurations for each project

echo "Putting JSON to server...."
# put this which validates
# Biocode Family of Projects
#for projectID in 1 3 4 5 6 7 8 9 10 11
for projectID in 13
do
    curl -X PUT -H 'Content-Type: application/json' --data "@/home/jdeck/code/biocode-exports/scripts/createBiocodeTemplateProjects/template.json" https://api.develop.geome-db.org/projects/$projectID/config?access_token=Sw_wQUBBAWTJVfttknfy
done
