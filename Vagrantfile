# -*- mode: ruby -*-
# vi: set ft=ruby :

nfs=ENV['NFS_SERVER']
puts "NFS Server: '#{nfs}'"

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/25-cloud-base"

  config.vm.network "forwarded_port", guest: 5901, host: 6901

  config.vm.provision :shell, :inline => <<-SCRIPT
      if [ "X#{nfs}" != "X" ]; then
          echo "#{nfs}:/export/3d-projects /mnt/3d-projects nfs defaults 0 0" >> /etc/fstab
      fi
  SCRIPT

  config.vm.provision :shell, :path => 'provision.sh'
end
