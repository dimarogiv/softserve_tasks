#!/bin/bash

# APT update
export DEBIAN_FRONTEND=noninteractive
apt update -y
apt upgrade -y

# Package installation
apt install -y prometheus

# Configuration
sed -i '/scrape_configs/,$s/.prometheus.$/web/' /etc/prometheus/prometheus.yml
sed -i '/scrape_configs/,$s/node$/db/' /etc/prometheus/prometheus.yml
sed -i '/web$/,/- targets: /s/localhost:9090/web:9113/' /etc/prometheus/prometheus.yml
sed -i '/db$/,/- targets: /s/localhost/db/' /etc/prometheus/prometheus.yml
cat /home/vagrant/.ssh/id_rsa.pub.host >> /home/vagrant/.ssh/authorized_keys
echo 192.168.56.3 db >> /etc/hosts
echo 192.168.56.2 web >> /etc/hosts

# Restarting daemons
systemctl restart prometheus

# Reboot
echo rebooting
reboot
