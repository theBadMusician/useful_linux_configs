#! /bin/bash

# Software that needs to be installed manually:
# Matlab
# Chromium
# Foxglove

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting system configuration..."

# Ask if the user wants to overwrite existing configs (default: no)
read -p "Do you want to overwrite existing configs? (y/n) " overwrite_configs

# Ask if the user wants to install ROSn (default: no)
read -p "Do you want to install ROS2 Jazzy? (y/n) " install_ros

# Ask if the user wants to install vscode
read -p "Do you want to install Visual Studio Code? (y/n) " install_vscode

# Ask if the user wants to install texlive-full (for LaTeX editing)
read -p "Do you want to install texlive-full (for LaTeX editing)? (y/n) " install_texlive

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

# Fetch and setup configs
if [ ! -d "$HOME/useful_linux_configs" ]; then
  echo "Cloning configurations..."
  git clone https://github.com/thebadmusician/useful_linux_configs ~/useful_linux_configs
else
  echo "Configurations repo already exists. Pulling latest..."
  git -C ~/useful_linux_configs pull
fi

# Install configs
if [ "$overwrite_configs" == "y" ]; then
  echo "Backing up existing configs..."
  cp ~/.bashrc ~/.bashrc.bak || true
  cp ~/.bash_aliases ~/.bash_aliases.bak || true
  cp ~/.tmux.conf ~/.tmux.conf.bak || true

  echo "Overwriting existing configs..."
  cat ~/useful_linux_configs/.bashrc > ~/.bashrc
  cat ~/useful_linux_configs/.bash_aliases > ~/.bash_aliases
  cat ~/useful_linux_configs/.tmux.conf > ~/.tmux.conf
fi

# Source bashrc
. ~/.bashrc

# Source in tmux
tmux source ~/.tmux.conf

# Install ROS2 Jazzy
if [ "$install_ros" == "y" ]; then
  echo "ROS2 installation..."

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
fi


# Install VS Code
if [ "$install_vscode" == "y" ]; then
  echo "Visual Studio Code installation..."

  sudo apt-get install -y --upgrade wget gpg
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg

  sudo apt update
  sudo apt install -y code # or code-insiders
fi

# Install Python tools
sudo apt install -y python3-pip python3-venv

# Install Zoxide
# curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
sudo apt update
sudo apt install -y zoxide fzf

# Install Neovim and some useful tools
sudo apt install -y neovim ripgrep fd-find zip

# Install Zathura and Texlab for PDF viewing and LaTeX editing
if [ "$install_texlive" == "y" ]; then
  echo "Installing texlive-full..."
  sudo apt install -y zathura zathura-pdf-poppler xdotool texlive-full # texlive-base # texlab 

  mkdir -p ~/.config/zathura
  cat ~/useful_linux_configs/.config/zathura/zathurarc > ~/.config/zathura/zathurarc
  cat ~/useful_linux_configs/.latexmkrc > ~/.latexmkrc
fi

# End of script
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
