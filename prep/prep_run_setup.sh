#!/bin/bash

file=~/.bashrc

echo "-- Set some aliases and functions in ${file}"


echo "-- Creating function 'chm()' in ${file}"
sudo sh -c "echo \"\n# Function chm() that sets given file parameter as executable.\" >> ${file}"
sudo sh -c "echo \"chm()\n{\n\tsudo chmod +x $1;\n}\" >> ${file}"


echo "-- Creating alias 'runner' and 'start' in ${file}"
sudo sh -c "echo \"\n# Aliases for running setup and start scripts.\" >> ${file}"
sudo sh -c "echo \"alias runner='chm run_setup.sh && bash run_setup.sh'\" >> ${file}"
sudo sh -c "echo \"alias start='bash start_setup.sh 2>&1 | tee setup.log'\" >> ${file}"
sed -i -e 's/sudo chmod +x ;/sudo chmod +x;/g' $file


source ${file}
