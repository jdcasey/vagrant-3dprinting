#!/bin/bash

set -x
dnf clean all
dnf -y --setopt=deltarpm=false update
dnf -y --setopt=deltarpm=false install @xfce-desktop-environment firefox freecad slic3r openscad tigervnc-server

semodule -X 300 -i /vagrant/vnc.pp

cp /vagrant/*.service /etc/systemd/system

systemctl daemon-reload

cp -rf /vagrant/vnc-config /home/vagrant/.vnc
chown -R vagrant:vagrant /home/vagrant/

usermod vagrant -a -G wheel 
echo 'vagrant' | passwd --stdin vagrant
echo 'vagrant' | vncpasswd -f > /home/vagrant/.vnc/passwd

systemctl enable vncserver@:1
systemctl start vncserver@:1

