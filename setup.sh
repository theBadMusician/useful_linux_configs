#! /bin/bash

# Software that needs to be installed manually:
# Matlab
# Chromium
# Foxglove

# Install packages
sudo apt update
sudo apt install -y --upgrade  baobab ca-certificates net-tools cython3 curl doxygen dpkg-dev gnupg googletest hostname htop iputils-ping iputils-tracepath openssh-client openssh-server perl pulseaudio udev vim wget simplescreenrecorder nmap xclip
# Optional: audacity gnome-tweaks

# Install tmux and git
sudo apt install -y --upgrade tmux git

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

# Install ROS2 Jazzy
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale  # verify settings

sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update && sudo apt install ros-dev-tools

sudo apt update && sudo apt upgrade
sudo apt install ros-jazzy-desktop
source /opt/ros/jazzy/setup.bash

# Install ROS plotjuggler
sudo apt install -y --upgrade ros-$ROS_DISTRO-plotjuggler-ros

# Install VS Code
sudo apt-get install -y --upgrade wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders

# Install Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
sudo apt install fzf

# Install neovim
sudo apt install neovim ripgrep fd-find # For Ubuntu/Debian

## Install Docker
#sudo apt-get update
#sudo apt-get install -y --upgrade ca-certificates curl gnupg
#sudo install -m 0755 -d /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#sudo chmod a+r /etc/apt/keyrings/docker.gpg
#
#echo \
#  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#
#sudo apt-get update
#sudo apt-get install -y --upgrade docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
## Verify that docker is installed
#sudo docker run hello-world
