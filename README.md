# Ultimate PHP developer setup with Vagrant

> This repo is deprecated, you should be using this one: https://github.com/milhouse1337/vagrant-lemp

---

By Pascal Meunier [@milhouse1337](https://twitter.com/milhouse1337)  
Version: 1.0

This setup script will automate the setup of a PHP developement box. It includes all the following:

- Ubuntu 12.04 LTS
- Apache 2.2 configured using wildcard alias for vhosts.
- PHP 5.4 (configurable)
- MySQL 5.5
- Memcached (daemon and module)
- PHP Modules: php5-mysql php5-curl php5-gd php5-mcrypt php5-memcached
- Utilities: vim subversion git-core curl screen ack-grep
- Composer
- Node.js

## Requirements

- OSX (Windows and Linux are possible but not covered here)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](http://www.vagrantup.com/)
- [Brew](http://brew.sh/) (optionnal but recommended)

## Install

We will be cloning the following Git repo in a folder called **Vagrant** in your home directory. 

	git clone https://github.com/milhouse1337/vagrant-setup-lamp.git ~/Vagrant
	cd ~/Vagrant
	rm -rf .git ## Remove .git folder

Finally we remove the .git folder because this folder will become your dev root and there should be no .git folder a this level.

Now you can open the following files and make sure they fit your desired configuration. For example the timezone, the MySQL root password and vhost might have to change based on your needs. 

	~/Vagrant/_install/bootstrap.sh
	~/Vagrant/_install/apache-vhost.sh

Install one simple and usefull plugin and boot it! This will ensure you have the correct VirtualBox Gest Additions tools for you kernel version (automatically).

	vagrant plugin install vagrant-vbguest
	vagrant up

Coffee time! You might have to wait a few minutes for the install to complete. When you see "All done!" you can now restart your freshly installed box and login to it using:

	vargant reload ## To reboot.
	vagrant ssh ## To login.

You now have a complete setup with wildcard vhost to play with.

### Test your setup

Create the following folder and php file: 

	mkdir ~/Vagrant/test.127.0.0.1.xip.io
	echo "<?php phpinfo(); ?>" > ~/Vagrant/test.127.0.0.1.xip.io/index.php

Browse to the following URL:

[http://test.127.0.0.1.xip.io](http://test.127.0.0.1.xip.io)  

*You might need to install the port forward service below and reboot to make it work.

Yes this is magic :) We are using vhost_alias module here to handle the wildcard host. Also xip.io is a free service that resolove any IP based on DNS request, pretty cleaver and simple. Thank you 37signals for this, that solved at least a few configurations!

You might want to configure your own wildcard DNS (*.example.com) if you prefer and/or integrate it with your internal DNS network.

## Vagrant cheat sheet

	vagrant up ## Boot the VM. (install if not already present)
	vagrant ssh ## Login on the VM as user "vagrant".
	vagrant reload ## Reboot the VM.
	vagrant destroy ## Delete the VM.

## Vagrant Guest plugin (must to have)

Using this plugin will ensure your VM always have the latest Guest Addition Tools installed and ready.

	vagrant plugin install vagrant-vbguest

## OSX port forward as a service

You must be sure it's using the right folder here.

	sudo cp ~/Vagrant/_tools/osx/org.aeris.ipfw.plist /Library/LaunchDaemons/org.aeris.ipfw.plist
	sudo cp ~/Vagrant/_tools/osx/ipfw.conf /etc/ipfw.conf
	sudo launchctl load -w /Library/LaunchDaemons/org.aeris.ipfw.plist
	
Now reboot for the changes to take effect.

## Brew (package manager) for OSX

[http://brew.sh/](http://brew.sh/)

	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	brew install wget
	brew install tig

### PHP and Composer on OSX

	brew tap homebrew/dupes
	brew tap homebrew/versions
	brew tap josegonzalez/homebrew-php

#### PHP 5.3 (old-stable)

	brew install php53 php53-mcrypt

#### PHP 5.4 (old-stable)

	brew install php54 php54-mcrypt

#### PHP 5.5 (stable)

	brew install php55 php55-mcrypt

#### Composer

	brew install josegonzalez/php/composer

