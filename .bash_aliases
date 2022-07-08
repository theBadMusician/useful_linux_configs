# Print my IPAs
alias myip='curl ipinfo.io/ip && printf "\n"'
alias wlan_ip="ifconfig wlp0s20f3 | awk '/inet / {print \$2;}'"

# Quick source local ROS ws setup
alias srcdev='source ./devel/setup.bash'

# ROS master node setups
alias rosmastertrooper='export ROS_MASTER_URI=http://129.241.187.21:11311'

# SSH shortcuts
alias sshtrooper="ssh vortex@Stormtrooper-PC -X"

# Git update branches
alias git_branch_update="git remote update origin --prune"

# Shortcut
alias unzip="tar -xvzf"

# Other
alias gotovortex="cd ~/projects/vortex/vortex_ws/src"
alias gotozed="cd ~/projects/vortex/zed_ws/src"
alias nmap_mac="nmap_mac() {sudo nmap -sP "$1"/24 | awk '/Nmap scan report for/{printf $5;}/MAC Address:/{print ' => '$3;}' | sort;}"


# NVIDIA Utils
alias cgpu="watch -d -n 0.5 nvidia-smi"

# Docker
alias rm_docker_conts="sudo docker ps -a | awk ' NR>1 { print \$1 } ' | sudo xargs docker stop && sudo docker ps -a | awk ' NR>1 { print \$1 } ' | sudo xargs docker rm"
alias dompose="sudo docker-compose"
alias dps="sudo docker ps -a"

function dexec() {
  sudo docker exec -it $1 /bin/bash
}

# Shortcuts
alias xcopy="xclip -selection clipboard"
alias lsdu="ls | xargs du -sh"

