#!/bin/bash
 
#Script to generate configurations for each project

echo "Putting JSON to server...."

# Biocode Family of Projects
#for projectID in 1 3 4 5 6 7 8 9 10 11 13
#for projectID in 1 

# Dipnet project
for projectID in 2

do
    curl -X PUT -H 'Content-Type: application/json' --data "@/home/jdeck/code/geome-configurations/bin/dipnet.json" https://api.develop.geome-db.org/projects/$projectID/config?access_token=Ga7EsPA6zhKq2DnfaMU8
done
