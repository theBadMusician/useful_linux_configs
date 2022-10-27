# Change ROS IP addresses to one of the network devices 
rosip_configurator() {

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

# Get network info using ifconfig, discard loopback, regex 'flags' (only present in the
# device line), split at ':', and print the devices. Replace newlines with spaces for usability.
IFCONFIG=$(ifconfig)

DEVS=$( printf "$IFCONFIG" | awk '/lo: / {next} /flags/ {split($0, a, ":");print a[1]}' | tr '\n' ' ')
NUM_DEVS=$( eval "echo \$DEVS" | awk 'BEGIN {FS=" "} {print NF}' )
ADDRESSES=$( printf "$IFCONFIG" | awk '/lo: / {next} /flags/ {getline; print $2;}' | tr '\n' ' ')
# IP_ADDRESSES=$( printf "$IFCONFIG" | awk "/lo: / {next} /inet / {print \$2;}" )

IFS=' ' read -a DEVICE_ARRAY <<< "$DEVS"
IFS=' ' read -a ADDRESS_ARRAY <<< "$ADDRESSES"

STR=$(printf "not-available")

OPTIONS=()
i=1
while [ "$i" -le "$NUM_DEVS" ]; do
    arr_idx=$(($i - 1))
    #echo "${ADDRESS_ARRAY[$arr_idx]}"

    if [[ "${ADDRESS_ARRAY[$arr_idx]}" == *":"* ]]; then
        ADDRESS_ARRAY[$arr_idx]="$STR"
    fi
    tmp_dev_name="${DEVICE_ARRAY[$arr_idx]}"
    str_len=$((20 - ${#tmp_dev_name}))
    padding=$(printf "%-${str_len}s" "*")
    padding=$(echo "${padding// /*}")
    tmp_addr_name="${ADDRESS_ARRAY[$arr_idx]}"
    tmp_option_str=$( printf "$tmp_dev_name$padding($tmp_addr_name)" )
    # echo "$tmp_option_str"
    OPTIONS+=($tmp_option_str)

    i=$(($i + 1))
done
OPTIONS+=("QUIT")

OPTIONS_STR=$(echo "${OPTIONS[@]}" | tr ' ' ',' | tr '*' ' ' | tr '-' ' ')
IFS=',' read -a OPTIONS_NL <<< "$OPTIONS_STR"


# Prompt the user to select one of the lines.
echo "Select network device for ROS IPa:"
COLUMNS=0
select choice in "${OPTIONS_NL[@]}"; do
  [ -n "$choice" ] || { printf "${YELLOW}Invalid choice. Please try again. $ENDCOLOR \n" >&2; continue; }
  break # valid choice was made; exit prompt.
done

if [ "$choice" = "QUIT" ]
then
    printf "$YELLOW\nThank you for using 'The Ultimate ROS IP Selector 9000' by BenG.\nGood Bye.\n\n$ENDCOLOR"
    return
fi

read -r DEV <<< "$choice"
DEV=$( printf "$DEV" | awk '{split($0, a, " ");print a[1]}' )
# echo "Network Device: $DEV"

# # Split the chosen line into ID and serial number.
# #read -r id sn unused <<<"$choice"
# #echo "id: [$id]; s/n: [$sn]"

IPA=$( ifconfig $DEV | awk "/inet / {print \$2;}" )
# echo $IPA

if [ -z $IPA ]
then
    printf "$RED\nThe network device '$DEV' is not connected or does not have a valid inet address.\n\n$ENDCOLOR"
    return
else
    export ROS_IP=$IPA
    export ROS_HOSTNAME=$IPA

    printf "$GREEN\nROS_IP and ROS_HOSTNAME has been set to '$ROS_IP' on the device '$DEV'.\n\n$ENDCOLOR"
    return
fi
}
