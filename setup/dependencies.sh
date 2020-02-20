#!/bin/bash
set -ex -o pipefail

# install utilities
sudo apt-get update && sudo apt-get -y install jq python3-pip unzip

# install aws cli
sudo pip3 install awscli

# install azure cli
sudo pip3 install setuptools
sudo pip3 install azure-cli

# install digitalocean cli
curl -L https://github.com/digitalocean/doctl/releases/download/v1.38.0/doctl-1.38.0-linux-amd64.tar.gz | sudo tar -xz -C /usr/local/bin