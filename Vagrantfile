# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/25-cloud-base"

  config.vm.network "forwarded_port", guest: 5901, host: 6901

  config.vm.provision :shell, :inline <<-END
      if [ "X#{ENV['NFS_SERVER']" != "X" ]; then
          echo "#{ENV['NFS_SERVER']}:/export/3d-projects /mnt/3d-projects nfs defaults 0 0" >> /etc/fstab
      fi
  END

  config.vm.provision :shell, :path => 'provision.sh'
end
