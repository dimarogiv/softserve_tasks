#!/bin/bash

echo This is the Database server. > /home/vagrant/db_status.txt

# APT update
export DEBIAN_FRONTEND=noninteractive
apt update -y
apt update -y

# Package installation
apt install -y mysql-server
apt install -y prometheus-mysqld-exporter

# Configuration
systemctl start mysql
mysql -e "create user vagrant@localhost identified by 'password'"
mysql -e "grant all on *.* to vagrant@localhost"
mysql -uvagrant -ppassword -e 'create database test_db'
mysql -uvagrant -ppassword test_db -e 'create table users (id INT, name VARCHAR(20))'
mysql -uvagrant -ppassword test_db -e "insert into users (id, name) values(1, 'Alice'), (2, 'Bob')"
mysql -e "rename user vagrant@localhost to vagrant@web"
sed -i '/^bind-address/s/127.0.0.1$/192.168.56.3/' /etc/mysql/mysql.conf.d/mysqld.cnf
cat /home/vagrant/.ssh/id_rsa.pub.host >> /home/vagrant/.ssh/authorized_keys
echo 192.168.56.2 web >> /etc/hosts

# Restarting daemons
systemctl enable mysql
systemctl enable prometheus-mysqld-exporter

# Reboot
echo rebooting
reboot
