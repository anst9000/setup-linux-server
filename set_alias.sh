#!/bin/bash

## Set an alias to start the installation with command 'start'
echo "alias start='bash start_setup.sh 2>&1 | tee setup.log'" >> /root/.bashrc
exec bash
