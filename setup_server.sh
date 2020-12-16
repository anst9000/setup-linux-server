#!/bin/bash

printInfo() {
	echo
	echo "--- $1"
	echo
}


## Read the variables from the config file
printInfo "Reading the default var config file and the specific var config file."
source vars/config.sh
#printInfo "Default config file is $default_config_file"
#printInfo "IP config file is $ip_config_file"

user="$( jq -r '.user' "$default_config_file" )"
password="$( jq -r '.password' "$default_config_file" )"
localhost="$( jq -r '.localhost' "$default_config_file" )"

ip_address="$( jq -r '.ip_address' "$ip_config_file" )"
hostname="$( jq -r '.hostname' "$ip_config_file" )"



## Set the hostname via hostnamectl and file
printInfo "Setting the hostname to $hostname"
sudo hostnamectl set-hostname $hostname



## Updating file /etc/hosts
printInfo "Update the file /etc/hosts with hostname and ip address"
sudo sed -i "s/^.*127.*$/$localhost\tlocalhost\n127.0.1.1\t$hostname\n$ip_address\t$hostname/g" /etc/hosts



## Copy file /etc/nanorc and nanorc template yaml.nanorc to new server
printInfo "Copy file /etc/nanorc and nanorc template yaml.nanorc to new server"
sudo scp root@172.104.247.156:/etc/nanorc /etc/nanorc
sudo scp root@172.104.247.156:/usr/share/nano/yaml.nanorc /usr/share/nano/yaml.nanorc



## Set up a new user account for $user
printInfo "Checking if $user exists"

if id "$user" &>/dev/null; then
	echo "user $user exists"
else
	# error messages should go to stderr
	echo "user $user not found" >&2
	printInfo "Creating $user"
	adduser $user --gecos "Anders Stromberg,,,070 - 648 48 48," --disabled-password
  sudo usermod -aG sudo $user
	echo $user:$password | sudo chpasswd
fi


# set the exit code, ultimately the same set by `id`
exit $code
