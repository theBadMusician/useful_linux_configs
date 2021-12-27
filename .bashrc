# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# CUSTOM GIT BRANCH TERMINAL LINE
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\] $(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi
# THE SIX LINES BELOW are the default prompt and the unset (which were in the original .bashrc)
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# WLAN IPA check
#wlan_ip(){ ifconfig wlp0s20f3  | awk '/inet / {print \$2}'; }

# ROS sources
source /opt/ros/melodic/setup.bash
source ~/projects/vortex/vortex_ws/devel/setup.bash
#source ~/projects/vortex/zed_ws/devel/setup.bash

# ROS SSH setup
# NTNU Wi-Fi
#export ROS_IP=10.22.229.61
#export ROS_HOSTNAME=10.22.229.61

export ROS_IP=192.168.1.97
export ROS_HOSTNAME=192.168.1.97

ros_conf() {

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

# Get network info using ifconfig, discard loopback, regex 'flags' (only present in the
# device line), split at ':', and print the devices. Replace newlines with spaces for usability.
DEVS=$(ifconfig | awk '/lo: / {next} /flags/ {split($0, a, ":");print a[1]}' | tr '\n' ' ')
#echo $DEVS

#NUM_DEVS=$( eval "echo \$DEVS" | awk 'BEGIN {FS=" "} {print NF}' )
#echo $NUM_DEVS
#printf "\n"

IFS=' ' read -a OPTIONS <<< "$DEVS"
OPTIONS+=("QUIT")
#printf '%s\n' "${OPTIONS[@]}"

# Prompt the user to select one of the lines.
echo "Select network device for ROS IPa:"
select choice in "${OPTIONS[@]}"; do
  [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
  break # valid choice was made; exit prompt.
done

if [ $choice = "QUIT" ]
then
    printf "$YELLOW\nThank you for using 'The Ultimate ROS IP Selector 9000' by BenG.\nGood Bye.\n\n$ENDCOLOR"
    return
fi

read -r DEV <<< "$choice"
#echo "Network Device: $DEV"

# Split the chosen line into ID and serial number.
#read -r id sn unused <<<"$choice"
#echo "id: [$id]; s/n: [$sn]"

IPA=$( ifconfig $DEV | awk "/inet / {print \$2;}" )
#echo $IPA

if [ -z $IPA ]
then
    printf "$RED\nThe network device '$choice' is not connected or does not have a valid inet address.\n\n$ENDCOLOR"
    return
else
    export ROS_IP=$IPA
    export ROS_HOSTNAME=$IPA

    printf "$GREEN\nROS_IP and ROS_HOSTNAME has been set to '$ROS_IP' on the device '$choice'.\n\n$ENDCOLOR"
    return
fi
}

