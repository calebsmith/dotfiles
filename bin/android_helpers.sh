#!/bin/bash

function android_get_pkg() {
    # Gets the name of the package
    echo $(aapt dump badging $1 |
        awk -F" " '/package/ {print $2}' |
        awk -F"'" '/name=/ {print $2}'
    )
}

function android_get_main() {
    # Gets the name of main launchable activity
    echo $(aapt dump badging $1 |
        awk -F" " '/launchable-activity/ {print $2}' |
        awk -F"'" '/name=/ {print $2}'
    )
}

function android_get_project_name() {
    # Gets the name of the project
    echo $(
        cat build.xml |
        awk -F"\"" '/project name=/ {print $2}'
    )
}

function android_get_build_filename() {
    # Gets the filename of the build
    echo "bin/"$(android_get_project_name)"-"${1:-debug}".apk"
}

function android_build() {
    # Create a clean build
    ant clean ${1:-debug}
}

function android_install() {
    # Install the build onto the connected device (must be built)
    adb install -r $(android_get_build_filename)
}

function android_run() {
    # Run the main activity of the project on the phone (must be installed)
    local build_filename=$(android_get_build_filename)
    local pkg=$(android_get_pkg $build_filename)
    local main=$(android_get_main $build_filename)
    adb shell am start -n $pkg/$main
}

function android_go() {
    # Do a build, install, and run, stopping on failures
    echo "Building target" ${1:-debug}
    android_build
    if [[ $? -eq 0 ]] ; then
        echo "(Re)Installing APK"
        android_install
        if [[ $? -eq 0 ]] ; then
            echo "Running APK"
            android_run
        fi
    fi
}
