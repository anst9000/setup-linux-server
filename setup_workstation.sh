#!/bin/bash

## https://willschenk.com/articles/2020/server_templating_with_terraform/
## https://gist.github.com/JamieMLH/8c84c509bdc5d4e575c57f3d74722ff3

ip_address=$1
hostname=$2
user=$3
localhost=127.0.0.1

printInfo() {
	echo
	echo $1
	echo
}

## Make this program run as root
id
sudo -s <<EOF
echo Now i am root
id
echo "yes!"
EOF

## Run update and upgrade
printInfo "Updating repositories and upgrading installations"
sudo apt update && sudo apt dist-upgrade -y

## Set the hostname via hostnamectl and file
printInfo "Setting the hostname to $hostname"
sudo hostnamectl set-hostname $hostname


sudo sed -i "s/^.*127.*$/$localhost\tlocalhost\n127.0.1.1\t$hostname\n$ip_address\t$hostname/g" /etc/hosts
#sudo sed -i "s//$hostname/g" /etc/hosts

## Set up a new user account for $user
printInfo "Setting up a new account for $user"


## Installing Ansible
printInfo "Check if Ansible is installed, else installing it."

ansible_installed=`which ansible`
if [ $ansible_installed ]
then
  printInfo "Ansible is already installed."
else
  printInfo "Ansible is not installed. Standby, Ansible will be installed"
  sudo apt update
  sudo apt install ansible -y
fi


## Cloning repos from GitHub
printInfo "Environment is now set up."
printInfo "Cloning https://github.com/mathiasbynens/dotfiles.git"
cd
mkdir Projects && cd Projects
git clone https://github.com/mathiasbynens/dotfiles.git && cd dotfiles && source bootstrap.sh
cd ../..
pwd

printInfo Done
