# geome-configurations
The official spawning ground for ALL Geome projects.  Includes tools/resources to create new Projects
and manage configuration files

This repository contains the master copies of the configuration files, offline.  The process involves:
1. Changes to configuration files can be made online at the development site, or by downloading the JSON and editing the files there.
2. Once changes have been made to the JSON configuration files, they are uploaded back to the DEVELOP server and tested.
3. Once changes look good the files can be pushed to the PRODUCTION server


# Creating Projects
```
# Select either biscicoldev or biscicol as PSQL_DB
\c PSQL_DB
# The form is:
#select create_project(ID, 'PROJECT_CODE','PROJECT_TITLE',1)
select create_project(1, 'B_TEMPLATE','Biocode Template',1);
select create_project(2, 'DIPNET','Diversity of the IndoPacific',1);
```

# Working with Configuration Files

1. You can get the ID of the configuration you are trying to update here: 
```
curl https://api.develop.geome-db.org/projects/configs | python -m json.tool > {OUTPUT_FILE}
```

2. Get the project configuration, unzip, pretty print JSON and write to file: 
```
curl https://api.develop.geome-db.org/projects/configs/{PROJECT_ID} | gunzip - | python -m json.tool > {CONFIGURATION}.json
```

3. Update {CONFIGURATION}.json using vim

4. PUT the entire projectConfiguration object back:
```
curl -X PUT -H 'Content-Type: application/json' --data "@$file_path" https://api.develop.geome-db.org/projects/configs/{PROJECT_ID}?access_token={ACCESS_TOKEN}
```
or, you can run the convenience script in the bin directory:
```
$ ./bin/putConfigurationFile.sh
usage: putConfigurationFile.sh [DEV|PROD] [access_token] [projectID] [file_path]
```

# Notes

The files in initial_creation_scripts directory is maintained here for historical purposes.  They are not used currently but contain the initial creation scripts used for generating projects.  These were run at the inception of geome and contain useful information but should not be run.
