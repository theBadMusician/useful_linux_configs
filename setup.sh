#! /bin/bash

# Install tmux and git
sudo apt install tmux git

# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Get configs
git clone https://github.com/thebadmusician/useful_linux_configs ~/useful_linux_configs

# Install configs
cat ~/useful_linux_configs/.bashrc > ~/.bashrc
cat ~/useful_linux_configs/.bash_aliases > ~/.bash_aliases
cat ~/useful_linux_configs/.tmux.conf > ~/.tmux.conf

# Source bashrc
. ~/.bashrc

# Source in tmux
tmux source ~/.tmux.conf

# Install ROS noetic
wget -c https://raw.githubusercontent.com/qboticslabs/ros_install_noetic/master/ros_install_noetic.sh && chmod +x ./ros_install_noetic.sh && ./ros_install_noetic.sh
