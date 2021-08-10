#!/usr/bin/env bash

# these are functions are associated with vm_start_stop script

function server_pre_start() {

START_ARRAY=(
    ${START_AVAILABLE}
)

for i in "${START_ARRAY[@]}"
do
    read -p "Would you like to start-up VM: ${i}? (y/n) " yn
    case $yn in
    Y|y) start_server;;
    N|n|*) echo -e "${BA} ${i} skipped... ${BA}"
    esac
done 
    r=yes
}

function start_server() {
   
    EXEC="vmrun -T fusion start ${i} nogui"

    echo -e "${YE} Starting VM: ${i} ${YE}"
    ${EXEC} >/dev/null

if $EXEC; then
    echo -e "${GP} Start-up of VM: ${i} successful ${GP}"
    echo
else
    echo -e "${RN} VM: ${i} did not start successfully ${RN}"
    echo
fi
r=yes
}

function server_pre_stop() {

STOP_ARRAY=(
    ${RUNNING_VMS}
)

for i in "${STOP_ARRAY[@]}"
do
  
    read -rp "Would you like to stop VM: ${i}? (y/n) " yn
    case $yn in
    Y|y) stop_server;;
    N|n|*) echo -e "${BA} VM: ${i} skipped... ${BA}"
    esac
done
    r=yes
}

function stop_server() {
   
    EXEC="vmrun -T fusion stop ${i} soft"

    echo -e "${YE} Stopping VM: ${i} ${YE}"
    ${EXEC}

if [ $? == "0" ]; then
    echo -e "${GP} VM: ${i} stopped successfully ${GP}"
    echo
else
    echo -e "${RN} VM: ${i} did not stop successfully ${RN}"
fi
r=yes
}

function check_running_vms() {

    if [ "${RUNNING_VMS_NUM}" == 0 ]; then
    echo -e "There are no Virtual Machines running"
    echo
else
    echo -e "There are ${RUNNING_VMS_NUM} Virtual Machine(s) currently running:"
    echo -e ${RUNNING_VMS} | tr -s " " "\n" | sort -d
    echo
fi
r=yes
}

function check_available_vms() {
    
    if [ "${AVAILABLE_VMS_NUM}" == 0 ]; then
    echo -e "There are no Virtual Machines available"
    echo
else
    echo -e "There are ${AVAILABLE_VMS_NUM} Virtual Machine(s) currently available:"
    echo -e ${AVAILABLE_VMS} | tr -s " " "\n" | sort -d
    echo
fi
r=yes
}

function running_vars() {
    
    RUNNING_VMS_NUM=$(vmrun list | awk '{print $4}')
    RUNNING_VMS=$(vmrun list | awk '/.vmx/ {print}' | sort -d)
}

function available_vars() {
    
    START_AVAILABLE=$({ (find ~ -type f -name "*.vmx" 2>/dev/null | tr -d ' ') && (vmrun list | awk '/.vmx/ {print}'); } | sort -d | uniq -u)
}