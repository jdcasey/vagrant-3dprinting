#!/bin/bash

set -x
dnf clean all
dnf -y --setopt=deltarpm=false update
dnf -y --setopt=deltarpm=false install @xfce-desktop-environment firefox freecad slic3r openscad tigervnc-server

semodule -X 300 -i /vagrant/vnc.pp

cp /vagrant/*.service /etc/systemd/system

systemctl daemon-reload

echo 'vagrant' | passwd --stdin jdcasey

cp -rf /vagrant/vnc-config /home/jdcasey/.vnc
chmod 700 /home/jdcasey/.vnc
chmod 600 /home/jdcasey/.vnc/*
chown -R jdcasey:jdcasey /home/jdcasey/

systemctl enable vncserver@:1
systemctl start vncserver@:1

