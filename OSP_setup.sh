#! /bin/bash

# Prerequisites:
# pyenv
# doxygen

# Set up python version 3.9 according to instructions here: https://github.com/thebadmusician/useful_linux_configs#install-multiple-python-versions-on-a-linux-machine
# Set it as local for OSP folder

sudo apt update

mkdir OSP && cd OSP && pyenv local 3.9

python3 -m pip install --upgrade pip && python3 -m pip install conan==1.60

conan remote add osp https://osp.jfrog.io/artifactory/api/conan/conan-local

git clone --recursive https://github.com/open-simulation-platform/libcosim
git clone --recursive https://github.com/open-simulation-platform/libcosimc
git clone --recursive https://github.com/open-simulation-platform/libcosimpy

# libcosim

cd libcosim && mkdir build && cd build

conan install .. --build=missing --settings build_type=Debug --settings compiler.libcxx=libstdc++11 -o proxyfmu=True
cmake .. -DLIBCOSIM_USING_CONAN=TRUE -DLIBCOSIM_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Debug
cmake --build .
sudo make install

# libcosimc

cd ../.. && cd libcosimc && mkdir build && cd build
conan install ..  -o libcosim:'proxyfmu=True' --build=missing --settings build_type=Debug --settings compiler.libcxx=libstdc++11
cmake .. -DLIBCOSIMC_USING_CONAN=TRUE -DLIBCOSIM_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Debug
cmake --build .
sudo make install

# libcosimpy

cd ../.. && cd libcosimpy && cd conan/
conan lock create conanfile.py -s build_type=Debug -s compiler.libcxx=libstdc++11
mv conan.lock conan-linux64.lock
python3 -m pip install ..

# When building catkin workspace: pip uninstall em && pip install empy 
