#!/bin/bash

dname=$(/usr/bin/dirname $0)
dname=$(/bin/readlink -f "$dname")


IFS=$'\n'
for tag in `git tag 2>&1 | sort ` ;
do
    echo "${tag}"
    git tag -d "${tag}"
    git push origin ":${tag}"

done
