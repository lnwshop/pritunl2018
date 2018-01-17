#!/bin/bash

if [[ -e /etc/*-release ]]; then
VERSION_ID="16.04"

# Ubuntu 16.04
sudo tee -a /etc/apt/sources.list.d/mongodb-org-3.6.list << EOF 
deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse 
EOF
sudo tee -a /etc/apt/sources.list.d/pritunl.list << EOF 
deb http://repo.pritunl.com/stable/apt xenial main 
EOF
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A 
sudo apt-get update
sudo apt-get --assume-yes install pritunl mongodb-org 
sudo systemctl start pritunl mongod
sudo systemctl enable pritunl mongod

apt-get -y install squid
cp /etc/squid/squid.conf /etc/squid/squid.conf.orig
cat > /etc/squid/squid.conf <<-END
http_port 8080
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/255.255.255.255
http_access allow SSH
http_access allow localnet
http_access allow localhost
http_access deny all
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
END
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | grep -v '192.168'`;
sed -i s/xxxxxxxxx/$MYIP/g /etc/squid/squid.conf;
/etc/init.d/squid restart
sleep 2

clear
IP=`dig +short myip.opendns.com @resolver1.opendns.com`
echo ""
echo "Install Pritunl Finish..."
echo "Ubuntu 16.04 Xenial version."
echo "Source by Mnm Ami (Donate via TrueMoney Wallet : 082-038-2600)"
echo ""
echo "Proxy : $IP"
echo "Port  : 8080"
echo "==================================="
echo "     http://$IP"
echo ""
pritunl setup-key
echo "==================================="
rm Pritunl.sh

elif [[ -e /etc/*-release ]]; then
VERSION_ID="14.04"

# Ubuntu 14.04
sudo tee -a /etc/apt/sources.list.d/mongodb-org-3.6.list << EOF
deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.6 multiverse
EOF
sudo tee -a /etc/apt/sources.list.d/pritunl.list << EOF
deb http://repo.pritunl.com/stable/apt trusty main
EOF
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo apt-get update
sudo apt-get --assume-yes install pritunl mongodb-org
sudo service pritunl start

apt-get -y install squid3
cp /etc/squid3/squid.conf /etc/squid3/squid.conf.orig
cat > /etc/squid3/squid.conf <<-END
http_port 8080
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/255.255.255.255                 
http_access allow SSH
http_access allow localnet
http_access allow localhost
http_access deny all
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
END
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | grep -v '192.168'`;
sed -i s/xxxxxxxxx/$MYIP/g /etc/squid3/squid.conf;
/etc/init.d/squid3 restart
sleep 2

clear
IP=`dig +short myip.opendns.com @resolver1.opendns.com`
echo ""
echo "Install Pritunl Finish..."
echo "Ubuntu 14.04 Trusty version."
echo "Source by Mnm Ami (Donate via TrueMoney Wallet : 082-038-2600)"
echo ""
echo "Proxy : $IP"
echo "Port  : 8080"
echo "==================================="
echo "     http://$IP"
echo ""
pritunl setup-key
echo "==================================="
rm Pritunl.sh

elif [[ -e /etc/*-release ]]; then
VERSION_ID="8"

# Debian 8
sudo tee -a /etc/apt/sources.list.d/mongodb-org-3.6.list << EOF
deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main
EOF
sudo tee -a /etc/apt/sources.list.d/pritunl.list << EOF
deb http://repo.pritunl.com/stable/apt jessie main
EOF
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo apt-get update
sudo apt-get --assume-yes install pritunl mongodb-org
sudo systemctl start mongod pritunl
sudo systemctl enable mongod pritunl

apt-get -y install squid3
cp /etc/squid3/squid.conf /etc/squid3/squid.conf.orig
cat > /etc/squid3/squid.conf <<-END
http_port 8080
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/255.255.255.255                 
http_access allow SSH
http_access allow localnet
http_access allow localhost
http_access deny all
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
END
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | grep -v '192.168'`;
sed -i s/xxxxxxxxx/$MYIP/g /etc/squid3/squid.conf;
/etc/init.d/squid3 restart
sleep 2

clear
IP=`dig +short myip.opendns.com @resolver1.opendns.com`
echo ""
echo "Install Pritunl Finish..."
echo "Debian 8 Jessie version."
echo "Source by Mnm Ami (Donate via TrueMoney Wallet : 082-038-2600)"
echo ""
echo "Proxy : $IP"
echo "Port  : 8080"
echo "==================================="
echo "     http://$IP"
echo ""
pritunl setup-key
echo "==================================="
rm Pritunl.sh

else
clear
echo ""
echo "สคริปท์นี้รองรับเฉพาะ Debian 8, Ubuntu 14.04 และ 16.04 เท่านั้น"
echo ""
echo "Source by Mnm Ami (Donate via TrueMoney Wallet : 082-038-2600)"
echo ""
rm Pritunl.sh
exit

fi
