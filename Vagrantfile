# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/25-cloud-base"

  config.vm.network "forwarded_port", guest: 5901, host: 6901

  config.vm.provision :shell, :path => 'provision.sh'
end
