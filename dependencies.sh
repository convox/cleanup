#!/bin/bash
set -ex -o pipefail

# install utilities
sudo apt-get update && sudo apt-get -y install jq unzip

# install aws cli
sudo apt-get -y install awscli