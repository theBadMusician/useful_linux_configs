#! /bin/bash

# Software that needs to be installed manually:
# Matlab
# Chromium
# Foxglove

# Install packages
sudo apt update
sudo apt install -y --upgrade azure-cli baobab ca-certificates net-tools cython3 gnome-tweaks dkms curl doxygen dpkg-dev dpkg firefox gnupg googletest hostname htop iputils-ping iputils-ping iputils-tracepath openconnect openssh-client openssh-server perl pulseaudio udev vim wget simplescreenrecorder trash-cli nmap 
# Optional: audacity

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

# Install ROS noetic
wget -c https://raw.githubusercontent.com/qboticslabs/ros_install_noetic/master/ros_install_noetic.sh && chmod +x ./ros_install_noetic.sh && ./ros_install_noetic.sh && . ~/.bashrc

# Install ROS plotjuggler
sudo apt install -y --upgrade ros-$ROS_DISTRO-plotjuggler-ros

# Install pyenv
sudo apt-get install -y --upgrade build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash && pyenv install 3.10 && pyenv global 3.10 && pyenv shell 3.10

# Install VS Code
sudo apt-get install -y --upgrade wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders

# Install Docker
sudo apt-get update
sudo apt-get install -y --upgrade ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Same line
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y --upgrade docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Verify that docker is installed
sudo docker run hello-world
