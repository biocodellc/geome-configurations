#!/bin/bash
if [ -z "$1" ]
  then
    echo "Enter password "
    exit
fi

mysql -u jdeck -p$1 -h gall.bnhm.berkeley.edu amphibiaweb_disease < 98b853ce48861afa569406d59a6c8cb4.sql 
