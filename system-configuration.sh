#!/bin/bash
# This script will configure your local Windows Linux image (Ubuntu) system to
# start working with latest vRA workflows based on Ansible roles.

# Context variables
TERRAFORM_VERSION=0.12.29

# Starting with a Ubuntu system upgrade
sudo apt-get update
sudo apt-get upgrade -y

# Terraform installation
# Download Terraform from official reposiroty
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

sudo apt-get -y install zip
unzip terraform*.zip
sudo mv -f terraform /usr/local/bin
terraform version

# Ansible installation
sudo apt-get update
sudo apt-get -y install software-properties-common
sudo apt-get -y install ansible

# Verify packages are installed
packages=("zip" "ansible" "ca-certificates")
for pkg in ${packages[@]}; do

	is_pkg_installed=$(dpkg-query -W --showformat='${Status}\n' ${pkg} | grep "install ok installed")
	if [ "${is_pkg_installed}" == "install ok installed" ]; then
		echo ${pkg} is installed.
	else
		echo ${pkg} has not been correctly installed.
		exit 3
	fi
done

# Python installation
sudo apt-get -y update
sudo apt-get -y install git
sudo apt-get -y install gcc
sudo apt-get -y install python-pip
sudo apt-get -y install python3-pip

# Verify packages are installed
packages=("git" "gcc" "python-pip" "python3-pip")
for pkg in ${packages[@]}; do

	is_pkg_installed=$(dpkg-query -W --showformat='${Status}\n' ${pkg} | grep "install ok installed")
	if [ "${is_pkg_installed}" == "install ok installed" ]; then
		echo ${pkg} is installed.
		if [ "${pkg}" == "python-pip" ]; then
			sudo pip install pywinrm
		else
			sudo pip3 install pywinrm
		fi
	fi
done
exit 0

