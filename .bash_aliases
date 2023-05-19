# Print my IPAs
alias myip='curl ipinfo.io/ip && printf "\n"'
alias wlan_ip="ifconfig wlp0s20f3 | awk '/inet / {print \$2;}'"

# ROS
alias srcdev='source ./devel/setup.bash'
function rosmasterexport() {
  export ROS_MASTER_URI=http://$1:11311
}
alias rosgetactionservers='rostopic list | grep -o -P "^.*(?=/feedback)"'

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

function rm_docker_dangling_images() {
  docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
}

# Shortcuts
alias xcopy="xclip -selection clipboard"

alias lsdu="ls | xargs du -sh"

aias gource_viz="gource -a 0.01 -s 0.001 --max-files 0"

alias wifi_str="sudo watch -n1 iwconfig"

function loop_video() {
  mplayer -fs -loop 0 $1
}

alias tmuxattach="tmux attach"
