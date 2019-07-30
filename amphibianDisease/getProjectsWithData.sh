#!/bin/bash
if [ -z "$1" ]
  then
    echo "Enter password "
    exit
fi

mysql -u jdeck -p$1 -h gall.bnhm.berkeley.edu amphibiaweb_disease < getProjectsWithData.sql
