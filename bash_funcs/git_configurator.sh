git_configurator() {
   # By BenG @ Vortex NTNU, 2022
   DEFAULT=default

   RED="\e[31m"
   GREEN="\e[32m"
   YELLOW="\e[33m"
   ENDCOLOR="\e[0m"
   
   if [ -z "$1" ]
   then
     printf "${RED}Parameter #1 is zero length. Returning. ${ENDCOLOR}\n"
     return
   elif [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ "$1" = "help" ]
   then
     printf "Global Git configurator for changing the name and email address of the current user. \n"
     printf "Arg #1: user name\n"
     printf "Arg #2: (default=previous) user email\n"
     return
   elif [ "$1" = "default" ] 
    then
     git config --global user.name Stormtrooper-PC
     git config --global user.email trooper@theEmpire.com
     printf "${GREEN}Global git user name changed to: Stormtrooper-PC${ENDCOLOR}\n"
     printf "${GREEN}Global git user email changed to: trooper@theEmpire.com${ENDCOLOR}\n"
     return
   else
     #USERNAME="$1"
     #USERNAME=${1-$DEFAULT}
    git config --global user.name "${1-$DEFAULT}"
    printf "${GREEN}Global git user name changed to: ${1-$DEFAULT}${ENDCOLOR}\n"
   fi

   if [ "$2" ]
   then
     git config --global user.email "${2-$DEFAULT}"
     printf "${GREEN}Global git user email changed to: ${2-$DEFAULT}${ENDCOLOR}\n"
   else
     CURRENT_EMAIL=$( cat ~/.gitconfig | tail -n +1 | awk -F' = ' '{ print $2 }' | tail -2 | head -1)
     printf "${YELLOW}Global git user email is left unchanged: ${CURRENT_EMAIL}${ENDCOLOR}\n"
   fi

   return 0
}
