#!/usr/bin/env bash

wifi_interface=$(ip link show | grep -o '^[0-9]\+: [a-zA-Z0-9]\+: ' | grep -o '[a-zA-Z0-9]\+' | grep '3' | tail -n 1)
echo "*******************************************"
echo "\........................................./"
echo "  YOUR INTERFACE'NAME IS : $wifi_interface"
echo "..........................................."
echo "*******************************************"

if [[ -z "$1" ]]; then
    echo "Enter your new MAC address"
elif [[ ! "$1" =~ ^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$ ]]; then
    echo "Please provide a valid MAC address"
else
    new_mac_address="$1"
    echo "Setting new MAC address: $new_mac_address"
    sudo ip link set dev "$wifi_interface" down
    sudo ip link set dev "$wifi_interface" address "$new_mac_address"
    sudo ip link set dev "$wifi_interface" up

    if [[ $? -eq 0 ]]; then
        echo "MAC address changed successfully"
    else
        echo "Failed to change MAC address"
    fi
fi

echo "bye"

