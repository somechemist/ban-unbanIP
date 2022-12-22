#!/usr/bin/env bash

#####################
#   Justin Powell   #
#   12-21-2022      #
#   Version 1       #
#####################

function helpText(){
    echo
    echo "     ::::$1::::"
    echo
    echo "*--------------------------------------------------------------*"
    echo "*-                                                            -*"
    echo "*-   Simple script to ban or unban valid IPs using iptables   -*"
    echo "*-                                                            -*"
    echo "*-   Usage:                                                   -*"
    echo "*-      bash ban-unban.sh [ACTION] IP                         -*"
    echo "*-                                                            -*"
    echo "*-   Actions Available:                                       -*"
    echo "*-      ban   -- bans the defined IP                          -*"
    echo "*-      unban -- unbans the defined IP                        -*"
    echo "*-      check -- checks if the IP is banned                   -*"
    echo "*-                                                            -*"
    echo "*-   IP must be a valid IPv4 address                          -*"
    echo "*-                                                            -*"
    echo "*-   Written by Justin Powell 12-21-2022                      -*"
    echo "*-                                                            -*"
    echo "*--------------------------------------------------------------*"
    exit
}

function checkBan(){
    iptables -L INPUT -v -n | grep "$1" >/dev/null
    if [ `echo $?` -eq 0 ];
    then
        echo
        echo "$ip is banned!"
        echo
    else
        echo
        echo "$ip is not banned!"
        echo
    fi
    exit
}

function ipTest(){
    ipRegex="((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)[.]){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
    internalIpRegex="^192[.]168[.](25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)[.](25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
    if [[ $ip =~ $ipRegex ]];
    then
        if [[ $ip =~ $internalIpRegex ]];
        then
            case $action in
                "unban" )
                    sudo iptables -D INPUT -s $ip -j DROP
                    checkBan $ip
                    ;;
                "check" )
                    checkBan $ip
                    ;;
                * )
                    helpText "Please do not use this to ban internal IP addresses"
                    ;;
            esac
        fi
    else
        helpText "Invalid IP Address or Format!"
    fi
}

#
# Main
#
# Check Arguments
if [ $# -lt 2 ];
then
    helpText "Too Few Arguments!"
elif [ $# -gt 2 ];
then
    helpText "Too Many Arguments!"
fi
# Assign arguments to variables for readability
action=$1
ip=$2
# Test the IP
ipTest
# Perform the actions
case $action in
    "ban" )
        sudo iptables -A INPUT -s $ip -j DROP
        checkBan $ip
        ;;
    "unban" )
        sudo iptables -D INPUT -s $ip -j DROP
        checkBan $ip
        ;;
    "check" )
        checkBan $ip
        ;;
    *)
        helpText "Invalid Action!"
        ;;
esac
