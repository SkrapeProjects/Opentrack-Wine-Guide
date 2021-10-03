#!/bin/bash


WORKDIR=$(pwd)/opentrack_workspace
DEPS="qt5-qtbase-private-devel qt5-qttools-devel procps-ng-devel opencv-devel libevdev-devel qt5-qtserialport-devel make cmake unzip gcc g++ glibc-devel.i686 libstdc++-devel.i686 wine wine-devel.i686"

sudo dnf upgrade -y
sudo dnf install -y $DEPS

mkdir -p $WORKDIR
cd $WORKDIR

wget -O source.zip $(curl -s https://api.github.com/repos/opentrack/opentrack/releases/latest | grep zipball_url | cut -d '"' -f 4)
unzip source.zip
mv $(ls | grep opentrack) source

mkdir -p build
sleep 1
cd build
cmake ../source -DSDK_WINE:BOOL=ON -DCMAKE_INSTALL_PREFIX:PATH=/home/$USER/.local
make install -j$(nproc)
