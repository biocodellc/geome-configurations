# geome-configurations
The official spawning ground for ALL Geome projects...

Create and Manage project configurations for geome.


```
cd bin
curl https://api.develop.geome-db.org/projects/1/config > template.json.gz
gunzip template.json.gz
# run the following script to loop through projects and load
./put.sh
```

initial_creation_scripts:not really used but contains the initial creation scripts used for generating projects.  These
were run at the inception of geome and contain useful information but should not be run.
