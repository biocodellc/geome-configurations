#!/usr/bin/env bash

DATA_DIR='/opt/ipt/data'
IPT_TRANSFORMER=/home/jdeck/code/geome-configurations/bin/ipt_transformer.py

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as sudo" ; exit 1 ; fi

# run the IPT extraction
#params project project_id
extractIPT() {
    PROJECT=$1
    PROJECT_ID=$2
    url="$(curl -sg 'https://api.geome-db.org/records/Sample/csv?q=_select_:[Event,Sample,Tissue]%20_projects_:'$PROJECT_ID | jq -r '.url')"

    wget -q -O $DATA_DIR/$PROJECT.csv.zip "$url"
    unzip -p $DATA_DIR/$PROJECT.csv.zip > $DATA_DIR/$PROJECT.csv

    python3 $IPT_TRANSFORMER $DATA_DIR/$PROJECT.csv

    sqlite3 $DATA_DIR/$PROJECT.db "drop table if exists $PROJECT;" ".mode csv" ".import $DATA_DIR/$PROJECT.csv $PROJECT" ".exit"

    # update scientificName field where it was not given
    sqlite3 $DATA_DIR/$PROJECT.db "update $PROJECT set scientificName = genus || ' ' || specificEpithet where scientificName ='';"

    rm -f $DATA_DIR/$PROJECT.csv.zip
    rm -f $DATA_DIR/$PROJECT.csv
}

extractIPT dipnet 1
#Moorea biocode is dumped as two tables -- is there a way to get a dump as a single spreadsheet?
#otherwise, we need a new function where we join tables for the IPT
#extractIPT moorea_biocode 75
