#!/bin/bash

echo This is the Web server. > /home/vagrant/web_status.txt

# APT update
export DEBIAN_FRONTEND=noninteractive
apt update -y
apt upgrade -y

# Package installation
apt install -y nginx
apt install -y mysql-client-core-5.7
snap install nginx-prometheus-exporter
mv /home/vagrant/nginx-prometheus-exporter.service /etc/systemd/system

# Configuration
useradd -m prometheus
echo '<h1> Welcome to the Web Server!</h1>' > /var/www/html/index.html
echo export MYSQL_HOST=db >> /home/vagrant/.bashrc
echo export MYSQL_PWD=password >> /home/vagrant/.bashrc
cat /home/vagrant/.ssh/id_rsa.pub.host >> /home/vagrant/.ssh/authorized_keys
echo 192.168.56.3 db >> /etc/hosts

# Restarting daemons
systemctl enable nginx
systemctl enable nginx-prometheus-exporter

# Reboot
echo rebooting
reboot
