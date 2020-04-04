# Futres configuration notes

One thing that needs to be continually updated in GEOME is the controlled vocabulary 
in measurementType field, which consists of FOVT classes defining all measurements.

This directory contains a measurements.json file which is a JSON snippet containing
the most up-to-date fields from the FOVT ontology that we want to use in the CV
for the measurementType term.  

In the past, we used a text file to define all the relevant terms we were working on
for futres and pulled from the fovt_classes.csv file in the FOVT repository all the 
measurement classes we needed.  However, now we need to define a list coming from the
refactored ontology....


