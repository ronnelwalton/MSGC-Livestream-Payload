#!/bin/bash
./gstreamer_install.sh

echo "Enabling Camera, SSH, and I2C"

sudo sed -i -e '$astart_x=1' /boot/config.txt
sudo sed -i -e '$agpu_mem=256' /boot/config.txt

sudo systemctl enable ssh
sudo systemctl start ssh

sudo raspi-config nonint do_i2c 0

echo "Disabling WiFi and Bluetooth"

sudo sed -i -e '$adtoverlay=disable-wifi' /boot/config.txt
sudo sed -i -e '$adtoverlay=disable-bt' /boot/config.txt

echo "Setting Static IP (192.168.2.101)"

sudo sed -i -e '$ainterface eth0' /etc/dhcpcd.conf
sudo sed -i -e '$astatic routers=192.168.2.1' /etc/dhcpcd.conf
sudo sed -i -e '$astatic domain_name_servers=255.255.255.0' /etc/dhcpcd.conf
sudo sed -i -e '$astatic ip_address=192.168.2.101' /etc/dhcpcd.conf
sudo sed -i -e '$astatic domain_search=' /etc/dhcpcd.conf

echo "Importing and installing service files"

mkdir ~/BOREALIS_Cam
sudo cp BOREALIS_CAM.service ~/BOREALIS_Cam
sudo cp BOREALIS_CAM_SAVE.service ~/BOREALIS_Cam
sudo cp save_stream.sh ~/BOREALIS_Cam
sudo cp test-launch ~/BOREALIS_Cam
cd ~/BOREALIS_Cam

sudo cp BOREALIS_CAM.service /etc/systemd/system/
sudo cp BOREALIS_CAM_SAVE.service /etc/systemd/system/

sudo systemctl daemon-reload

sudo systemctl enable BOREALIS_CAM.service
sudo systemctl enable BOREALIS_CAM_SAVE.service


echo "Finished Setup"
echo "Restarting"

sudo reboot
