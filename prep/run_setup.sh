#!/bin/bash

echo "-- Script ${0} copies files to /usr/local/bin and sets .sh-files as executable."


echo "-- Copy files to directory /usr/local/bin"
cp -R ../* /usr/local/bin


echo "-- Change to directory /usr/local/bin"
cd /usr/local/bin


PWD=`pwd`
echo "-- Working directory is ${PWD}"


echo "-- Change mod to +x"
chmod +x *.sh


echo "-- Check the content of the directory"
ls -al .


echo "-- Run the Server startup script"
bash start_setup.sh 2>&1 | tee /usr/local/bin/setup.log
