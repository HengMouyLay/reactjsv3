#!/bin/bash

# Exit if any command fails
set -e

# Update the package list
sudo apt update

# Install software-properties-common if not already installed
sudo apt install -y software-properties-common

# Add the Ansible PPA
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
sudo apt install -y ansible
