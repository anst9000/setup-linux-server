#!/bin/bash

printInfo() {
	echo
	echo "--- $1"
	echo
}


## Read the variables from the config file
printInfo "Reading the default var config file and the specific var config file."
source vars/config.sh

user="$( jq -r '.user' "$default_config_file" )"
password="$( jq -r '.password' "$default_config_file" )"
localhost="$( jq -r '.localhost' "$default_config_file" )"

ip_address="$( jq -r '.ip_address' "$ip_config_file" )"
hostname="$( jq -r '.hostname' "$ip_config_file" )"


## Create .ssh directory
printInfo "Setting up ssh key for user $user."
ssh_directory="/home/$user/.ssh"
ssh_file="$ssh_directory/authorized_keys"

if [ -d $ssh_directory ]
then
  printInfo "Directory $ssh_directory exists"
else
  printInfo "Creating directory $ssh_directory"
  sudo mkdir -p $ssh_directory
  ls -al $ssh_directory
fi

if [ -f $ssh_file ]
then
  printInfo "File $ssh_file exists"
else
  printInfo "Creating file $ssh_file"
  touch $ssh_file
  ls -al $ssh_directory
fi


## Change permission of directory .ssh and files in it
printInfo "Change permission of directory .ssh and files in it."
sudo chmod 700 $ssh_directory/
sudo chmod 600 $ssh_directory/*
sudo chown $user:$user $ssh_directory/
sudo chown $user:$user $ssh_directory/*



## Copy authorized keys to file /home/$user/.ssh/authorized_keys
printInfo "Copy authorized keys to file ${ssh_file}"
cat files/id_ed25519.pub >> $ssh_file
cat files/id_rsa.pub >> $ssh_file
cat files/id_acke.pub >> $ssh_file
ls -al $ssh_directory
cat $ssh_file



## Change the file /etc/ssh/sshd_config to not allow root or pw login
printInfo "Change the file /etc/ssh/sshd_config to not allow root or pw login"
# sudo sed -i "s/^.*PermitRootLogin.*$/PermitRootLogin no/" /etc/ssh/sshd_config
sudo sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo systemctl restart sshd



## Install ufw and make some settings
printInfo "Install ufw and make some settings"
sudo apt-get install ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 5000

sudo ufw --force enable

sudo ufw status



## Everything is setup, we are done.
printInfo "Done"



# set the exit code, ultimately the same set by `id`
exit $code
