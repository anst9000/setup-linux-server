#!/bin/bash

echo "-- Set some aliases and functions in .bashrc"

echo "alias runner='chm run_setup.sh && bash run_setup.sh'" >> .bashrc
echo "alias start='bash start_setup.sh 2>&1 | tee setup.log'" >> .bashrc
echo "chm() {	sudo chmod +x $1 }" >> .bashrc
source .bashrc
cat .bashrc
