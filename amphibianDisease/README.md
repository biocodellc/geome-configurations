Process by which AmphibianDisease Portal uploaded data:

Javascript interface: 
1. User uploads data file to server and stored on Annie

2. Sends the file to FIMS and Validates the data on Biscicol.org  FIMS assigns ark identifiers for the dataset 

Then Performs further validation in PHP

3. Stores data in Mysql and makes a reference to project data as succesfully uploaded, et...

4. Sends data to Cartodb


When the user downloads, it points directly to the spreadsheet that was uploaded as storedd on Annie

When queries are run on the website, sometimes it hits carto, sometimes it hits mysql

So data is stored in FOUR different locations and validation is performed in at least two places.
