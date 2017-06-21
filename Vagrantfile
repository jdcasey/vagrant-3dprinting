# -*- mode: ruby -*-
# vi: set ft=ruby :

nfs=ENV['NFS_SERVER']
puts "NFS Server: '#{nfs}'"

bridge=ENV['VAGRANT_BRIDGE']
puts "Bridge device: '#{bridge}"

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/25-cloud-base"

  if bridge != ''
  	config.vm.network "public_network", bridge: bridge, adapter: 1
  end
  config.vm.network "forwarded_port", guest: 5901, host: 6901

  config.vm.provision :shell, :inline => <<-SCRIPT
      if [ "X#{nfs}" != "X" ]; then
          echo "#{nfs}:/export/3d-projects /mnt/3d-projects nfs defaults 0 0" >> /etc/fstab
      fi
  SCRIPT

  config.vm.provision :shell, :path => 'provision.sh'
end
