#!/bin/bash


## set to India IST timezone -- You can dissable it if needed
timedatectl set-timezone 'Asia/Kolkata'
systemctl restart rsyslog 


##disable ipv6 as most time not required
## also while installation at time ipv6 is not ready at your setup
sysctl -w net.ipv6.conf.all.disable_ipv6=1 1>/dev/null
sysctl -w net.ipv6.conf.default.disable_ipv6=1 1>/dev/null

## backup existing repo by copy just for safety
/bin/cp -pR /etc/apt/sources.list /usr/local/src/old-sources.list-`date +%s`
echo "" >  /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bullseye main contrib non-free" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bullseye-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list


apt-get update
apt-get -y upgrade
## few tools need for basic mangement
apt-get -y install vim curl git software-properties-common dirmngr screen mc apt-transport-https lsb-release ca-certificates openssh-server iptraf-ng telnet iputils-ping debconf-utils pwgen xfsprogs iftop htop multitail net-tools elinks wget pssh 

wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'

echo "deb https://packages.sury.org/php/ bullseye main" > /etc/apt/sources.list.d/php.list
echo "deb [arch=amd64] https://dlm.mariadb.com/repo/mariadb-server/10.11/repo/debian bullseye main" > /etc/apt/sources.list.d/mariadb.list
echo "deb [arch=amd64] http://downloads.mariadb.com/Tools/debian bullseye main" >> /etc/apt/sources.list.d/mariadb.list

apt-get update
apt-get -y upgrade

apt-get -y install mariadb-server php8.2 php8.2-imagick php8.2-imap php8.2-intl php8.2-ldap php8.2-mailparse php8.2-mbstring php8.2-memcached php8.2-msgpack php8.2-mysql php8.2-xml php8.2-zip php8.2-bcmath php8.2-cli php8.2-common php8.2-curl php8.2-fpm php8.2-gd php8.2-opcache php8.2-readline php8.2-apcu 

##### configure proper timezone
#dpkg-reconfigure tzdata
##### configure locale proper
#dpkg-reconfigure locales
## set India IST time.
#/bin/rm -rf /etc/localtime
#/bin/ln -vs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
#### for adding firmware realtek driver
#apt-get install firmware-linux-nonfree
#apt-get install firmware-realtek
#update-initramfs -u
## only if VM notfor LXC
## for proxmox/kvm better preformance
#apt-get -y install qemu-guest-agent
## if on Consle need Mouse to use for copy paste use gpm
#apt-get install gpm
#google dns: [2001:4860:4860::8888]
#cloudflare dns: [2606:4700:4700::1111]


hostname -f
ping `hostname -f` -c 2


