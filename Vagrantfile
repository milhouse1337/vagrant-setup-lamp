# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # == Provisioning ==
  config.vm.provision :shell, :path => "_install/bootstrap.sh"

  # == Network ==
  # http://www.dmuth.org/node/1404/web-development-port-80-and-443-vagrant
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443
  config.vm.network "forwarded_port", guest: 3306, host: 3306

  # Forward for Node.js on port 3000
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # == Fix for sync folder (added twice with owner as www-data) ==
  config.vm.synced_folder ".", "/var/www", id: "vagrant-www", :owner => "www-data", :group => "www-data"

  # == Misc configuration for the VM (uncomment if needed) ==
  config.vm.provider "virtualbox" do |v|
    # v.memory = 512
    # v.cpus = 2
  end

end
