#! /bin/bash

# Prerequisites:
# pyenv
# doxygen

# Set up python version 3.10.12 according to instructions here: https://github.com/thebadmusician/useful_linux_configs#install-multiple-python-versions-on-a-linux-machine
# Set it as local for OSP folder

sudo apt update

mkdir OSP && cd OSP && pyenv local 3.10.12

$HOME/.pyenv/versions/3.10.12/bin/python -m pip install --upgrade pip && $HOME/.pyenv/versions/3.10.12/bin/python -m pip install conan==1.60

$HOME/.pyenv/versions/3.10.12/bin/conan remote add osp https://osp.jfrog.io/artifactory/api/conan/conan-local

git clone --recursive https://github.com/open-simulation-platform/libcosim
git clone --recursive https://github.com/open-simulation-platform/libcosimc
git clone --recursive https://github.com/open-simulation-platform/libcosimpy

# libcosim

cd libcosim && mkdir build && cd build

$HOME/.pyenv/versions/3.10.12/bin/conan install .. --build=missing --settings build_type=Debug --settings compiler.libcxx=libstdc++11 -o proxyfmu=True
cmake .. -DLIBCOSIM_USING_CONAN=TRUE -DLIBCOSIM_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Debug
cmake --build .
sudo make install

# libcosimc

cd ../.. && cd libcosimc && mkdir build && cd build
$HOME/.pyenv/versions/3.10.12/bin/conan install ..  -o libcosim:'proxyfmu=True' --build=missing --settings build_type=Debug --settings compiler.libcxx=libstdc++11
cmake .. -DLIBCOSIMC_USING_CONAN=TRUE -DLIBCOSIM_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Debug
cmake --build .
sudo make install

# libcosimpy

cd ../.. && cd libcosimpy && cd conan/
$HOME/.pyenv/versions/3.10.12/bin/conan lock create conanfile.py -s build_type=Debug -s compiler.libcxx=libstdc++11
mv conan.lock conan-linux64.lock
$HOME/.pyenv/versions/3.10.12/bin/python -m pip install ..

# To build catkin workspace: pip uninstall em && pip install empy
# To run python program: printf "export PYTHONPATH=$PYTHONPATH:~/.pyenv/versions/3.10.12/lib/python3.10/site-packages" >> ~/.bashrc && sudo pip install --target=/opt/ros/noetic/lib/python3/dist-packages rospkg
