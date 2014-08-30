#!/bin/bash

safe_copy() {
    # Checks if the source and target are different. Copies source to target
    # if so and stores a backup of the target in /backups
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
