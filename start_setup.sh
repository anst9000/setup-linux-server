#!/bin/bash

## https://willschenk.com/articles/2020/server_templating_with_terraform/
## https://gist.github.com/JamieMLH/8c84c509bdc5d4e575c57f3d74722ff3

printInfo() {
	echo
	echo "--- $1"
	echo
}



## Script actions starting here.
printInfo "============================================"
printInfo "Running script start_setup.sh"
printInfo "This script will set up your server with base settings necessary for development."



## Run update and upgrade
printInfo "Updating repositories and upgrading installations"
sudo apt-get update
sudo apt-get dist-upgrade -y



## Install jq to read json-files and sshpass to run scp in scripts
printInfo "Install jq to read json-files and sshpass to run scp in scripts"
sudo apt-get install jq -y
sudo apt-get install sshpass -y
sudo apt-get autoremove -y



## Setting some variables
printInfo "Setting some variables"
source vars/config.sh
#printInfo "Default config file is $default_config_file"
#printInfo "IP config file is $ip_config_file"


## Read the variables from the config file
printInfo "Reading the default var config file and the specific var config file."

user="$( jq -r '.user' "$default_config_file" )"
password="$( jq -r '.password' "$default_config_file" )"
localhost="$( jq -r '.localhost' "$default_config_file" )"

ip_address="$( jq -r '.ip_address' "$ip_config_file" )"
hostname="$( jq -r '.hostname' "$ip_config_file" )"



## Run scripts setup_server.sh and setup_ssh_key.sh
printInfo "Now switching to script setup_server.sh"
./setup_server.sh

printInfo "Now switching to script setup_ssh_key.sh"
./setup_ssh_key.sh



## set the exit code, ultimately the same set by `id`
exit $code
