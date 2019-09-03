# Process for exporting datasets from Amphibian disease portal for import into GEOME

In order to get a list of all project data from the AD portal, i first ran a query against the disease_tracking_data table
from the AD mysql database and used pipe delimeters to output the data using Sequel Pro.  Then, i imported the data into
Excel and massaged the data.  I could not automate the data import here... some of the data was in JSON text in a mysql 5.1 
db with no JSON functions for extracting that data and i needed to do some sleuthing between the interface and the field names
in the mysql db table itself to figure out what data went where. I renamed column names per the Expedition property specification
in the Amphibian Disease Project in GEOME.  This will make it easier to map data into GEOME.  I then saved the output file
in a file called ```project_data.xlsx``` in this directory.  

For the actual data, not just project metadata, look in field called ```sample_raw_data```.  I renamed the hash strings
to the ```id``` field + xlsx extension.  After removing test datasets (from Koo, Kahn, and Deck) am left with 17 dataset
files which are stored in the ```data``` directory.  

There is a new directory called ```revised_data``` which stores clean-up copies of data from the ```data``` directory.  The
files in ```revised_data``` are to be loaded into the amphibian disease project on GEOME and should pass all validation rules there.

# GEOME users Accounts
All data will be loaded into GEOME using the Biocode user.  After data has been validated and loaded and looks good, we 
will *later* create GEOME user accounts for the original data loaders and change ownership

# AD portal modifications
After all data is loaded into GEOME we will begin modification of the back-end of AD portal to grab data from GEOME instead
of cartodb and the mysql database.  Then, turn off cartodb connection and mysqldb databases.

# Legacy method of data loading into AmphibianDisease Portal 

Javascript interface: 
1. User uploads data file to server and stored on Annie

2. Sends the file to FIMS and Validates the data on Biscicol.org  FIMS assigns ark identifiers for the dataset 

Then Performs further validation in PHP

3. Stores data in Mysql and makes a reference to project data as succesfully uploaded, et...

4. Sends data to Cartodb


When the user downloads, it points directly to the spreadsheet that was uploaded as storedd on Annie

When queries are run on the website, sometimes it hits carto, sometimes it hits mysql

So data is stored in FOUR different locations and validation is performed in at least two places.
