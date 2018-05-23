#!/bin/bash

#A decommenter si la distrib linux n'est pas a jour
#apt-get update && apt-get upgrade -y
#echo "Mise à jour packages système done"

#Install mysql 5.6
echo "Téléchargement MySQL"
wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.16-debian6.0-x86_64.deb
echo "Téléchargement MySQL DONE"
echo "Installation MySQL"
sudo dpkg -i mysql-5.6.16-debian6.0-x86_64.deb
echo "Installation MySQL DONE"

#Install Workbench 6
echo "Installation Workbench"
sudo apt-get install mysql-workbench
echo "Installation Workbench DONE"

#Import du script sql
mysql -u root -p d_vigne < creation-base.sql
