#!/usr/bin/env bash

# Locale.
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

# Timezone.
echo "America/Montreal" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# Fix for Host file.
echo "127.0.0.1  localhost" > /etc/hosts
echo "127.0.0.1  precise32" >> /etc/hosts
echo "127.0.0.1  vagrant-box" >> /etc/hosts

# Hostname.
echo "vagrant-box" > /etc/hostname

# Update and install required packages.
unset UCF_FORCE_CONFFOLD
export UCF_FORCE_CONFFNEW=YES
ucf --purge /boot/grub/menu.lst

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade
apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy install build-essential checkinstall python-software-properties

# Fix for PHP version.
# add-apt-repository -y ppa:ondrej/php5 # PHP 5.5
add-apt-repository -y ppa:ondrej/php5-oldstable # PHP 5.4
apt-get update

# Fix for MySQL password.
debconf-set-selections <<< 'mysql-server mysql-server/root_password password change_me'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password change_me'
apt-get -y install mysql-server

# Install everything else (as packages).
apt-get -y install memcached
apt-get -y install apache2 php5 libapache2-mod-php5
apt-get -y install php5-mysql php5-curl php5-gd php5-mcrypt php5-memcached
apt-get -y install whois traceroute nmap curl screen
apt-get -y install subversion git-core ack-grep vim

# Node.js
add-apt-repository -y ppa:chris-lea/node.js
apt-get update && apt-get install -y nodejs

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Apache connfigurations and modules.
echo "> Apache config."
cp /vagrant/_install/apache-vhost.txt /etc/apache2/sites-available/default
a2enmod vhost_alias
a2enmod rewrite
a2enmod headers
service apache2 restart

echo "> All done!"
echo "> *** You SHOULD run: vagrant reload"
