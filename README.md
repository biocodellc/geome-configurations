# geome-configurations
Manage project configurations for geome


```
cd bin
curl https://api.develop.geome-db.org/projects/1/config > template.json.gz
gunzip template.json.gz
# run the following script to loop through projects and load
./put.sh
```
