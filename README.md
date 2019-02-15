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
select create_project(3, 'ACEH','ACEH',1);
select create_project(4, 'AMANDA','AMANDA',1);
select create_project(5, 'BALI','BALI',1);
select create_project(6, 'NOAA','NOAA',1);
select create_project(7, 'PEER','PEER',1);
select create_project(8, 'PIRE','PIRE',1);
select create_project(9, 'PNMNH','PNMNH',1);
select create_project(10, 'SERIBU','SERIBU',1);
select create_project(11, 'TIMOR','TIMOR',1);
select create_project(12, 'SI_BLITZ','SI BioBlitz',1);
```

# Creating Configuration Files
Configuration files are managed in the geome-configurator repository.
```
# Biocode Template = 1
# Dipnet = 2
curl https://api.develop.geome-db.org/projects/1/config > biocode.json.gz
curl https://api.develop.geome-db.org/projects/2/config > dipnet.json.gz
gunzip biocode.json.gz
gunzip dipnet.json.gz
# run the following script to load data
bin/putConfigurationFile.sh
```

The files in initial_creation_scripts directory is maintained here for historical purposes.  They are not used currently but contain the initial creation scripts used for generating projects.  These were run at the inception of geome and contain useful information but should not be run.
