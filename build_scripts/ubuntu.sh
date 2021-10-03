#!/bin/bash


WORKDIR=$(pwd)/opentrack_workspace
DEPS="build-essential cmake cmake-curses-gui qttools5-dev qtbase5-private-dev libprocps-dev libopencv-dev libevdev-dev gcc-multilib g++-multilib wine-stable wine32-development wine32-tools wine32-development-tools libqt5serialport5-dev"

sudo apt-get update && apt-get upgrade -y
sudo apt-get install -y $DEPS

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
