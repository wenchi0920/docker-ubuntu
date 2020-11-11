#!/bin/bash

dname=$(/usr/bin/dirname $0)
dname=$(/bin/readlink -f "$dname")


IFS=$'\n'
for tag in `cat "${dname}/tag" | sort` ;
do
    echo "${tag}"
    if [ `git tag 2>&1 | grep "${tag}" | wc -l` -eq "0" ] ;
    then
        cat "${dname}/Dockerfile.sample" | sed "s/{{VER}}/$tag/" > "${dname}/Dockerfile"
        git commit "${dname}/Dockerfile" -m "version ${tag}"
        # git tag -d "${tag}"
        # git push origin ":${tag}"
        git tag "${tag}"
        git push origin master
        git push --tag
    fi
done



