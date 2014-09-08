#!/bin/bash

# Checks if the source and target are different. Copies source to target
# if so and stores a backup of the target in /backups
safe_copy() {
    # Check for destination directory and create it if needed
    if ! [[ -d `dirname $2` ]] ; then
        mkdir -p $(dirname $2)
        cp $1 $2
        cp $1 backups/
        echo "Created " $2
        safe_copy_result=0
        exit
    fi
    # Determine if source and target are different
    `diff $1 $2 > /dev/null`
    if [ $? -ne 0 ] ; then
        cp $2 backups/
        cp $1 $2
        echo "Overwrote " $2 " with " $1 . "Use /backups for old version"
        safe_copy_result=0
    else
        echo $1 " is up to date. Skipping..."
        safe_copy_result=1
    fi
}
