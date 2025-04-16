# ========[ Networking ]======== #
alias myip='curl ipinfo.io/ip && printf "\n"'
alias wlan_ip="ifconfig wlp0s20f3 | awk '/inet / {print \$2;}'"
alias wifi_str="sudo watch -n1 iwconfig"
alias restart_networking="sudo /etc/init.d/networking restart"

# ========[ ROS ]======== #
alias srcdev='source ./install/setup.bash'

# ========[ SSH shortcuts ]======== #

# ========[ git ]======== #
alias git_branch_update="git remote update origin --prune"
alias git_tree="git log --graph --oneline --decorate"

# ========[ NVIDIA Utils ]======== #
alias cgpu="watch -d -n 1 nvidia-smi"
alias cgpu_intel="sudo intel_gpu_top"

## ========[ Docker ]======== #
#alias rm_docker_conts="sudo docker ps -a | awk ' NR>1 { print \$1 } ' | sudo xargs docker stop && sudo docker ps -a | awk ' NR>1 { print \$1 } ' | sudo xargs docker rm"
#alias dompose="sudo docker-compose"
#alias dps="sudo docker ps -a"

## Dexec with autocomplete functionality
#function dexec() {
#  sudo docker exec -it $1 /bin/bash
#}
#
#function _dexec() {
#    local cur=${COMP_WORDS[COMP_CWORD]}
#    COMPREPLY=( $(compgen -W "$(dps | awk 'NR>1 {print $NF}')" -- $cur) )
#}
#
#complete -F _dexec dexec

## Delete all dangling docker images 
#function rm_docker_dangling_images() {
#  docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
#}

# ========[ Shortcuts ]======== #
alias xcopy="xclip -selection clipboard"
alias lsdu="ls | xargs du -sh"
alias gource_viz="gource -a 0.01 -s 0.001 --max-files 0"
alias unzip="tar -xvzf"
alias tmuxattach="tmux attach"
function loop_video() {
  mplayer -fs -loop 0 $1
}
alias venv_activate="source ./.venv/bin/activate"
alias display_info="inxi -GSaz --vs -za && glxinfo -B"
alias card_info="ls -l /dev/dri/by-path/ && sudo dmesg | grep -i nvidia && ls -l /sys/class/drm/"

# Wake up main screen manually
alias wake_up_mon="xrandr -d :1 --output DP-0 --auto"

# ========[ Quick Setups ]======== #
alias mon_setup="xrandr --output HDMI-0 --auto  --mode 1920x1080 --scale 1.3333x1.333 --pos 0x407 && xrandr --output DP-0 --auto --pos 2560x407 && xrandr --output DP-2 --auto --pos 5120x1024 && xrandr --output DP-4 --auto --pos 5120x0"

# ========[ Other ]======== #
# Create a webcam from rtsp stream
alias rtsp_webcam="sudo modprobe -r v4l2loopback && sudo modprobe v4l2loopback exclusive_caps=1 card_label='RTSP Camera' && sleep 2 && sudo ffmpeg -fflags nobuffer -flags low_delay -strict experimental -rtsp_transport tcp -hwaccel cuda  -i rtsp://admin:395477@10.0.0.16/live/profile.1 -fps_mode passthrough -copyts -vf "format=yuv420p,setrange=tv"  -f v4l2 /dev/video0"

# ========[ Functions ]======== #
# Print conditional dir tree for numbered folders
ntree() {
    local dir="${1:-.}"      # Default to current directory if none provided
    local prefix="${2:-""}"  # Prefix for tree formatting (used in recursion)
    
    # If at top level, print the root directory
    if [[ "$prefix" == "" ]]; then
        echo "."
    fi
    
    # Collect all items (files + folders) inside the current directory
    local all_items=()
    mapfile -t all_items < <(find "$dir" -maxdepth 1 -mindepth 1 | sort)
    local count=${#all_items[@]}
    local i=0
    for ((i = 0; i < count; i++)); do
        local item="${all_items[$i]}"
        local connector="├──"
        local new_prefix="${prefix}│   "

        if [[ $i -eq $((count - 1)) ]]; then
            connector="└──"
            new_prefix="${prefix}    "
        fi
        
        echo "${prefix}${connector} ${item##*/}"
        
        # If this is a numbered directory, go inside it recursively
        if [[ -d "$item" && "$item" =~ /[0-9]+[^/]*$ ]]; then
            # Call recursively with proper parameters
            ntree "$item" "$new_prefix"
            # This will be printed after returning from the recursive call
        fi
    done
    
    # Explicitly return to caller
    return 0
}
