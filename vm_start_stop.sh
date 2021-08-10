#!/usr/bin/env bash

#  this script will check for hosted VMware Fusion Virtual Machines and provide a menu to start-up or stop the machines.

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/functions.sh"

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/variables.sh"

while [ "$r" = yes ]; do
    read -p "What would you like to do?`echo $'\n>> '`1 to Start a Virtual Machine: <<`echo $'\n>> '`2 to Stop a Virtual Machine: <<`echo $'\n>> '`3 to see what's running: <<`echo $'\n>> '`4 to see all available Virtual Machines: <<`echo $'\n>> '`C to Cancel/Exit: << `echo $'\n> '`" answer
    r=no

case $answer in
    1)
    available_vars
if [ -z "${START_AVAILABLE}" ]; then
    echo -e "There are no Virtual Machines available to Start"
    echo
    r=yes
else
    server_pre_start
fi
    ;;

    2)
    running_vars
    if [ -z "${RUNNING_VMS}" ]; then
    echo -e "There are no Virtual Machines running"
    echo
    r=yes
else
    server_pre_stop
fi
    ;;

    3)
    running_vars
    check_running_vms
    ;;

    4)
    available_vars
    check_available_vms
    ;;

    c|C)
exit
    ;;

    *)
    echo -e "${RN} Invalid option ${RN}"
    r=yes
    ;;
esac
done