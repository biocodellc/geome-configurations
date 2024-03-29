Data loader for the Retrospective SRA Datathon

To run the dataloader, we run the datathonLoader.py script.  Before we run this script we unpack the Datathon files into a directory structure that looks like:
```
expeditions\*
```
Each of these directories contains all of the spreadsheets for the datathon. Note that these directories are not committed to github here since they are quite large.


Next we run the script, like this:

```
/usr/local/bin/python3 datathonLoader.py 305 XYZ expeditions --accept_warnings True > results.txt
```
The above script tells us to load into projectId = 305, access_code = XYZ, and using all the files in nonmarine/QCd or marine/QCd directories.  The access_code is the access token generated from GEOME, which we can obtain by logging into a GEOME account with permissions to load into the datathon project. We parse the files in each directory to extract the expedition name from the file itself, everything before the first underscore. Finally, output is redirected to text to tell us why files may have passed or failed.

Note that for each file an expedition is created.  If there are warnings in the file and no errors, the  behaviour is to load all data.  If there any errors then no data is loaded at all.  You can examine the Project pane for the Datathon and search for expeditions with zero samples to find those that had errors and fix the errors in the output text file. 

The following file contain the result of the processing script:
```
results.txt
```
view the github timestamp to examine time they were generated.
