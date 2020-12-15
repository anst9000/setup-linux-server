#!/bin/bash

printInfo() {
	echo
	echo "--- $1"
	echo
}


## The script will reset user and delete setup files
printInfo "The script will reset user and delete setup files"


## Read the variables from the config file
printInfo "Reading the config file."
config_file=/usr/local/bin/setup_vars.json
ip_address="$( jq -r '.ip_address' "$config_file" )"
hostname="$( jq -r '.hostname' "$config_file" )"
user="$( jq -r '.user' "$config_file" )"
password="$( jq -r '.password' "$config_file" )"
localhost="$( jq -r '.localhost' "$config_file" )"

echo "$ip_address, $hostname, $user, $password, $localhost"

## Deleting user $user
printInfo "Deleting user $user"
userdel -r $user

## Delete the setup files in /usr/local/bin
cd /usr/local/bin
sudo rm *


printInfo "Done"

exit $code
