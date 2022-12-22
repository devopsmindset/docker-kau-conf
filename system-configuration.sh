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
#packages=("zip" "ansible" "ca-certificates")
#for pkg in ${packages[@]}; do
#
#	is_pkg_installed=$(dpkg-query -W --showformat='${Status}\n' ${pkg} | grep "install ok installed")
#	if [ "${is_pkg_installed}" == "install ok installed" ]; then
#		echo ${pkg} is installed.
#	else
#		echo ${pkg} has not been correctly installed.
#		exit 3
#	fi
#done

# Install Roche certificates
sudo apt-get -y update
cd /usr/local/share/ca-certificates || exit
sudo wget --no-check-certificate --no-verbose http://repository.kiosk.roche.com/public/certificates/roche.com/roche_com_enterprise.crt -O roche_com_enterprise.crt
sudo wget --no-check-certificate --no-verbose http://repository.kiosk.roche.com/public/certificates/roche.com/roche_com_root.crt -O roche_com_root.crt
sudo wget --no-check-certificate --no-verbose http://repository.kiosk.roche.com/public/certificates/roche.com/geo_trust.crt -O geo_trust.crt
sudo wget --no-check-certificate --no-verbose http://certinfo.roche.com/rootcerts/Roche%20G3%20Root%20CA.crt -O roche_com_CA1_G3.crt
sudo wget --no-check-certificate --no-verbose http://certinfo.roche.com/rootcerts/Roche%20Root%20CA%201%20-%20G2.crt -O roche_com_CA1_G2.crt
sudo wget --no-check-certificate --no-verbose http://certinfo.roche.com/rootcerts/Roche%20Root%20CA%201.crt -O roche_com_CA1.crt
update-ca-certificates

# Python installation
sudo apt-get -y update
sudo apt-get -y install git
sudo apt-get -y install gcc
sudo apt-get -y install python-pip
sudo apt-get -y install python3-pip

# Verify packages are installed
#packages=("git" "gcc" "python-pip" "python3-pip")
#for pkg in ${packages[@]}; do
#
#	is_pkg_installed=$(dpkg-query -W --showformat='${Status}\n' ${pkg} | grep "install ok installed")
#	if [ "${is_pkg_installed}" == "install ok installed" ]; then
#		echo ${pkg} is installed.
#		if [ "${pkg}" == "python-pip" ]; then
#			sudo pip install pywinrm
#		else
#			sudo pip3 install pywinrm
#		fi
#	fi
#done
sudo pip install pywinrm
sudo pip3 install pywinrm
exit 0

