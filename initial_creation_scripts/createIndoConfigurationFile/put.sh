#!/bin/bash
 
# USE THIS SCRIPT WITH CAUTION!!!
# THIS IS ONLY MEANT FOR INITIAL LOADING AND TESTING OF NEW CONFIGURATIONS
# USING THIS SCRIPT TO ALTER CONFIGURATIONS IS A BIG CANNON
#
#Script to generate INDO configuration file and push to Geome Server
#  header contains header elements, including lists
#  samples.json == sample entity
#  events.json == event entity
#  tissues.json == tissue entity
#  footer.json == wrapping up
#
#NOTE: in the put command at the bottom, get an access_token by logging into 
#the new Geome site and grabbing the returned access by looking in th
#developmer tools

rm -f indo.json
rm -f tmp.json

echo "Generating JSON file..."
cat header.json > tmp.json 
cat samples.json >> tmp.json 
echo "},{" >> tmp.json
cat events.json >> tmp.json 
echo "},{" >> tmp.json 
cat tissues.json  >> tmp.json
echo "}" >> tmp.json
cat footer.json >> tmp.json
retVal=$?
if [ $retVal -eq 0 ]; then
    echo "  Success!"
else
    echo "    Failed, exiting";
    exit $retVal
fi


echo "Pretty printing file ..."
python -m json.tool tmp.json > indo.json
retVal=$?
if [ $retVal -eq 0 ]; then
    echo "  Success!"
else
    echo "  Failed, exiting";
    exit $retVal
fi

echo "Running JSONLint on file ..."
jsonlint indo.json -q
retVal=$?
if [ $retVal -eq 0 ]; then
    echo "  Success!"
else
    echo "  Failed, exiting";
    exit $retVal
fi

echo "Putting JSON to server...."
# put this which validates
curl -X PUT -H 'Content-Type: application/json' --data "@/home/jdeck/code/biocode-exports/scripts/createIndoConfigurationFile/indo.json" https://api.develop.geome-db.org/projects/34/config?access_token=7D7cFvWm5nHHtWPHaqvq
