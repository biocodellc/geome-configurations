# biocode

# config_id = 1
curl https://api.geome-db.org/projects/configs/2?access_token=QuQHJDus_mmMR7qtTeBS | gunzip - | python3 -m json.tool > 2.json
cp 2.json 2-modified.json
# modify file
curl -X PUT -H 'Content-Type: application/json' --data "@2-modified.json" https://api.geome-db.org/projects/configs/2?access_token=QuQHJDus_mmMR7qtTeBS


# config_id = 5
curl https://api.geome-db.org/projects/configs/5?access_token=QuQHJDus_mmMR7qtTeBS | gunzip - | python3 -m json.tool > 5.json
cp 5.json 5-modified.json
# modify file
curl -X PUT -H 'Content-Type: application/json' --data "@5-modified.json" https://api.geome-db.org/projects/configs/5?access_token=QuQHJDus_mmMR7qtTeBS

# config_id = 6
curl https://api.geome-db.org/projects/configs/6?access_token=QuQHJDus_mmMR7qtTeBS | gunzip - | python3 -m json.tool > 6.json
cp 6.json 6-modified.json
# modify file
curl -X PUT -H 'Content-Type: application/json' --data "@6-modified.json" https://api.geome-db.org/projects/configs/6?access_token=QuQHJDus_mmMR7qtTeBS

# config_id = 171
curl https://api.geome-db.org/projects/configs/171?access_token=QuQHJDus_mmMR7qtTeBS | gunzip - | python3 -m json.tool > 171.json
cp 171.json 171-modified.json
# modify file
curl -X PUT -H 'Content-Type: application/json' --data "@171-modified.json" https://api.geome-db.org/projects/configs/171?access_token=QuQHJDus_mmMR7qtTeBS