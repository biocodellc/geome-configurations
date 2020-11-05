# geome-configurations
A spawning ground for GEOME projects using API calls and the command-line.  Not all GEOME projects are created here, 
but this repository does have a set of useful tools to help manage certain projects programitically.  In particular,
for editing templates directly in JSON rather than relying on the interface as well as tools for editing and managing
the GEOME network template.  Project editing is accomplished through fetching templates in JSON format, editing offline,
and then re-loading to GEOME.  This is accomplished using API calls.

# Getting the list of available networks
Currently there is only one network.  Each network defines its own entities and relationships between entities.
```
curl https://api.geome-db.org/v1/network/ | gunzip - | python -m json.tool > allnetworks.json
```

# Working with the network configuration 
The master configuration is the global configuration for a network. In the following example, "1" is network 1
(which is GEOME)
```
# Get the network configuration
curl https://api.geome-db.org/network/1/config | gunzip - | python -m json.tool > network.json

# Edit the network configuration

# Put the network configuration
curl -g -X PUT -H 'Content-Type: application/json' --data "@network.json" https://api.geome-db.org/network/1/config?access_token={ACCESS_TOKEN}
```

# List project Configurations 
The following lists GEOME teams (or, network approved project configurations)
```
curl https://api.geome-db.org/projects/configs?networkApproved=true | python -m json.tool > teams.json
```

# Update project Configuration files
Once you have the {CONFIG_ID}, obtained from the previous section we can fetch, modify, and then PUT the data.
The configuration ID that we are referring to updates the configuration in the project_configurations table, 
which effectively updates either team or project-specific configurations.
```
# Get a project configuration, unzip, pretty print JSON and write to file: 
curl https://api.geome-db.org/projects/configs/{CONFIG_ID}?access_token={ACCESS_TOKEN} | gunzip - | python -m json.tool > {CONFIG_ID}.json

# Update {CONFIG_ID}.json using a text editor

# PUT the entire projectConfiguration object back:
curl -X PUT -H 'Content-Type: application/json' --data "@{FILE_PATH}" https://api.geome-db.org/projects/configs/{CONFIG_ID}?access_token={ACCESS_TOKEN}
```

or, you can run the convenience script in the bin directory:
```
$ ./bin/putConfigurationFile.sh
usage: putConfigurationFile.sh [DEV|PROD] [access_token] [projectID] [file_path]
```

# Creating Projects on the Back-end
Either do this on the front-end or on the back-end like:
```
# Select either biscicoldev or biscicol as PSQL_DB
\c PSQL_DB
# The form is:
#select create_project(ID, 'PROJECT_CODE','PROJECT_TITLE',1)
select create_project(1, 'B_TEMPLATE','Biocode Template',1);
select create_project(2, 'DIPNET','Diversity of the IndoPacific',1);
```
