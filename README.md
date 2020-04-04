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
curl https://api.{DEVELOP|}geome-db.org/network/1/config | gunzip - | python -m json.tool > {NETWORK_FILE}

# edit the network file in text editor

# put the network configuration
curl -g -X PUT -H 'Content-Type: application/json' --data "@{NETWORK_FILE}" https://api.geome-db.org/network/1/config?access_token={ACCESS_TOKEN}
```
# List project Configurations 
The following lists network approved project configurations
```
curl https://api.{DEVELOP|}geome-db.org/projects/configs?networkApproved=true | python -m json.tool 
```
# Update project Configuration files
Once you have the {CONFIG_ID}, obtained from the previous section we can fetch, modify, and then PUT the data.
The configuration ID that we are referring to updates the configuration in the project_configurations table, 
which effectively updates TEAM configurations.
```
# Get a project configuration, unzip, pretty print JSON and write to file: 
curl https://api{DEVELOP|}.geome-db.org/projects/configs/{CONFIG_ID}?access_token={ACCESS_TOKEN} | gunzip - | python -m json.tool > {CONFIG_ID}.json

# Update {CONFIG_ID}.json using a text editor

# PUT the entire projectConfiguration object back:
curl -X PUT -H 'Content-Type: application/json' --data "@{FILE_PATH}" https://api{DEVELOP|}.geome-db.org/projects/configs/{CONFIG_ID}?access_token={ACCESS_TOKEN}
```

or, you can run the convenience script in the bin directory:
```
$ ./bin/putConfigurationFile.sh
usage: putConfigurationFile.sh [DEV|PROD] [access_token] [projectID] [file_path]
```

