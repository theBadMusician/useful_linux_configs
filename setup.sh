#! /bin/bash

# Software that needs to be installed manually:
# Matlab
# Chromium
# Foxglove

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting system configuration..."

# Update and install all base packages
sudo apt update
sudo apt install -y --upgrade \
  baobab ca-certificates net-tools cython3 curl doxygen dpkg-dev gnupg \
  googletest hostname htop iputils-ping iputils-tracepath openssh-client \
  openssh-server perl pulseaudio udev vim wget simplescreenrecorder \
  nmap xclip tmux git locales software-properties-common apt-transport-https
# Optional: audacity gnome-tweaks

# Install TPM (Tmux Plugin Manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Cloning TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "TPM already installed. Skipping..."
fi

# 3. Fetch and setup configs
if [ ! -d "$HOME/useful_linux_configs" ]; then
  echo "Cloning configurations..."
  git clone https://github.com/thebadmusician/useful_linux_configs ~/useful_linux_configs
else
  echo "Configurations repo already exists. Pulling latest..."
  git -C ~/useful_linux_configs pull
fi

# Install configs
cat ~/useful_linux_configs/.bashrc > ~/.bashrc
cat ~/useful_linux_configs/.bash_aliases > ~/.bash_aliases
cat ~/useful_linux_configs/.tmux.conf > ~/.tmux.conf

# Source bashrc
. ~/.bashrc

# Source in tmux
tmux source ~/.tmux.conf

# Install ROS2 Jazzy
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

sudo add-apt-repository universe -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update
sudo apt install -y ros-dev-tools ros-jazzy-desktop

# Install ROS plotjuggler
sudo apt install -y --upgrade ros-jazzy-plotjuggler-ros

# Install VS Code
sudo apt-get install -y --upgrade wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt update
sudo apt install -y code # or code-insiders

# Install Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
sudo apt install -y fzf

# Install Neovim, LaTeX, and Python tools
sudo apt install -y neovim ripgrep fd-find zip
sudo apt install -y zathura zathura-pdf-poppler texlab xdotool texlive-full # texlive-base
sudo apt install -y python3-pip python3-venv

echo "----------------------------------------"
echo "Setup complete! Please run 'source ~/.bashrc' or restart your terminal."
echo "If tmux is running, you can apply changes by running 'tmux source ~/.tmux.conf'."

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
