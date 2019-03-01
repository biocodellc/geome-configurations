# geome-configurations
The official spawning ground for ALL Geome projects.  Includes tools/resources to create new Projects
and manage configuration files

This repository contains the master copies of the configuration files, offline.  The process involves:
1. Changes to configuration files can be made online at the development site, or by downloading the JSON and editing the files there.
2. Once changes have been made to the JSON configuration files, they are uploaded back to the DEVELOP server and tested.
3. Once changes look good the files can be pushed to the PRODUCTION server


# Creating Projects
Either do this on the front-end or on the back-end like:
```
# Select either biscicoldev or biscicol as PSQL_DB
\c PSQL_DB
# The form is:
#select create_project(ID, 'PROJECT_CODE','PROJECT_TITLE',1)
select create_project(1, 'B_TEMPLATE','Biocode Template',1);
select create_project(2, 'DIPNET','Diversity of the IndoPacific',1);
```

# Working with the master configuration
```
# get the network configuration
curl https://api.geome-db.org/network/1/config | gunzip - | python -m json.tool > network.json
# put the network configuration
curl -X PUT -H 'Content-Type: application/json' --data "@$file_path" https://api.geome-db.org/network/1/config?access_token={ACCESS_TOKEN}
```

# List Network approved project Configurations (and their identifiers)
```
curl https://api.develop.geome-db.org/projects/configs | python -m json.tool > {OUTPUT_FILE}
```

# Working with project Configuration files
```
# Get a project configuration, unzip, pretty print JSON and write to file: 
curl https://api.develop.geome-db.org/projects/configs/{PROJECT_ID} | gunzip - | python -m json.tool > {CONFIGURATION}.json

You will want to Update {CONFIGURATION}.json using vim

# PUT the entire projectConfiguration object back:
curl -X PUT -H 'Content-Type: application/json' --data "@$file_path" https://api.develop.geome-db.org/projects/configs/{PROJECT_ID}?access_token={ACCESS_TOKEN}
```

or, you can run the convenience script in the bin directory:
```
$ ./bin/putConfigurationFile.sh
usage: putConfigurationFile.sh [DEV|PROD] [access_token] [projectID] [file_path]
```

# Notes

The files in initial_creation_scripts directory is maintained here for historical purposes.  They are not used currently but contain the initial creation scripts used for generating projects.  These were run at the inception of geome and contain useful information but should not be run.
