#!/bin/bash



#user="$( jq -r '.user' "$default_config_file" )"
#
#
#sudo sshpass -p $password
#

user=USER
password=PASSWORD


hosts=(
	139.162.156.75
	139.162.136.92
	172.104.228.231
  139.162.166.95
)




for host in "${hosts[@]}"
do
	origin_path=/home/$user/Projects/setup-linux-server/scp_script/
	host_path="root@${host}:/usr/local/bin"
	echo $host
	echo $origin_path
	echo $host_path

	sshpass -p $password scp -r $origin_path $host_path
done
