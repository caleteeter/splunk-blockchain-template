#!/bin/bash

#############
# Parameters
#############
AZUREUSER=$1
ARTIFACTS_URL_PREFIX=$2
ARTIFACTS_URL_SASTOKEN=$3
DOCKER_REPOSITORY=$4
DOCKER_LOGIN=$5
DOCKER_PASSWORD=$6
DOCKER_IMAGE=$7

#############
# Constants
#############
HOMEDIR="/home/$AZUREUSER";

#####################################
# Install Docker engine and compose
#####################################
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL --max-time 10 --retry 3 --retry-delay 3 --retry-max-time 60 https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo systemctl enable docker
sleep 5
sudo curl -L --max-time 10 --retry 3 --retry-delay 3 --retry-max-time 60 "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#################################################
# Startup the Splunk deployment
#################################################
tar xvfz quorum.tar.gz
cd quorum
./start.sh istanbul
