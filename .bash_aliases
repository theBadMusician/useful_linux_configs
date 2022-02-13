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
