# -*- mode: ruby -*-
# vi: set ft=ruby :

username = ENV['USERNAME'] || 'vagrant'

nfs=ENV['NFS_SERVER']
#puts "NFS Server: '#{nfs}'"

bridge=ENV['VAGRANT_BRIDGE']
#puts "Bridge device: '#{bridge}'"

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/25-cloud-base"

  config.vm.provider :libvirt do |libvirt|
    libvirt.cpus = 4
    libvirt.memory = 4096
  end

  if bridge
  	config.vm.network :public_network,
          :dev => bridge,
          :mode => :bridge
          #:type => :bridge
  end
  config.vm.network "forwarded_port", guest: 5901, host_ip: "0.0.0.0", host: 6901

  if username != 'vagrant'
    config.vm.provision :shell, :inline => <<-SCRIPT
        groupadd #{username}
        useradd -u 1000 -g #{username} -G wheel #{username}
    SCRIPT
  end

  if nfs
    config.vm.provision :shell, :inline => <<-SCRIPT
        dnf -y install nfs-utils

        echo "#{nfs}:/export/3d-projects /home/#{username}/3d-projects nfs defaults 0 0" >> /etc/fstab
        echo "#{nfs}:/export/3d-tools /home/#{username}/3d-tools nfs defaults 0 0" >> /etc/fstab

        mkdir -p /home/#{username}/3d-projects
        mkdir -p /home/#{username}/3d-tools

        chown -R #{username} /home/#{username}/3d-projects
        chown -R #{username} /home/#{username}/3d-tools

        mount /home/#{username}/3d-projects
        mount /home/#{username}/3d-tools

        if [ -d /home/#{username}/3d-tools/Slic3r ]; then
            rm -rf /home/#{username}/.Slic3r
            ln -s /home/#{username}/3d-tools/Slic3r /home/#{username}/.Slic3r
        fi 
    SCRIPT
  end

  config.vm.provision :shell, :inline => <<-SCRIPT
      set -x
      dnf clean all
      dnf -y --setopt=deltarpm=false update
      dnf -y --setopt=deltarpm=false install @xfce-desktop-environment firefox freecad slic3r openscad tigervnc-server

      semodule -X 300 -i /vagrant/vnc.pp

      sed -e 's/<USER>/#{username}/g' /lib/systemd/system/vncserver@.service > /etc/systemd/system/vncserver@:1.service

      systemctl daemon-reload

      echo 'vagrant' | passwd --stdin #{username}

      cp -rf /vagrant/vnc-config /home/#{username}/.vnc
      chmod 700 /home/#{username}/.vnc
      chmod 600 /home/#{username}/.vnc/*
      chmod 700 /home/#{username}/.vnc/xstartup
      chown -R #{username}:#{username} /home/#{username}/

      systemctl enable vncserver@:1
      systemctl start vncserver@:1
  SCRIPT

end

