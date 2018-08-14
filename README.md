# geome-configurations
The official spawning ground for ALL Geome projects...

The process involves:
1. use DEVELOP environment to save the Biocode Template and the DIPNet configurations.
2. Changes can be made online at the development site, or by downloading the JSON and editing the files there.
3. Once changes have been made to the JSON configuration files, they are uploaded back to the DEVELOP server and tested.
4. Once changes look good the files can be pushed to the PRODUCTION server

Following are instructions:

```
cd bin
curl https://api.develop.geome-db.org/projects/1/config > template.json.gz
gunzip template.json.gz
# run the following script to loop through projects and load
./put.sh
```

initial_creation_scripts:not really used but contains the initial creation scripts used for generating projects.  These
were run at the inception of geome and contain useful information but should not be run.
