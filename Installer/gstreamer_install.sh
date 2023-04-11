#!/bin/bash
echo "Installing GSTREAMER-1.18.4"

sudo apt-get install -y libx264-dev libjpeg-dev
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-ugly gstreamer1.0-tools
sudo apt-get install -y gstreamer1.0-gl gstreamer1.0-gtk3
sudo apt-get install -y libjpeg-dev
sudo apt-get install -y librtmp-dev
sudo apt-get install -y libvo-aacenc-dev
sudo apt-get install -y libx264-dev
sudo apt-get install -y cmake meson flex bison
sudo apt-get install -y libglib2.0-dev libjpeg-dev libx264-dev
sudo apt-get install -y libgtk2.0-dev libcanberra-gtk* libgtk-3-dev

sudo rm -rf /usr/bin/gst-*
sudo rm -rf /usr/include/gstreamer-1.0


mkdir ~/GStreamer
cd ~/GStreamer
mkdir downloads
mkdir installation
cd downloads
wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.18.4.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.18.4.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.18.4.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.18.4.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-1.18.4.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-omx/gst-omx-1.18.4.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-rtsp-server/gst-rtsp-server-1.18.4.tar.xz

cd ~/GStreamer/installation

sudo tar -xf ~/GStreamer/downloads/gstreamer-1.18.4.tar.xz
sudo tar -xf ~/GStreamer/downloads/gst-plugins-base-1.18.4.tar.xz
sudo tar -xf ~/GStreamer/downloads/gst-plugins-good-1.18.4.tar.xz
sudo tar -xf ~/GStreamer/downloads/gst-plugins-bad-1.18.4.tar.xz
sudo tar -xf ~/GStreamer/downloads/gst-plugins-ugly-1.18.4.tar.xz
sudo tar -xf ~/GStreamer/downloads/gst-omx-1.18.4.tar.xz
sudo tar -xf ~/GStreamer/downloads/gst-rtsp-server-1.18.4.tar.xz


cd ~/GStreamer/installation/gstreamer-1.18.4
mkdir build && cd build
meson --prefix=/usr       \
        --wrap-mode=nofallback \
        -D buildtype=release \
        -D gst_debug=false   \
        -D package-origin=https://gstreamer.freedesktop.org/src/gstreamer/ \
        -D package-name="GStreamer 1.18.4 BLFS" ..

ninja -j4
sudo ninja install
sudo ldconfig


cd ~/GStreamer/installation/gst-plugins-base-1.18.4
mkdir build && cd build
meson --prefix=/usr \
-D buildtype=release \
-D package-origin=https://gstreamer.freedesktop.org/src/gstreamer/ ..
ninja -j4
sudo ninja install
sudo ldconfig


cd ~/GStreamer/installation/gst-plugins-good-1.18.4
mkdir build && cd build
meson --prefix=/usr       \
       -D buildtype=release \
       -D package-origin=https://gstreamer.freedesktop.org/src/gstreamer/ \
       -D package-name="GStreamer 1.18.4 BLFS" ..
ninja -j4
sudo ninja install
sudo ldconfig

cd ~/GStreamer/installation/gst-plugins-bad-1.18.4
mkdir build && cd build

meson --prefix=/usr       \
       -D buildtype=release \
       -D package-origin=https://gstreamer.freedesktop.org/src/gstreamer/ \
       -D package-name="GStreamer 1.18.4 BLFS" ..

ninja -j4

sudo ninja install
sudo ldconfig


cd ~/GStreamer/installation/gst-plugins-ugly-1.18.4
mkdir build && cd build
meson --prefix=/usr       \
      -D buildtype=release \
      -D package-origin=https://gstreamer.freedesktop.org/src/gstreamer/ \
      -D package-name="GStreamer 1.18.4 BLFS" ..
ninja -j4
sudo ninja install
sudo ldconfig


cd ~/GStreamer/installation/gst-omx-1.18.4
mkdir build && cd build
meson --prefix=/usr       \
       -D header_path=/opt/vc/include/IL \
       -D target=rpi \
       -D buildtype=release ..
ninja -j4
sudo ninja install
sudo ldconfig


cd ~/GStreamer/installation/gst-rtsp-server-1.18.4
mkdir build && cd build
meson --prefix=/usr       \
       --wrap-mode=nofallback \
       -D buildtype=release \
       -D package-origin=https://gstreamer.freedesktop.org/src/gstreamer/ \
       -D package-name="GStreamer 1.18.4 BLFS" ..
ninja -j4
sudo ninja install
sudo ldconfig

echo "Finished Installing GStreamer"
